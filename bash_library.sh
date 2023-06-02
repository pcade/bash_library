#!/bin/bash

# ============================================================================
# Функция для проверки наличия файла
# ============================================================================
function check_file {
    local file_path=$1
    if [ -f "$file_path" ]; then
        echo "File exists."
    else
        echo "File does not exist."
    fi
}

# ============================================================================
# Функция для создания директории
# ============================================================================
# Функция для создания директории
function create_directory {
    local directory_path=$1
    if [ ! -d "$directory_path" ]; then
        mkdir -p "$directory_path"
        echo "Directory created."
    else
        echo "Directory already exists."
    fi
}

# ============================================================================
# Функция для получения случайного числа в заданном диапазоне
# ============================================================================
function get_random_number {
    local min=$1
    local max=$2
    local random_number=$((RANDOM % (max - min + 1) + min))
    echo "Random number: $random_number"
}