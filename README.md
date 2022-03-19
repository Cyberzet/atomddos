# atomddos
## Порядок  установки для Linux(Ubuntu):
1.  Запускаем Terminal и заходим в домашнюю папку
```
cd ~
```
2.  Скачиваем архив 
```
wget  https://github.com/Cyberzet/atomddos/archive/refs/heads/linux.zip
```
3.   Распаковываем архив и переходим в паку с ПО
```
unzip linux.zip
```
```
cd ~/atomddos-linux
```
4.  Устанавливаем права на запуск
```
chmod 777 os*
```
Запускаем установку необходимых программ
```
sudo ./osVoboditel-prepare.sh 
```
5.  В случае если система выдаст ошибку запуска сервиса docker перезапускаем компьютер
(необязательно)
```
reboot
```
Если делали перезагрузку
Запускаем Terminal и заходим в папку запуска ПО
```
cd ~/atomddos-linux
```
и запускаем атаку
```
sudo ./osVoboditel.sh
```
Если не делали перезагрузку просто запускаем атаку
```
sudo ./osVoboditel.sh
```
