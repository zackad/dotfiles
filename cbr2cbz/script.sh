#!/usr/bin/env sh

# Check if unrar-free and zip commands are installed
if ! command -v unrar-free &> /dev/null || ! command -v zip &> /dev/null; then
    echo "Error: unrar-free or zip is not installed. Please install them first."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input.cbr>"
    exit 1
fi

# Get the input CBR file
input_cbr="$1"

# Check if the input file exists
if [ ! -e "$input_cbr" ]; then
    echo "Error: Input file '$input_cbr' not found."
    exit 1
fi

# Extract the contents of the CBR file into a temporary directory
temp_dir=$(mktemp -d)
unrar-free x "$input_cbr" "$temp_dir"

# Create a CBZ file using the extracted contents
output_cbz="$(pwd)/${input_cbr%.*}.cbz"
(cd "$temp_dir" && zip -r "$output_cbz" *)

# Check if the zip operation was successful
if [ $? -eq 0 ]; then
  # Remove the temporary directory
  rm -r "$temp_dir"
  echo "CBZ file created: $output_cbz"
else
  echo "Error: Failed to create the CBZ file."
fi
