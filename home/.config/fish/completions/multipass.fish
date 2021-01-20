function __fish_no_subcommand
    test (count (commandline -poc)) -eq 1
end

function __fish_list_multipass_instance_names
    multipass list --format=json | jq -r '.list[].name'
end

complete -c multipass -f

complete -c multipass -n "__fish_no_subcommand" -a delete -d "Delete instances"
complete -c multipass -n "__fish_seen_subcommand_from delete" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from delete" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from delete" -l all -d "Delete all instances"
complete -c multipass -n "__fish_seen_subcommand_from delete" -s p -l purge -d "Purge instances immediately"
complete -c multipass -n "__fish_seen_subcommand_from delete" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a exec -d "Run a command on an instance"
complete -c multipass -n "__fish_seen_subcommand_from exec" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from exec" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from exec" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a find -d "Display available images to create instances from"
complete -c multipass -n "__fish_seen_subcommand_from find" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from find" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from find" -l show-unsupported -d "Show unsupported cloud images as well"
complete -c multipass -n "__fish_seen_subcommand_from find" -l format -d "Output list in the requested format. Valid formats are: table (default), json, csv and yaml"

complete -c multipass -n "__fish_no_subcommand" -a get -d "Get a configuration setting"
complete -c multipass -n "__fish_seen_subcommand_from get" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from get" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from get" -l raw -d 'Output in raw format. For now, this affects only the representation of empty values (i.e. "" instead of "<empty>").'

complete -c multipass -n "__fish_no_subcommand" -a help -d "Display help about a command"
complete -c multipass -n "__fish_seen_subcommand_from help" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from help" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from help" -a "delete exec find get help info launch list mount purge recover restart set shell start stop suspend transfer umount version"

complete -c multipass -n "__fish_no_subcommand" -a info -d "Display information about instances"
complete -c multipass -n "__fish_seen_subcommand_from info" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from info" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from info" -l all -d "Display info for all instances"
complete -c multipass -n "__fish_seen_subcommand_from info" -l format -d "Output info in the requested format. Valid formats are: table (default), json, csv and yaml"

complete -c multipass -n "__fish_no_subcommand" -a launch -d "Create and start an Ubuntu instance"
complete -c multipass -n "__fish_seen_subcommand_from launch" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from launch" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from launch" -s c -l cpus -d "Number of CPUs to allocate. Minimum: 1, default: 1."
complete -c multipass -n "__fish_seen_subcommand_from launch" -s d -l disk -d "Disk space to allocate. Positive integers, in bytes, or with K, M, G suffix. Minimum: 512M, default: 5G."
complete -c multipass -n "__fish_seen_subcommand_from launch" -s m -l mem -d "Amount of memory to allocate. Positive integers, in bytes, or with K, M, G suffix. Minimum: 128M, default: 1G."
complete -c multipass -n "__fish_seen_subcommand_from launch" -s n -l name -d "Name for the instance. If it is 'primary' (the configured primary instance name), the user's home directory is mounted inside the newly launched instance, in 'Home'."
complete -c multipass -n "__fish_seen_subcommand_from launch" -l cloud-init -d "Path to a user-data cloud-init configuration, or '-' for stdin"

complete -c multipass -n "__fish_no_subcommand" -a list -d "List all available instances"
complete -c multipass -n "__fish_seen_subcommand_from list" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from list" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from list" -l format -d "Output list in the requested format. Valid formats are: table (default), json, csv and yaml"

complete -c multipass -n "__fish_no_subcommand" -a mount -d "Mount a local directory in the instance"
complete -c multipass -n "__fish_seen_subcommand_from mount" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from mount" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from mount" -s g -l gid-map -d "A mapping of group IDs for use in the mount. File and folder ownership will be mapped from <host> to <instance> inside the instance. Can be used multiple times."
complete -c multipass -n "__fish_seen_subcommand_from mount" -s u -l uid-map -d "A mapping of user IDs for use in the mount. File and folder ownership will be mapped from <host> to <instance> inside the instance. Can be used multiple times."

complete -c multipass -n "__fish_no_subcommand" -a purge -d "Purge all deleted instances permanently"
complete -c multipass -n "__fish_seen_subcommand_from purge" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from purge" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."

complete -c multipass -n "__fish_no_subcommand" -a recover -d "Recover deleted instances"
complete -c multipass -n "__fish_seen_subcommand_from recover" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from recover" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from recover" -l all -d "Recover all deleted instances"
complete -c multipass -n "__fish_seen_subcommand_from recover" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a restart -d "Restart instances"
complete -c multipass -n "__fish_seen_subcommand_from restart" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from restart" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from restart" -l all -d "Restart all instances"
complete -c multipass -n "__fish_seen_subcommand_from restart" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a set -d "Set a configuration setting"
complete -c multipass -n "__fish_seen_subcommand_from set" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from set" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."

complete -c multipass -n "__fish_no_subcommand" -a shell -d "Open a shell on a running instance"
complete -c multipass -n "__fish_seen_subcommand_from shell" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from shell" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from shell" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a start -d "Start instances"
complete -c multipass -n "__fish_seen_subcommand_from start" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from start" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from start" -l all -d "Start all instances"
complete -c multipass -n "__fish_seen_subcommand_from start" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a stop -d "Stop running instances"
complete -c multipass -n "__fish_seen_subcommand_from stop" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from stop" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from stop" -l all -d "Stop all instances"
complete -c multipass -n "__fish_seen_subcommand_from stop" -s t -l time -d "Time from now, in minutes, to delay shutdown of the instance"
complete -c multipass -n "__fish_seen_subcommand_from stop" -s c -l cancel -d "Cancel a pending delayed shutdown"
complete -c multipass -n "__fish_seen_subcommand_from stop" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a suspend -d "Suspend running instances"
complete -c multipass -n "__fish_seen_subcommand_from suspend" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from suspend" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
complete -c multipass -n "__fish_seen_subcommand_from suspend" -l all -d "Suspend all instances"
complete -c multipass -n "__fish_seen_subcommand_from suspend" -a "(__fish_list_multipass_instance_names)"

complete -c multipass -n "__fish_no_subcommand" -a transfer -d "Transfer files between the host and instances"
complete -c multipass -n "__fish_seen_subcommand_from transfer" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from transfer" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."

complete -c multipass -n "__fish_no_subcommand" -a umount -d "Unmount a directory from an instance"
complete -c multipass -n "__fish_seen_subcommand_from umount" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from umount" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."

complete -c multipass -n "__fish_no_subcommand" -a version  -d "Show version details"
complete -c multipass -n "__fish_seen_subcommand_from version" -s h -l help -d "Display this help"
complete -c multipass -n "__fish_seen_subcommand_from version" -s v -l verbose -d "Increase logging verbosity. Repeat the 'v' in the short option for more detail. Maximum verbosity is obtained with 4 (or more) v's, i.e. -vvvv."
