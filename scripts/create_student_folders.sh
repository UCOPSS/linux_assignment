#!/bin/bash

# Arahan 1: Laluan ke fail data input student_list.txt
INPUT_FILE="$HOME/linux_assignment/student_list.txt"

# Arahan 2: Laluan untuk folder utama student_submissions/
SUBMISSIONS_DIR="$HOME/linux_assignment/student_submissions"
LOG_FILE="$HOME/linux_assignment/logs/folder_creation.log"

# Semak jika fail input wujud (Error Handling)
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file missing!"
    exit 1
fi

# Arahan 2: Cipta folder student_submissions jika belum ada
mkdir -p "$SUBMISSIONS_DIR"

total_students=0
declare -A unique_groups

# Baca fail data baris demi baris menggunakan kaedah pemisah Tab ($'\t')
while IFS=$'\t' read -r no matric name class group_num || [ -n "$no" ]; do
    
    # Buang ruang kosong yang tidak sengaja tertekan (Trimming)
    no=$(echo "$no" | xargs)
    matric=$(echo "$matric" | xargs)
    group_num=$(echo "$group_num" | xargs)
    
    # Tapis baris tajuk (Header) supaya tidak diproses menjadi folder
    if [ "$no" == "No" ] || [ -z "$matric" ] || [ -z "$group_num" ]; then
        continue
    fi
    
    # Arahan 3a: Format nama folder Kumpulan (Group) dengan underscore
    GROUP_FOLDER="Group_${group_num}"
    
    # Arahan 3b: Gabungkan folder Group dengan subfolder Matric Number di dalamnya
    TARGET_PATH="$SUBMISSIONS_DIR/$GROUP_FOLDER/$matric"
    
    # Cipta folder beranak-pinak (-p bermaksud parent directory automatik dicipta)
    mkdir -p "$TARGET_PATH"
    
    # Simpan log aktiviti
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Created folder: $TARGET_PATH" >> "$LOG_FILE"
    
    ((total_students++))
    unique_groups["$GROUP_FOLDER"]=1

done < "$INPUT_FILE"

# Cetak ringkasan proses di terminal (Additional Feature)
echo "=========================================="
echo "          PROCESS SUMMARY"
echo "=========================================="
echo "Total students processed : $total_students"
echo "Number of groups created : ${#unique_groups[@]}"
echo "List of all groups created:"
for grp in "${!unique_groups[@]}"; do
    echo " - $grp"
done
echo "=========================================="
