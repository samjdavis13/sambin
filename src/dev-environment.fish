#!/usr/local/bin/fish

set applicationsFolder "/Applications"
set apps "CodeKit" "Tower" "Transmit" "MAMP PRO"

# Functions

function __open_app
    set -l application $argv
    echo "Opening $application..."
    osascript -e "launch app \"$application\""
end

function __close_app
    set -l application $argv
    echo "Closing $application..."
    osascript -e "quit app \"$application\""
end

# Handle command line args
set -l mode open
while set -q argv[1]
    switch $argv[1]
        case '-h' '--help'
            __fish_print_help abbr
            exit
        case '-o' '--open'
            set mode add
        case '-c' '--close'
            set mode close
        case '*'
            __fish_print_help abbr
            exit
    end
    set -e argv[1]
end

# Run the app
for application in $apps
    switch $mode
        case 'open'
            __open_app "$application"
        case 'close'
            __close_app "$application"
    end
end