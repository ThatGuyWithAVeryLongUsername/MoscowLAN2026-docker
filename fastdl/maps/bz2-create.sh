#!/usr/bin/env bash

# Переходим в текущую директорию (предполагается, что скрипт лежит в папке с картами)
MAPS_DIR="."

echo "Начинаем сжатие карт в bz2 для FastDL..."

for bsp in "$MAPS_DIR"/*.bsp; do
    # Проверяем, есть ли файлы .bsp
    [ -e "$bsp" ] || continue

    bz2_file="${bsp}.bz2"

    # Если сжатая версия уже существует, пропускаем (чтобы не перепаковывать заново)
    if [ -f "$bz2_file" ]; then
        echo "Пропуск (уже сжато): $(basename "$bsp")"
        continue
    fi

    echo "Сжимаем: $(basename "$bsp")..."
    
    # Создаем сжатую копию с помощью bzip2 (-k оставляет оригинал, -9 включает максимальное сжатие)
    bzip2 -k -9 "$bsp"

    if [ $? -eq 0 ]; then
        echo " [Готово] Создан $(basename "$bz2_file")"
    else
        echo " [Ошибка] Не удалось сжать $(basename "$bsp")"
    fi

done

echo "Всё! Теперь файлы .bsp (для сервера) и .bsp.bz2 (для FastDL) находятся на своих местах."