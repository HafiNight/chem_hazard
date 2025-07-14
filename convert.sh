#!/bin/bash

# Input and output file names
input_file="name.csv"
output_file="molecules_with_smiles.csv"

# Check if output file exists and remove it to avoid appending to old data
if [ -f "$output_file" ]; then
    rm "$output_file"
fi

# Read the input CSV file line by line
while IFS=, read -r molecule_name
do
    # Convert molecule name to SMILES using molconvert
    smiles=$(molconvert smiles -s "$molecule_name" 2>/dev/null)
    
    # Check if conversion was successful
    if [ -n "$smiles" ]; then
        echo "$molecule_name,$smiles" >> "$output_file"
    else
        echo "$molecule_name,Conversion Failed" >> "$output_file"
    fi
done < "$input_file"

echo "Conversion completed. Results saved in $output_file"
