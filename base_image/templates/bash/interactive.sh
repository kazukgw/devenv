response=

read -p "Enter name of output file [$filename] > " response
if [ -n "$response" ]; then
    filename="$response"
fi

if [ -f $filename ]; then
    echo -n "Output file exists. Overwrite? (y/n) > "
    read response
    if [ "$response" != "y" ]; then
        echo "Exiting program."
        exit 1
    fi
fi
