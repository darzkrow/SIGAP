#!/bin/bash


# Verificar si el script se ejecuta con privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (root)"
  exit 1
fi



# Nombre del archivo del servicio
SERVICE_FILE="/etc/systemd/system/gunicorn.service"
SOCKET_FILE="/etc/systemd/system/gunicorn.socket"
# Contenido del servicio
SERVICE_CONTENT="[Unit]
Description=gunicorn daemon service
Requires=gunicorn.socket
After=network.target

[Service]
User=gfranco
Group=www-data
WorkingDirectory=/var/www/html/SIGAP
ExecStart=/var/www/html/SIGAP/venv/bin/gunicorn \\
          --access-logfile - \\
          --workers 3 \\
          --bind unix:/run/gunicorn.sock \\
          config.wsgi:application

[Install]
WantedBy=multi-user.target"


SOCKET_CONTENT="[Unit]
Description=Gunicorn.sock Live...!

[Socket]
ListenStream=/run/gunicorn.sock

[Install]
WantedBy=sockets.target"



# Escribir el contenido en el archivo del servicio
echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_FILE" > /dev/null
echo "$SOCKET_CONTENT" | sudo tee "$SOCKET_FILE" > /dev/null
# Recargar systemd para que reconozca el nuevo servicio
sudo systemctl daemon-reload

# Habilitar el servicio para que se inicie en el arranque
sudo systemctl enable gunicorn.service

# Iniciar el servicio
sudo systemctl start gunicorn.service

# Verificar el estado del servicio
sudo systemctl status gunicorn.service
