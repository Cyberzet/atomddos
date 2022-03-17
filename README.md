# atomddos
_
## Порядок  установки для Linux(Ubuntu):
1.  Запускаем Terminal и заходим в домашнюю папку
cd ~
2.  Скачиваем архив 
wget  https://github.com/Cyberzet/atomddos/archive/refs/heads/linux.zip
3.   Распаковываем архив и переходим в паку с ПО
```
unzip linux.zip
```
```
cd ~/atomddos-linux
```

4.  Устанавливаем права на запуск и запускаем установку необходимых программ
```
chmod 777 os*
```
```
sudo ./osVoboditel-preapre.sh 
```

5.  В случае если система выдаст ошибку запуска сервиса docker перезапускаем компьютер
reboot


Порядок  запуска для Linux(Ubuntu):
1.  Запускаем Terminal и заходим в папку запуска ПО
cd ~/atomddos-limux
2.  Запускаем ПО
sudo ./osVoboditel.sh
