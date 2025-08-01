#!/bin/bash

# Script para actualizar certificados SSL
# Ejecutar después de renovar certificados con certbot

set -e

echo "🔐 Actualizando certificados SSL..."

# Variables
PROJECT_DIR="/root/projects/GutierrezRaymundo/ProjectComplete"
DOMAIN="13138.efdiaz.xyz"  # Tu dominio con puerto

# Copiar certificados renovados
if [ -d "/etc/letsencrypt/live/$DOMAIN" ]; then
    cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem $PROJECT_DIR/nginx/ssl/cert.pem
    cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $PROJECT_DIR/nginx/ssl/key.pem
    
    # Permisos correctos
    chmod 644 $PROJECT_DIR/nginx/ssl/cert.pem
    chmod 600 $PROJECT_DIR/nginx/ssl/key.pem
    
    echo "✅ Certificados actualizados"
    
    # Reiniciar contenedor nginx
    cd $PROJECT_DIR
    docker-compose -f docker-compose.prod.yml restart nginx
    
    echo "✅ Nginx reiniciado"
else
    echo "❌ No se encontraron certificados para $DOMAIN"
fi
