#!/bin/bash

# Define the base directory for the assignment
BASE_DIR="$HOME/linux_assignment"

# Define the directories to be created
DOC_DIR="$BASE_DIR/Documents"
IMG_DIR="$BASE_DIR/Images"
OTH_DIR="$BASE_DIR/Others"

# a. Create the folders inside linux_assignment/ if they do not exist
mkdir -p "$DOC_DIR" "$IMG_DIR" "$OTH_DIR"

# Initialize counters to keep track of moved files
moved_to_docs=0
moved_to_others=0
moved_to_images=0

# Check if the old 'documents' folder exists and has files to organize
if [ -d "$BASE_DIR/documents" ]; then
    
    # Loop through each file in the source directory
    for file in "$BASE_DIR/documents"/*; do
        
        # Prevent errors if the directory is completely empty
        [ -e "$file" ] || continue
        
        # Extract the file extension (e.g., txt, pdf, csv)
        ext="${file##*.}"
        
        # Sort files based on their extensions
        case "$ext" in
            # b. Move files with .txt, .md, .pdf -> Documents/
            txt|md|pdf)
                mv "$file" "$DOC_DIR/"
                ((moved_to_docs++))
                ;;
                
            # c. Move files with .csv, .conf -> Others/
            csv|conf)
                mv "$file" "$OTH_DIR/"
                ((moved_to_others++))
                ;;
                
            # Optional: Move image extensions if any exist (e.g., png, jpg)
            png|jpg|jpeg)
                mv "$file" "$IMG_DIR/"
                ((moved_to_images++))
                ;;
        esac
    done
fi

# d. Print a clean summary of the moved files
echo "=========================================="
echo "          FILE ORGANIZER SUMMARY"
echo "=========================================="
echo "Files moved to Documents/ : $moved_to_docs"
echo "Files moved to Others/    : $moved_to_others"
echo "Files moved to Images/    : $moved_to_images"
echo "=========================================="
