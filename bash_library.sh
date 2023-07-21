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

# ============================================================================
# Функция для копирования файлов по пользователю
# ============================================================================
function copy_bash {
    #Создать скрипт ownersort.sh, который в заданной папке копирует файлы в директории, названные по имени владельца каждого файла.
    #Учтите, что файл должен принадлежать соответствующему владельцу. 

    cd /home && ls > /home/exampleWAY/filename # смотрю всех user через ls в home и передаю полученный результат в файл
    users=/home/exampleWAY/filename # присваиваю файлу переменную для удабства использования 
    cd -  # спускаюсь в начальную дирректорию где будет происходить процесс
    total=$(cat $users | wc -l) # подсчитываю колличество user
    counter=0
    while [ $counter -lt $total ]; do # вывожу конкретную строку с именем user
    	let counter+=1 # щётчик
    	name=$(sed -n "$counter"p $users) # вывожу имя пользователя
    	finder=$(ls -l | grep $name | tr -s ' ' '\t' | cut -f '9 9') # выделяю файлы принадлежащие конкретному пользователю
    	cp ~/$finder ~/home/$name/ # записываю файлы в дирректорию конкретного пользователя
    done
}

# ============================================================================
# Функция на подключение по списку ip адрессов заранее вложенных в txt файлу с дальнейшей проведением конфигурации, root passwd статичны
# ============================================================================
function ansible_bash {
    USR=exampleUSERname		# статичный user
    PASSWD=exampleSTATICpassword		# статичный пароль

    IP=/home/yourdirectory/IPlist.txt		#назначаю переменной адресс на каталог с ip адрессами
    COUNTER=0		# создаю счётчик для будущего цикла
    total=$(cat $IP | wc -l)		# подсчитываю колличество строк с ip адрессами в переданному файле
    while [ $COUNTER -lt $total ];do 		# запускаю цикл на колличество ip адрессов
    	let COUNTER+=1		# счётчик прибавляет по одному пока не станет равным колличеству ip адрессов
    	NAME_IP=$(sed -n "$COUNTER"p $IP)		# присваиваю айпи адресс 
    	sshpass -p $PASSWD ssh $USR@$NAME_IP 'mkdir forEXAMPLE;echo "hello;exit"' #как указанно в ковычках по примеру указать необходимые команды 	# подключаюсь по sshpass
    done
}

# ============================================================================
# Функция для создания снифера
# ============================================================================

function sniffer {
    $USER='whoami'

    sudo echo -e '#!/bin/bash/\n\nsudo tcpdump -i any -nn src host your-ip or dst host your-ip' > /home/$USER/sniffer.sh
    sudo chmod 755 /home/$USER/sniffer.sh
    sudo echo -e '[Unit]\nDescription=Sniffer\n\n[Service]\nExecStart=/home/$USER/sniffer.sh\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/sniffer.service
    sudo systemctl daemon-reload
    sudo systemctl enable sniffer.service
}