# CREATIVIDAD y CONEXIÓN - Plataforma Web Integral

## 📋 Descripción del Proyecto

Plataforma web completa con landing page, sistema de autenticación, panel de administración y gestión de leads/contactos. Desarrollada con arquitectura de microservicios usando Docker.

## 🏗️ Arquitectura

- **Frontend**: Landing page estática (HTML/CSS/JS) servida con Nginx
- **Backend**: API REST con Node.js + Express
- **Base de datos**: MySQL 8.0
- **Autenticación**: JWT
- **Contenedorización**: Docker + Docker Compose
- **Reverse Proxy**: Nginx (para producción)

## 🚀 Características

### Frontend
- ✅ Landing page responsiva
- ✅ Formularios de contacto con validación
- ✅ Sistema de login/registro
- ✅ Dashboard de administración
- ✅ Integración con reCAPTCHA
- ✅ Diseño moderno con Bootstrap

### Backend API
- ✅ Autenticación JWT
- ✅ Registro y login de usuarios
- ✅ Gestión de leads/contactos
- ✅ Panel de administración
- ✅ Validación de datos
- ✅ Integración con Discord webhooks
- ✅ Health checks
- ✅ CORS configurado

### Base de Datos
- ✅ Usuarios con roles (user/admin)
- ✅ Sistema de contactos/leads
- ✅ Inicialización automática
- ✅ Backups automáticos

## 🛠️ Tecnologías

- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Backend**: Node.js, Express.js
- **Base de datos**: MySQL 8.0
- **Autenticación**: JWT, bcrypt
- **Validación**: express-validator
- **Containerización**: Docker, Docker Compose
- **Proxy**: Nginx
- **SSL**: Let's Encrypt (Certbot)

## 📦 Estructura del Proyecto

```
.
├── docker-compose.yml          # Desarrollo
├── docker-compose.prod.yml     # Producción
├── .env                        # Variables desarrollo
├── .env.production             # Variables producción
├── deploy.sh                   # Script de despliegue
├── install-vps.sh             # Script instalación VPS
├── DESPLIEGUE_VPS.md          # Guía completa despliegue
├── api/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js              # API principal
│   ├── db.js                  # Conexión DB
│   └── admin.js               # Rutas admin
├── landing/
│   ├── Dockerfile
│   ├── nginx.conf             # Configuración Nginx
│   ├── *.html                 # Páginas web
│   ├── css/
│   ├── js/
│   └── assets/
├── nginx/
│   └── nginx.conf             # Reverse proxy config
└── mysql/
    └── init.sql               # Inicialización DB
```

## 🚀 Despliegue Local (Desarrollo)

### Requisitos
- Docker
- Docker Compose

### Pasos
```bash
# Clonar repositorio
git clone <tu-repo>
cd <nombre-proyecto>

# Configurar variables
cp .env.example .env
# Editar .env con tus configuraciones

# Ejecutar
docker-compose up -d

# Verificar
curl http://localhost:80  # Frontend
curl http://localhost:4000/api/health  # API
```

## 🌐 Despliegue en VPS (Producción)

### Requisitos del VPS
- Ubuntu 20.04+ / CentOS 7+ / Debian 10+
- 2GB RAM mínimo (4GB recomendado)
- 2 vCores
- 20GB SSD
- Dominio configurado

### Instalación Automática
```bash
# En tu VPS como root
wget https://tu-repo/install-vps.sh
bash install-vps.sh
```

### Despliegue Manual
Ver guía completa en [DESPLIEGUE_VPS.md](./DESPLIEGUE_VPS.md)

## 🔐 Configuración de Seguridad

### Variables de Entorno Críticas
```env
# Generar contraseñas seguras
MYSQL_ROOT_PASSWORD=password_super_seguro
MYSQL_PASSWORD=password_admin_seguro

# JWT Secret (64+ caracteres)
JWT_SECRET=tu_jwt_secret_de_64_caracteres_minimo

# reCAPTCHA
RECAPTCHA_SECRET=tu_secret_key_recaptcha
```

### SSL/HTTPS
```bash
# Generar certificados Let's Encrypt
certbot certonly --standalone -d tu-dominio.com

# Renovación automática
echo "0 12 * * * /usr/bin/certbot renew --quiet" | crontab -
```

## 📊 Endpoints API

### Públicos
- `GET /api/health` - Health check
- `POST /api/contact` - Enviar formulario contacto
- `POST /api/register` - Registro de usuarios
- `POST /api/login` - Login de usuarios

### Autenticados (JWT)
- `GET /api/admin/dashboard` - Dashboard admin (solo admin)

## 🔧 Comandos Útiles

### Desarrollo
```bash
# Ver logs
docker-compose logs -f
docker-compose logs -f api

# Reiniciar servicios
docker-compose restart
docker-compose restart api

# Reconstruir
docker-compose build --no-cache
docker-compose up -d
```

### Producción
```bash
# Desplegar
./deploy.sh

# Ver logs
docker-compose -f docker-compose.prod.yml logs -f

# Backup DB
docker-compose -f docker-compose.prod.yml exec db mysqldump -u admin -p miapp_db > backup.sql

# Actualizar
git pull
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d
```

## 🆘 Troubleshooting

### Problemas Comunes

**Error: Puerto ya en uso**
```bash
sudo lsof -i :4000
sudo kill -9 <PID>
```

**Error: Base de datos no conecta**
```bash
docker-compose logs db
docker-compose restart db
```

**Error: 502 Bad Gateway**
```bash
docker-compose logs nginx
curl http://localhost:4000/api/health
```

## 📱 URLs de la Aplicación

- **Landing**: `/` o `/landingPage.html`
- **Login**: `/index.html` o `/login.html`
- **Registro**: `/register.html`
- **Dashboard**: `/Dashboard.html`
- **Proyectos**: `/projects.html`
- **Contacto**: `/contact.html`

## 🤝 Contribución

1. Fork el proyecto
2. Crear rama feature (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Tu Nombre**
- GitHub: [@tu-usuario](https://github.com/tu-usuario)
- Email: tu-email@ejemplo.com

## 🙏 Agradecimientos

- Bootstrap para el framework CSS
- Docker para la containerización
- MySQL para la base de datos
- Node.js y Express para el backend
