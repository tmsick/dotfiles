function __fish_subcommand_satisfies
    set -l cmd (commandline -poc)
    set -e cmd[1]
    set -l len (count $argv)

    if test (count $cmd) -lt $len
        return 1
    end

    for i in (seq $len)
        if test $cmd[$i] != $argv[$i]
            return 1
        end
    end

    return 0
end

function __fish_subcommand_is
    set -l cmd (commandline -poc)
    set -e cmd[1]

    if test (count $cmd) -ne (count $argv)
        return 1
    end

    __fish_subcommand_satisfies $argv
end

function __fish_no_subcommand
    set -l cmd (commandline -poc)
    set -e cmd[1]
    test (count $cmd) -eq 0
end

complete -c bw -f

set -l completion_shells zsh

# Options ----------------------------------------------------------------------
complete -c bw -l pretty -d 'Format output. JSON is tabbed with two spaces.'
complete -c bw -l raw -d 'Return raw output instead of a descriptive message.'
complete -c bw -l response -d 'Return a JSON formatted version of response output.'
complete -c bw -l cleanexit -d 'Exit with a success exit code (0) unless an error is thrown.'
complete -c bw -l quiet -d 'Don\'t return anything to stdout.'
complete -c bw -l session -d 'Pass session key instead of reading from env.'
complete -c bw -s v -l version -d 'output the version number'
complete -c bw -s h -l help -d 'display help for command'

# Subcommands ------------------------------------------------------------------
# login
complete -c bw -n __fish_no_subcommand -a login -d 'Log into a user account.'
complete -c bw -n '__fish_subcommand_satisfies login' -l method -d 'Two-step login method.'
complete -c bw -n '__fish_subcommand_satisfies login' -l code -d 'Two-step login code.'
complete -c bw -n '__fish_subcommand_satisfies login' -l sso -d 'Log in with Single-Sign On.'
complete -c bw -n '__fish_subcommand_satisfies login' -l apikey -d 'Log in with an Api Key.'
complete -c bw -n '__fish_subcommand_satisfies login' -l passwordenv -d 'Environment variable storing your password'
complete -c bw -n '__fish_subcommand_satisfies login' -l passwordfile -d 'Path to a file containing your password as its first line'
complete -c bw -n '__fish_subcommand_satisfies login' -l check -d 'Check login status.'
# logout
complete -c bw -n __fish_no_subcommand -a logout -d 'Log out of the current user account.'
# lock
complete -c bw -n __fish_no_subcommand -a lock -d 'Lock the vault and destroy active session keys.'
# unlock
complete -c bw -n __fish_no_subcommand -a unlock -d 'Unlock the vault and return a new session key.'
complete -c bw -n '__fish_subcommand_satisfies unlock' -l check -d 'Check lock status.'
complete -c bw -n '__fish_subcommand_satisfies unlock' -l passwordenv -a '(set -nx)' -d 'Environment variable storing your password'
complete -c bw -n '__fish_subcommand_satisfies unlock' -l passwordfile -a '(ls -A)' -d 'Path to a file containing your password as its first line'
# sync
complete -c bw -n __fish_no_subcommand -a sync -d 'Pull the latest vault data from server.'
complete -c bw -n '__fish_subcommand_satisfies sync' -s f -l force -d 'Force a full sync.'
complete -c bw -n '__fish_subcommand_satisfies sync' -l last -d 'Get the last sync date.'
# generate
complete -c bw -n __fish_no_subcommand -a generate -d 'Generate a password/passphrase.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s u -l uppercase -d 'Include uppercase characters.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s l -l lowercase -d 'Include lowercase characters.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s n -l number -d 'Include numeric characters.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s s -l special -d 'Include special characters.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s p -l passphrase -d 'Generate a passphrase.'
complete -c bw -n '__fish_subcommand_satisfies generate' -l length -d 'Length of the password.'
complete -c bw -n '__fish_subcommand_satisfies generate' -l words -d 'Number of words.'
complete -c bw -n '__fish_subcommand_satisfies generate' -l separator -d 'Word separator.'
complete -c bw -n '__fish_subcommand_satisfies generate' -s c -l capitalize -d 'Title case passphrase.'
complete -c bw -n '__fish_subcommand_satisfies generate' -l includeNumber -d 'Passphrase includes number.'
# encode
complete -c bw -n __fish_no_subcommand -a encode -d 'Base 64 encode stdin.'
# config
complete -c bw -n __fish_no_subcommand -a config -d 'Configure CLI settings.'
complete -c bw -n '__fish_subcommand_is config' -a server -d 'On-premises hosted installation URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l web-vault -d 'Provides a custom web vault URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l api -d 'Provides a custom API URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l identity -d 'Provides a custom identity URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l icons -d 'Provides a custom icons service URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l notifications -d 'Provides a custom notifications URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l events -d 'Provides a custom events URL that differs from the base URL.'
complete -c bw -n '__fish_subcommand_satisfies config' -l key-connector -d 'Provides the URL for your Key Connector server.'
# update
complete -c bw -n __fish_no_subcommand -a update -d 'Check for updates.'
# completion
complete -c bw -n __fish_no_subcommand -a completion -d 'Generate shell completions.'
complete -c bw -n '__fish_subcommand_is completion' -l shell -a $completion_shells
# status
complete -c bw -n __fish_no_subcommand -a status -d 'Show server, last sync, user information, and vault status.'
# list
complete -c bw -n __fish_no_subcommand -a list -d 'List an array of objects from the vault.'
complete -c bw -n '__fish_subcommand_is list' -a 'items folders collections org-collections org-members organizations'
complete -c bw -n '__fish_subcommand_satisfies list' -l search -d 'Perform a search on the listed objects.'
complete -c bw -n '__fish_subcommand_satisfies list' -l url -d 'Filter items of type login with a url-match search.'
complete -c bw -n '__fish_subcommand_satisfies list' -l folderid -d 'Filter items by folder id.'
complete -c bw -n '__fish_subcommand_satisfies list' -l collectionid -d 'Filter items by collection id.'
complete -c bw -n '__fish_subcommand_satisfies list' -l organizationid -d 'Filter items or collections by organization id.'
complete -c bw -n '__fish_subcommand_satisfies list' -l trash -d 'Filter items that are deleted and in the trash.'
# get
complete -c bw -n __fish_no_subcommand -a get -d 'Get an object from the vault.'
complete -c bw -n '__fish_subcommand_is get' -a 'item username password uri totp notes exposed attachment folder collection org-collection organization template fingerprint send'
complete -c bw -n '__fish_subcommand_satisfies get' -l itemid -d 'Attachment\'s item id.'
complete -c bw -n '__fish_subcommand_satisfies get' -l output -d 'Output directory or filename for attachment.'
complete -c bw -n '__fish_subcommand_satisfies get' -l organizationid -d 'Organization id for an organization object.'
# create
complete -c bw -n __fish_no_subcommand -a create -d 'Create an object in the vault.'
complete -c bw -n '__fish_subcommand_is create' -a 'item attachment folder org-collection'
complete -c bw -n '__fish_subcommand_satisfies create' -l file -d 'Path to file for attachment.'
complete -c bw -n '__fish_subcommand_satisfies create' -l itemid -d 'Attachment\'s item id.'
complete -c bw -n '__fish_subcommand_satisfies create' -l organizationid -d 'Organization id for an organization object.'
# edit
complete -c bw -n __fish_no_subcommand -a edit -d 'Edit an object from the vault.'
complete -c bw -n '__fish_subcommand_is edit' -a 'item item-collections folder org-collection'
complete -c bw -n '__fish_subcommand_satisfies edit' -l organizationid -d 'Organization id for an organization object.'
# delete
complete -c bw -n __fish_no_subcommand -a delete -d 'Delete an object from the vault.'
complete -c bw -n '__fish_subcommand_is delete' -a 'item attachment folder org-collection'
complete -c bw -n '__fish_subcommand_satisfies delete' -l itemid -d 'Attachment\'s item id.'
complete -c bw -n '__fish_subcommand_satisfies delete' -l organizationid -d 'Organization id for an organization object.'
complete -c bw -n '__fish_subcommand_satisfies delete' -s p -l permanent -d 'Permanently deletes the item instead of soft-deleting it (item only).'
# restore
complete -c bw -n __fish_no_subcommand -a restore -d 'Restores an object from the trash.'
complete -c bw -n '__fish_subcommand_is restore' -a item
# move
complete -c bw -n __fish_no_subcommand -a move -d 'Move an item to an organization.'
# confirm
complete -c bw -n __fish_no_subcommand -a confirm -d 'Confirm an object to the organization.'
complete -c bw -n '__fish_subcommand_is confirm' -a org-member
complete -c bw -n '__fish_subcommand_satisfies confirm' -l organizationid -d 'Organization id for an organization object.'
# import
complete -c bw -n __fish_no_subcommand -a import -d 'Import vault data from a file.'
complete -c bw -n '__fish_subcommand_is import' -a '1password1pif 1passwordmaccsv 1passwordwincsv ascendocsv avastcsv avastjson aviracsv bitwardencsv bitwardenjson blackberrycsv blurcsv buttercupcsv chromecsv clipperzhtml codebookcsv dashlanejson encryptrcsv enpasscsv enpassjson firefoxcsv fsecurefsk gnomejson kasperskytxt keepass2xml keepassxcsv keepercsv lastpasscsv logmeoncecsv meldiumcsv msecurecsv mykicsv nordpasscsv operacsv padlockcsv passboltcsv passkeepcsv passmanjson passpackcsv passwordagentcsv passwordbossjson passworddragonxml passwordwallettxt pwsafexml remembearcsv roboformcsv safaricsv safeincloudxml saferpasscsv securesafecsv splashidcsv stickypasswordxml truekeycsv upmcsv vivaldicsv yoticsv zohovaultcsv'
complete -c bw -n '__fish_subcommand_is import 1password1pif' -F
complete -c bw -n '__fish_subcommand_is import 1passwordmaccsv' -F
complete -c bw -n '__fish_subcommand_is import 1passwordwincsv' -F
complete -c bw -n '__fish_subcommand_is import ascendocsv' -F
complete -c bw -n '__fish_subcommand_is import avastcsv' -F
complete -c bw -n '__fish_subcommand_is import avastjson' -F
complete -c bw -n '__fish_subcommand_is import aviracsv' -F
complete -c bw -n '__fish_subcommand_is import bitwardencsv' -F
complete -c bw -n '__fish_subcommand_is import bitwardenjson' -F
complete -c bw -n '__fish_subcommand_is import blackberrycsv' -F
complete -c bw -n '__fish_subcommand_is import blurcsv' -F
complete -c bw -n '__fish_subcommand_is import buttercupcsv' -F
complete -c bw -n '__fish_subcommand_is import chromecsv' -F
complete -c bw -n '__fish_subcommand_is import clipperzhtml' -F
complete -c bw -n '__fish_subcommand_is import codebookcsv' -F
complete -c bw -n '__fish_subcommand_is import dashlanejson' -F
complete -c bw -n '__fish_subcommand_is import encryptrcsv' -F
complete -c bw -n '__fish_subcommand_is import enpasscsv' -F
complete -c bw -n '__fish_subcommand_is import enpassjson' -F
complete -c bw -n '__fish_subcommand_is import firefoxcsv' -F
complete -c bw -n '__fish_subcommand_is import fsecurefsk' -F
complete -c bw -n '__fish_subcommand_is import gnomejson' -F
complete -c bw -n '__fish_subcommand_is import kasperskytxt' -F
complete -c bw -n '__fish_subcommand_is import keepass2xml' -F
complete -c bw -n '__fish_subcommand_is import keepassxcsv' -F
complete -c bw -n '__fish_subcommand_is import keepercsv' -F
complete -c bw -n '__fish_subcommand_is import lastpasscsv' -F
complete -c bw -n '__fish_subcommand_is import logmeoncecsv' -F
complete -c bw -n '__fish_subcommand_is import meldiumcsv' -F
complete -c bw -n '__fish_subcommand_is import msecurecsv' -F
complete -c bw -n '__fish_subcommand_is import mykicsv' -F
complete -c bw -n '__fish_subcommand_is import nordpasscsv' -F
complete -c bw -n '__fish_subcommand_is import operacsv' -F
complete -c bw -n '__fish_subcommand_is import padlockcsv' -F
complete -c bw -n '__fish_subcommand_is import passboltcsv' -F
complete -c bw -n '__fish_subcommand_is import passkeepcsv' -F
complete -c bw -n '__fish_subcommand_is import passmanjson' -F
complete -c bw -n '__fish_subcommand_is import passpackcsv' -F
complete -c bw -n '__fish_subcommand_is import passwordagentcsv' -F
complete -c bw -n '__fish_subcommand_is import passwordbossjson' -F
complete -c bw -n '__fish_subcommand_is import passworddragonxml' -F
complete -c bw -n '__fish_subcommand_is import passwordwallettxt' -F
complete -c bw -n '__fish_subcommand_is import pwsafexml' -F
complete -c bw -n '__fish_subcommand_is import remembearcsv' -F
complete -c bw -n '__fish_subcommand_is import roboformcsv' -F
complete -c bw -n '__fish_subcommand_is import safaricsv' -F
complete -c bw -n '__fish_subcommand_is import safeincloudxml' -F
complete -c bw -n '__fish_subcommand_is import saferpasscsv' -F
complete -c bw -n '__fish_subcommand_is import securesafecsv' -F
complete -c bw -n '__fish_subcommand_is import splashidcsv' -F
complete -c bw -n '__fish_subcommand_is import stickypasswordxml' -F
complete -c bw -n '__fish_subcommand_is import truekeycsv' -F
complete -c bw -n '__fish_subcommand_is import upmcsv' -F
complete -c bw -n '__fish_subcommand_is import vivaldicsv' -F
complete -c bw -n '__fish_subcommand_is import yoticsv' -F
complete -c bw -n '__fish_subcommand_is import zohovaultcsv' -F
complete -c bw -n '__fish_subcommand_satisfies import' -l formats -d 'List formats'
complete -c bw -n '__fish_subcommand_satisfies import' -l organizationid -d 'ID of the organization to import to.'
# export
complete -c bw -n __fish_no_subcommand -a export -d 'Export vault data to a CSV or JSON file.'
complete -c bw -n '__fish_subcommand_satisfies export' -l output -a '(ls -A)' -d 'Output directory or filename.'
complete -c bw -n '__fish_subcommand_satisfies export' -l format -a 'csv json encrypted_json' -d 'Export file format.'
complete -c bw -n '__fish_subcommand_satisfies export' -l organizationid -d 'Organization id for an organization.'
# send
complete -c bw -n __fish_no_subcommand -a send -d 'Work with Bitwarden sends. A Send can be quickly created using this command or subcommands can be used to fine-tune the Send'
complete -c bw -n '__fish_subcommand_satisfies send' -F
complete -c bw -n '__fish_subcommand_satisfies send' -s f -l file -d 'Specifies that <data> is a filepath'
complete -c bw -n '__fish_subcommand_satisfies send' -s d -l deleteInDays -d 'The number of days in the future to set deletion date, defaults to 7 (default: "7")'
complete -c bw -n '__fish_subcommand_satisfies send' -s a -l maxAccessCount -d 'The amount of max possible accesses.'
complete -c bw -n '__fish_subcommand_satisfies send' -l hidden -d 'Hide <data> in web by default. Valid only if --file is not set.'
complete -c bw -n '__fish_subcommand_satisfies send' -s n -l name -d 'The name of the Send. Defaults to a guid for text Sends and the filename for files.'
complete -c bw -n '__fish_subcommand_satisfies send' -l notes -d 'Notes to add to the Send.'
complete -c bw -n '__fish_subcommand_satisfies send' -l fullObject -d 'Specifies that the full Send object should be returned rather than just the access url.'
# receive
complete -c bw -n __fish_no_subcommand -a receive -d 'Access a Bitwarden Send from a url'
complete -c bw -n '__fish_subcommand_satisfies receive' -l password -d 'Password needed to access the Send.'
complete -c bw -n '__fish_subcommand_satisfies receive' -l passwordenv -a '(set -nx)' -d 'Environment variable storing the Send\'s password'
complete -c bw -n '__fish_subcommand_satisfies receive' -l passwordfile -a '(ls -A)' -d 'Path to a file containing the Sends password as its first line'
complete -c bw -n '__fish_subcommand_satisfies receive' -l obj -d 'Return the Send\'s json object rather than the Send\'s content'
complete -c bw -n '__fish_subcommand_satisfies receive' -l output -a '(ls -A)' -d 'Specify a file path to save a File-type Send to'
# help
complete -c bw -n __fish_no_subcommand -a help -d 'display help for command'
complete -c bw -n '__fish_subcommand_is help' -a login -d 'Log into a user account.'
complete -c bw -n '__fish_subcommand_is help' -a logout -d 'Log out of the current user account.'
complete -c bw -n '__fish_subcommand_is help' -a lock -d 'Lock the vault and destroy active session keys.'
complete -c bw -n '__fish_subcommand_is help' -a unlock -d 'Unlock the vault and return a new session key.'
complete -c bw -n '__fish_subcommand_is help' -a sync -d 'Pull the latest vault data from server.'
complete -c bw -n '__fish_subcommand_is help' -a generate -d 'Generate a password/passphrase.'
complete -c bw -n '__fish_subcommand_is help' -a encode -d 'Base 64 encode stdin.'
complete -c bw -n '__fish_subcommand_is help' -a config -d 'Configure CLI settings.'
complete -c bw -n '__fish_subcommand_is help' -a update -d 'Check for updates.'
complete -c bw -n '__fish_subcommand_is help' -a completion -d 'Generate shell completions.'
complete -c bw -n '__fish_subcommand_is help' -a status -d 'Show server, last sync, user information, and vault status.'
complete -c bw -n '__fish_subcommand_is help' -a list -d 'List an array of objects from the vault.'
complete -c bw -n '__fish_subcommand_is help' -a get -d 'Get an object from the vault.'
complete -c bw -n '__fish_subcommand_is help' -a create -d 'Create an object in the vault.'
complete -c bw -n '__fish_subcommand_is help' -a edit -d 'Edit an object from the vault.'
complete -c bw -n '__fish_subcommand_is help' -a delete -d 'Delete an object from the vault.'
complete -c bw -n '__fish_subcommand_is help' -a restore -d 'Restores an object from the trash.'
complete -c bw -n '__fish_subcommand_is help' -a move -d 'Move an item to an organization.'
complete -c bw -n '__fish_subcommand_is help' -a confirm -d 'Confirm an object to the organization.'
complete -c bw -n '__fish_subcommand_is help' -a import -d 'Import vault data from a file.'
complete -c bw -n '__fish_subcommand_is help' -a export -d 'Export vault data to a CSV or JSON file.'
complete -c bw -n '__fish_subcommand_is help' -a send -d 'Work with Bitwarden sends. A Send can be quickly created using this command or subcommands can be used to fine-tune the Send'
complete -c bw -n '__fish_subcommand_is help' -a receive -d 'Access a Bitwarden Send from a url'
