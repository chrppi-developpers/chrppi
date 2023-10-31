script_folder="/home/quentin/MEGA/MEGAsync/cours_fac/M2_Informatique/Projet_Annuel/Github/chrppi/app/build/build/Debug/generators"
echo "echo Restoring environment" > "$script_folder/../../../build/Debug/generators/deactivate_conanrunenv-debug-x86_64.sh"
for v in OPENSSL_MODULES
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/../../../build/Debug/generators/deactivate_conanrunenv-debug-x86_64.sh"
    else
        echo unset $v >> "$script_folder/../../../build/Debug/generators/deactivate_conanrunenv-debug-x86_64.sh"
    fi
done


export OPENSSL_MODULES="/home/quentin/.conan2/p/b/opens195d8706f0993/p/lib/ossl-modules"