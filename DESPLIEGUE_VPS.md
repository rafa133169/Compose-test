# Guía de Despliegue en VPS

## 📋 Requisitos del VPS

- **OS**: Ubuntu 20.04+ / CentOS 7+ / Debian 10+
- **RAM**: Mínimo 2GB (recomendado 4GB)
- **CPU**: 2 vCores
- **Almacenamiento**: 20GB SSD
- **Puertos abiertos**: 80, 443, 22

## 🛠️ Instalación de Dependencias en VPS

### 1. Conectar al VPS
```bash
ssh root@tu-ip-vps
```

### 2. Actualizar sistema
```bash
apt update && apt upgrade -y
```

### 3. Instalar Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl start docker
systemctl enable docker
```

### 4. Instalar Docker Compose
```bash
curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### 5. Instalar Git
```bash
apt install git -y
```

## 🚀 Despliegue del Proyecto

### 1. Clonar proyecto en VPS
```bash
cd /opt
git clone tu-repositorio-git nombre-proyecto
cd nombre-proyecto
```

### 2. Configurar variables de entorno
```bash
cp .env.production .env
nano .env
```

**Variables importantes a configurar:**
```env
# Cambiar estas contraseñas por unas seguras
MYSQL_ROOT_PASSWORD=password_super_seguro_123
MYSQL_PASSWORD=password_admin_seguro_456

# Generar JWT secret seguro
JWT_SECRET=tu_jwt_secret_de_64_caracteres_minimo

# Configurar reCAPTCHA
RECAPTCHA_SECRET=tu_secret_recaptcha_real

# Discord webhook (opcional)
DISCORD_WEBHOOK_URL=tu_webhook_url
```

### 3. Configurar Nginx
```bash
nano nginx/nginx.conf
```
- Cambiar `tu-dominio.com` por tu dominio real

### 4. Ejecutar despliegue
```bash
chmod +x deploy.sh
./deploy.sh
```

## 🔐 Configuración SSL (HTTPS)

### Opción 1: Let's Encrypt (Recomendado)
```bash
# Instalar Certbot
apt install certbot -y

# Generar certificados
certbot certonly --standalone -d tu-dominio.com -d www.tu-dominio.com

# Copiar certificados
mkdir -p nginx/ssl
cp /etc/letsencrypt/live/tu-dominio.com/fullchain.pem nginx/ssl/cert.pem
cp /etc/letsencrypt/live/tu-dominio.com/privkey.pem nginx/ssl/key.pem

# Renovación automática
echo "0 12 * * * /usr/bin/certbot renew --quiet" | crontab -
```

### Opción 2: Sin SSL (solo para testing)
Modificar `nginx/nginx.conf` para solo usar puerto 80.

## 🔧 Comandos Útiles

### Ver logs
```bash
docker-compose -f docker-compose.prod.yml logs -f
docker-compose -f docker-compose.prod.yml logs -f api
docker-compose -f docker-compose.prod.yml logs -f db
```

### Reiniciar servicios
```bash
docker-compose -f docker-compose.prod.yml restart
docker-compose -f docker-compose.prod.yml restart api
```

### Acceder a la base de datos
```bash
docker-compose -f docker-compose.prod.yml exec db mysql -u admin -p miapp_db
```

### Backup de base de datos
```bash
docker-compose -f docker-compose.prod.yml exec db mysqldump -u admin -p miapp_db > backup_$(date +%Y%m%d_%H%M%S).sql
```

### Actualizar aplicación
```bash
git pull origin main
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d
```

## 🔥 Firewall (UFW)
```bash
ufw enable
ufw allow ssh
ufw allow 80
ufw allow 443
ufw reload
```

## 📊 Monitoreo

### Estado de contenedores
```bash
docker-compose -f docker-compose.prod.yml ps
docker stats
```

### Uso de recursos
```bash
htop
df -h
free -h
```

## 🆘 Troubleshooting

### Problema: Contenedor no inicia
```bash
docker-compose -f docker-compose.prod.yml logs nombre-servicio
```

### Problema: No conecta a base de datos
1. Verificar variables de entorno
2. Verificar que el contenedor db esté corriendo
3. Verificar logs del contenedor db

### Problema: 502 Bad Gateway
1. Verificar que el contenedor api esté corriendo
2. Verificar logs de nginx
3. Verificar health check: `curl http://localhost:4000/api/health`

## 🌐 URLs de Acceso

- **Frontend**: http://tu-dominio.com o https://tu-dominio.com
- **API**: http://tu-dominio.com/api o https://tu-dominio.com/api
- **Health Check**: http://tu-dominio.com/api/health

## 📱 URLs de la Aplicación

Basado en los archivos HTML encontrados:
- Login: `/index.html` o `/login.html`
- Registro: `/register.html`
- Landing: `/landingPage.html`
- Dashboard: `/Dashboard.html`
- Proyectos: `/projects.html`
- Contacto: `/contact.html`
