#!/bin/bash

# Prompt user for input
read -p "What is the image that you would like to add jupyter to? " docker_image
read -p "What name/tag would you like for the new image? " new_image

# Paths to the files
makefile="./Makefile"
dockerfile="./Dockerfile"

# Copy files
cp $makefile.template $makefile
cp $dockerfile.template $dockerfile

entrypoint=""
entrypoint_string=$(docker inspect --format '{{json .Config.Entrypoint}}' "$docker_image")
if [ "$entrypoint_string" != "null" ]; then
    entrypoint_string="${entrypoint_string#[}"
    entrypoint_string="${entrypoint_string%]}"
    IFS=', ' read -r -a entrypoint_array <<< "$entrypoint_string"
    for element in "${entrypoint_array[@]}"; do
        entrypoint+=", $element"
    done
fi

cmd=""
cmd_string=$(docker inspect --format '{{json .Config.Cmd}}' "$docker_image")
if [ "$cmd_string" != "null" ]; then
    cmd="CMD $cmd_string"
fi

# echo $entrypoint
# echo $entrypoint_string
# exit 1

# Replace placeholders in Dockerfile file using | as delimiter
sed -i "" "s|<<docker_image>>|$docker_image|g" $dockerfile
sed -i "" "s|<<entrypoint>>|$entrypoint|g" $dockerfile
sed -i "" "s|<<cmd>>|$cmd|g" $dockerfile

# Replace placeholders in Makefile file using | as delimiter
sed -i "" "s|<<new_image>>|$new_image|g" $makefile


echo "Placeholder values have been replaced!"
echo "Remember to expose port 4200 to get access to Jupyter in the container."
