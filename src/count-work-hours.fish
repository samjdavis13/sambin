#!/usr/local/bin/fish

## Used to count up the number of hours logged
## 
## Usage:
##     - make sure to copy your hours note to the clipboard
##     - then run this script

# Get the current clipboard contents
set clipboard (pbpaste)

# Find each number to add up
for line in $clipboard
    
    # echo $line
    # Only match lines that match the following regex
    if echo $line | grep -Eq '^\d+\.\d'
        set hourLogs $hourLogs (echo $line)
    end

end

# Add up all the hours
set total 0
for hourLog in $hourLogs
    set total (math $total + $hourLog)
end

# Print out the calculated total
echo "$total"