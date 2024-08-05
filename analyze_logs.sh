#!/bin/bash

# Создание файла access.log
cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

# Подсчет общего количества запросов
total_requests=$(wc -l < access.log)

# Подсчет уникальных IP-адресов с использованием awk
unique_ips=$(awk '{print $1}' access.log | sort -u | wc -l)

# Подсчет количества запросов по методам с использованием awk
methods_count=$(awk '{gsub(/"/, ""); print $6}' access.log | sort | uniq -c)

# Поиск самого популярного URL с использованием awk
popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -n 1)

# Создание отчета в report.txt
{
    echo "Отчёт о логе веб-сервера"                                                                                                                    
    echo "=========================" 
    echo "Общее количество запросов: $total_requests"
    echo "Количество уникальных IP-адресов: $unique_ips"
    echo "Количество запросов по методам:"
    echo "$methods_count"
    echo "Самый популярный URL: $popular_url"
} > report.txt

echo "Отчёт сохранён в файл report.txt"
