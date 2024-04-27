#!/bin/bash

# Verificar si el script se ejecuta con privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (root)"
  exit 1
fi

# Actualizar los repositorios e instalar sudo
apt update && apt install -y sudo

# Nombre de usuario y contraseña
USERNAME="gfranco2"
PASSW="123456789"

# Crear el usuario con contraseña
useradd -m -p $(openssl passwd -1 "$PASSW") "$USERNAME"

# Verificar si el usuario se creó exitosamente
if [ $? -eq 0 ]; then
  echo "Usuario '$USERNAME' creado exitosamente con la contraseña '$PASWW'"
  usermod -aG sudo "$USERNAME"
  echo "El usuario '$USERNAME'  se le agrego exitosamente privilegio sudo"
else
  echo "Hubo un error al crear el usuario '$USERNAME'"
  exit 1
fi

# agregando los requisitos para el deploy 


echo "Se instalaran los modulos necesarios para el deploy"
    sudo apt update
    sudo apt install -y python3-venv python3-dev python3-pip libpq-dev postgresql postgresql-contrib nginx curl

    sudo systemctl start postgresql && sudo systemctl enable postgresql

echo "Aplicando Configuracion Basica de Postgresql"
PSQLPASS='postgres'

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PSQLPASS';"
# Habilitar la autenticación de contraseña para el usuario postgres
echo "host    all             postgres        127.0.0.1/32            md5" >> /etc/postgresql/12/main/pg_hba.conf
echo "host    all             postgres        ::1/128                 md5" >> /etc/postgresql/12/main/pg_hba.conf
# Reiniciar PostgreSQL para aplicar los cambios
sudo systemctl reload postgresql

echo "PostgreSQL instalado y configurado correctamente."