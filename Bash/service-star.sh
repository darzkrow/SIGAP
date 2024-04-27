#!/bin/bash

# Nombre del archivo
FILESERVICE="gunicorn.service"
FILESOCKET="gunicorn.socket"

URLS_SERVICE="https://github.com/darzkrow/SIGAP/blob/master/Bash/gunicorn.service"
URLS_SOCKET="https://github.com/darzkrow/SIGAP/blob/master/Bash/gunicorn.socket"

# Ruta completa del archivo en /etc/systemd/system/
SYSTEMD_PATH_SERVICE="/etc/systemd/system/$FILESERVICE"
SYSTEMD_PATH_SOCKET="/etc/systemd/system/$FILESOCKET"

# Verificar si el archivo ya existe en /etc/systemd/system/
if [ -f "$SYSTEMD_PATH_SOCKET=" ]; then
    echo "El archivo $FILESOCKET ya existe en $SYSTEMD_PATH_SOCKET"
else
    # URL del archivo en GitHub
    URL="$URLS_SOCKET/$FILESOCKET"
    
    # Descarga el archivo utilizando wget
    wget -O $SYSTEMD_PATH_SOCKET $URL

    echo "¡Archivo descargado exitosamente como $FILENAME en $SYSTEMD_PATH_SERVICE!"

     if systemctl is-enabled --quiet $FILESOCKET; then
        echo "El servicio $FILESOCKET ya está habilitado."
    else
        # Habilitar el servicio
        systemctl enable $FILESOCKET
        echo "¡El servicio $FILESOCKET ha sido habilitado!"
    fi
fi

if [ -f "$SYSTEMD_PATH_SERVICE" ]; then
    echo "El archivo $FILESERVICE ya existe en $SYSTEMD_PATH_SERVICE"
else
    # URL del archivo en GitHub
  URL="$URLS_SERVICE/$FILESERVICE"
    
    # Descarga el archivo utilizando wget
    wget -O $SYSTEMD_PATH_SERVICE $URL

    echo "¡Archivo descargado exitosamente como $FILENAME en $SSYSTEMD_PATH_SERVICE!"
     if systemctl is-enabled --quiet $FILESERVICE; then
        echo "El servicio $FILESERVICE ya está habilitado."
    else
        # Habilitar el servicio
        systemctl enable $FILESERVICE
        echo "¡El servicio $FILESERVICE ha sido habilitado!"
    fi
fi

