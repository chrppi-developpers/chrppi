script_folder="/home/quentin/MEGA/MEGAsync/cours_fac/M2_Informatique/Projet_Annuel/GithubV4/Github/chrppi/app/build/build/Debug/generators"
echo "echo Restoring environment" > "$script_folder/../../../build/Debug/generators/deactivate_conanbuildenv-debug-x86_64.sh"
for v in 
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/../../../build/Debug/generators/deactivate_conanbuildenv-debug-x86_64.sh"
    else
        echo unset $v >> "$script_folder/../../../build/Debug/generators/deactivate_conanbuildenv-debug-x86_64.sh"
    fi
done
