# Script de instalación para VPS Ubuntu
# Ejecutar como root: bash install-vps.sh

#!/bin/bash

set -e

echo "🚀 Configurando VPS para el proyecto..."

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Actualizar sistema
echo -e "${YELLOW}📦 Actualizando sistema...${NC}"
apt update && apt upgrade -y

# Instalar dependencias básicas
echo -e "${YELLOW}🔧 Instalando dependencias básicas...${NC}"
apt install -y curl wget git nano htop ufw

# Instalar Docker
echo -e "${YELLOW}🐳 Instalando Docker...${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl start docker
systemctl enable docker
rm get-docker.sh

# Instalar Docker Compose
echo -e "${YELLOW}🔗 Instalando Docker Compose...${NC}"
curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Configurar firewall
echo -e "${YELLOW}🔥 Configurando firewall...${NC}"
ufw --force enable
ufw allow ssh
ufw allow 80
ufw allow 443
ufw reload

# Instalar Certbot para SSL
echo -e "${YELLOW}🔐 Instalando Certbot para SSL...${NC}"
apt install -y certbot

# Crear directorio para el proyecto
echo -e "${YELLOW}📁 Creando directorio del proyecto...${NC}"
mkdir -p /opt/miapp
cd /opt/miapp

echo -e "${GREEN}✅ VPS configurado correctamente!${NC}"
echo -e "${YELLOW}📋 Pasos siguientes:${NC}"
echo -e "1. Subir tu proyecto a este directorio: /opt/miapp"
echo -e "2. Configurar el archivo .env.production"
echo -e "3. Ejecutar ./deploy.sh"
echo -e "4. Configurar SSL con: certbot certonly --standalone -d tu-dominio.com"

# Mostrar información del sistema
echo -e "${YELLOW}📊 Información del sistema:${NC}"
echo "CPU: $(nproc) cores"
echo "RAM: $(free -h | grep Mem | awk '{print $2}')"
echo "Disk: $(df -h / | tail -1 | awk '{print $4}') disponible"
echo "Docker: $(docker --version)"
echo "Docker Compose: $(docker-compose --version)"
