#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Chrpp files location
readonly source_path="$HOME/Documents/chrpp"
readonly build_path="$HOME/Documents/chrpp/build"

# Create pipes
[ -p cling_in ] && rm cling_in
[ -p cling_out ] && rm cling_out
mkfifo cling_in cling_out

# Open file descriptors
exec 3<> cling_in
exec 4<> cling_out

# Create the token used to mark the end of a cling output
readonly cling_out_end=$(uuidgen)

# Clean pipes and file descriptors at exit
function chrppi_ended
{
	# Close file descriptors
	exec 3>&-
	exec 4>&-

	# Remove pipes
	rm cling_in cling_out

	# Kill Cling process
	kill $cling_pid
}
trap chrppi_ended EXIT

# Run Cling in the background and link it to pipes
cling -D ENABLE_STATISTICS -fno-exceptions -fno-inline --nologo -std=c++17 -I "${source_path}/runtime" -I "${build_path}/runtime" -I "${build_path}/examples" < cling_in > cling_out &
readonly cling_pid=$!

# Exit script when cling exit
function cling_ended 
{
	if ! ps -p $cling_pid > /dev/null
	then	 
		exit
	fi
}
cling_ended

# Load iostream to output cling_out_end and for command "print" to work
echo '.L iostream' > cling_in

# Allow declaration shadowing
echo 'gClingOpts->AllowRedefinition = 1;' > cling_in

# Enable O3 optimization
echo '.O 3' > cling_in

# Load aguments if provided for chrppi scripts
if [ $# -gt 1 ]
then
	arguments="$(sed 's/[^ ]*/"&",/g' <<< ${@:2})"
	echo '.L vector' > cling_in
	echo '.L string' > cling_in
	echo -e "std::vector<std::string> args = {${arguments}\b};" > cling_in
fi

# Chrppi read–eval–print loop
define_space_file=''
stat_command=''
function chrppi_read_eval_print
{
	# Split user input int words
	old_IFS="$IFS"
	IFS=' '
	command=($1)
	IFS="$old_IFS"
	
	# Treat user input
	case ${command[0]} in

		# Load a CHR space
		.def)

			# Unload previous space files if they exists			
			if [ -f "$define_space_file" ]
			then
				echo ".U ${define_space_file}" > cling_in
				rm "$define_space_file"
			fi

			# Load space definition to Cling
			define_space_file=$(mktemp)
			${build_path}/chrppc/chrppc --stdout "${command[1]}" > $define_space_file
			cat <<-	EOF >> $define_space_file
					template <typename T>
					void print(T& pb)
					{
						auto it = pb.chr_store_begin();
						while (!it.at_end())
						{
							std::cout << it.to_string() << std::endl;
							++it;
						}
					}
			EOF
			echo ".L ${define_space_file}" > cling_in

			# Save the CHR space
			chr_space=$(cat "${command[1]}" | sed --quiet -E 's/.*<CHR name="(.*)".*/\1/p')

			# Create a space
			echo "auto space = ${chr_space}::create();" > cling_in
		;;

		# Load a CHR variable
		.var)
			if [ ${#command[@]} -gt 2 ]
			then
				echo "chr::Logical_var<${command[@]:2}> ${command[1]};" > cling_in
			fi
		;;

		# Print the current CHR store
		.store)
			echo "print(*space);" > cling_in
		;;

		.print)

			command_string=${command[@]:1}
			print_command='std::cout'
			print_argument=''
			string_end=false
			for (( i=0; i<${#command_string}; i++ ))
			do
				if [ $((i+1)) = ${#command_string} ]
				then
					print_argument+=${command_string:$i:1}
					string_end=true
				fi

				if [[ ${command_string:$i:1} = ' ' ||  $string_end = true ]]
				then
					if [[ ! ${print_argument:0:1} = '"' || $string_end = true ]]
					then
						print_command+=" << $print_argument"
						print_argument=''
						string_end=false
					else
						print_argument+=' '
					fi			
				elif [ ${command_string:$i:1} = '"' ]
				then
					if [ -z "$print_argument" ]
					then
						print_argument='"'
					else
						print_argument+='"'
						string_end=true
						continue
					fi
				else
					print_argument+=${command_string:$i:1}
				fi
			done
			echo "$print_command << std::endl;" > cling_in
		;;

		# Define, run or show CHR execution with statistics
		.stat)
			case "${command[1]}" in
				def)
					stat_command='CHR_RUN('
				;;
				run)
					echo "$stat_command)" > cling_in
					stat_command=''
				;;
				show)
					echo 'chr::Statistics::print(std::cout);' > cling_in
				;;
			esac
		;;

		# Execute C++
		.cpp)		
			echo ${command[@]:1} > cling_in
		;;

		# Show available commands
		.help)
			cat <<- EOF
				$(tput smul)Usage:$(tput rmul)

				$(tput bold).def$(tput sgr0) <file>
				    load a CHR space from file
				$(tput bold).var$(tput sgr0) <name> <type>
				    define a logical variable with the given name and type
				$(tput bold)<constraint>$(tput sgr0) <parameters>
				    load a CHR contraint with given parameters (literals or variables)
				$(tput bold).store$(tput sgr0)
				    print the current CHR store
				$(tput bold).print$(tput sgr0) <values>
				    print values
				$(tput bold).stat$(tput sgr0) [$(tput bold)def$(tput sgr0)|$(tput bold)run$(tput sgr0)|$(tput bold)show$(tput sgr0)]
					define, run or show CHR execution with statistics
				$(tput bold).cpp$(tput sgr0) <instruction>
				    execute given C++ instruction
				$(tput bold).help$(tput sgr0)
				    show available commands
			EOF
		;;

		# Execute a CHR constraint
		*)
			if [ -z "$stat_command" ]
			then
				echo "space->${command[0]}($(tr ' ' ',' <<< ${command[@]:1}));" > cling_in
			else
				stat_command+="space->${command[0]}($(tr ' ' ',' <<< ${command[@]:1}));"
			fi
		;;
	esac

	# Print cling output
	echo "std::cout << \"$cling_out_end\" << std::endl;" > cling_in
	while read cling_out_line < cling_out
	do
		if [ "$cling_out_line" = "$cling_out_end" ]
		then
			break
		else
			echo "$cling_out_line"
		fi 
	done

	# Detect if cling ended
	cling_ended
}

# Execute the chrppi script if provided
if [[ $# -gt 0 && -f "$1" ]]
then
	here_document=''
	echo "$(sed '/^\s*$/d' "$1")" | while read -e script_line
	do
		case ${script_line:0:1} in

			# script_line is a multiline command
			@)
				here_document_end=${script_line%.*}
				here_document=$(mktemp)
				while read -r here_document_line
				do
					if [ "$here_document_line" = ${here_document_end:1} ]
					then
						break
					else
						echo "$here_document_line" >> $here_document
					fi
				done
				chrppi_in="${script_line#$here_document_end} $here_document"
			;;

			# script_line is a comment
			'#')
				continue
			;;

			# script_line is a single line command
			*)
				chrppi_in="$script_line"
		esac
		
		#echo "$(tput bold)chrppi<$(tput sgr0) $chrppi_in"
		chrppi_read_eval_print "$chrppi_in"

		# Remove her document after use
		if [ -f "$here_document" ]
		then
			rm $here_document
		fi
	done

# Else, execute chrppi from user input
else
	while read -e -p "$(tput bold)chrppi<$(tput sgr0) " chrppi_in
	do
		chrppi_read_eval_print "$chrppi_in"
	done
fi