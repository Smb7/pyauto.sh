#!/bin/bash

# State to the user that it will look for an app.py
echo "This script will look for an app.py file or another Python file you specify."

while true; do
    # Prompt the user for the file path
    read -p "Enter file path: " filepath

    # Echo the entered file path
    echo -e "\nFile path you have entered: $filepath"

    # Attempt to change directory to the entered file path
    if cd "$filepath"; then
        echo "Successfully changed directory to $filepath"
    else
        echo "Failed to change directory to $filepath"
        read -p "Would you like to try again? (yes/no): " usr
        if [[ "$usr" != "yes" && "$usr" != "y" ]]; then
            echo "Exiting script."
            exit 1
        else
            continue
        fi
    fi

    while true; do
        # Prompt the user for the Python file name
        read -p "Enter Python file name you would like to run: " pyfile

        # Echo the entered Python file name
        echo -e "\nFile you entered is: $pyfile"

        # Attempt to run the Python file with python or python3
        if command -v python &> /dev/null; then
            python "$pyfile"
        elif command -v python3 &> /dev/null; then
            python3 "$pyfile"
        else
            echo "Python is not installed or not in PATH."
            exit 1
        fi

        # Check if the Python file ran successfully
        if [[ $? -eq 0 ]]; then
            echo "Successfully ran $pyfile"
            break 2  # Break out of both loops
        else
            echo "Failed to run file $pyfile"
            read -p "Would you like to try again? (yes/no): " usr
            if [[ "$usr" != "yes" && "$usr" != "y" ]]; then
                echo "Exiting script."
                exit 1
            fi
        fi
    done
done

