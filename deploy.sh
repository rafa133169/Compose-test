#!/bin/bash

# Script de despliegue para VPS
# Ejecutar con: bash deploy.sh

set -e

echo "🚀 Iniciando despliegue en VPS..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar que Docker y Docker Compose están instalados
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker no está instalado${NC}"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose no está instalado${NC}"
    exit 1
fi

# Verificar archivo .env.production
if [ ! -f ".env.production" ]; then
    echo -e "${RED}❌ Archivo .env.production no encontrado${NC}"
    echo -e "${YELLOW}Crea el archivo .env.production con las variables de producción${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Verificaciones iniciales completadas${NC}"

# Construir y levantar servicios
echo -e "${YELLOW}📦 Construyendo contenedores...${NC}"
docker-compose -f docker-compose.prod.yml build --no-cache

echo -e "${YELLOW}🔄 Deteniendo servicios existentes...${NC}"
docker-compose -f docker-compose.prod.yml down

echo -e "${YELLOW}🚀 Levantando servicios en producción...${NC}"
docker-compose -f docker-compose.prod.yml up -d

# Esperar a que los servicios estén listos
echo -e "${YELLOW}⏳ Esperando a que los servicios estén listos...${NC}"
sleep 30

# Verificar estado de los servicios
echo -e "${YELLOW}🔍 Verificando estado de los servicios...${NC}"
docker-compose -f docker-compose.prod.yml ps

# Test de conectividad
echo -e "${YELLOW}🧪 Probando conectividad...${NC}"
if curl -f http://localhost:3129/api/health &> /dev/null; then
    echo -e "${GREEN}✅ API funcionando correctamente${NC}"
else
    echo -e "${RED}❌ API no responde${NC}"
fi

if curl -f http://localhost:13138 &> /dev/null; then
    echo -e "${GREEN}✅ Frontend funcionando correctamente${NC}"
else
    echo -e "${RED}❌ Frontend no responde${NC}"
fi

if curl -f http://localhost:18080 &> /dev/null; then
    echo -e "${GREEN}✅ Nginx proxy funcionando en puerto 18080${NC}"
else
    echo -e "${RED}❌ Nginx no responde en puerto 18080${NC}"
fi

echo -e "${GREEN}🎉 Despliegue completado!${NC}"
echo -e "${YELLOW}📊 Para ver logs: docker-compose -f docker-compose.prod.yml logs -f${NC}"
echo -e "${YELLOW}🛑 Para detener: docker-compose -f docker-compose.prod.yml down${NC}"
