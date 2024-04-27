#!/bin/bash
# Verificar si el script se ejecuta con privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (root)"
  exit 1
fi
# Nombre de usuario y contraseña
pg_USER="DjangoUSER"
pg_PASS="Djan#fg0"
pg_DB="DB_SGV"

# Crear el usuario
sudo -u postgres psql -c "CREATE USER $pg_USER WITH PASSWORD '$pg_PASS';"

# Crear la base de datos
sudo -u postgres psql -c "CREATE DATABASE $pg_DB;"

# Otorgar todos los permisos al usuario sobre la base de datos
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $pg_DB TO $pg_USER;"

echo "Usuario '$pg_USER' creado con la contraseña '$pg_PASS' y base de datos '$pg_DB' creada y configurada correctamente."
