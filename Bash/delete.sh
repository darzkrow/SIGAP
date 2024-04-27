#!/bin/bash
# Verificar si el script se ejecuta con privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (root)"
  exit 1
fi
# Detener el servicio si está en ejecución
sudo systemctl stop gunicorn.socket
sudo systemctl stop gunicorn.service

# Deshabilitar el servicio para que no se inicie en el arranque
sudo systemctl disable gunicorn.service

# Eliminar el archivo del servicio
sudo rm /etc/systemd/system/gunicorn.service
sudo rm /etc/systemd/system/gunicorn.socket
# Recargar systemd para que reconozca los cambios
sudo systemctl daemon-reload

# Reiniciar el servicio systemd para que aplique los cambios
sudo systemctl reset-failed

# Verificar que el servicio ya no está presente
sudo systemctl status gunicorn.socket
sudo systemctl status gunicorn.service

echo "El servicio de Gunicorn ha sido eliminado correctamente."
