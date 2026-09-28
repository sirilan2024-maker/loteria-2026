# Control Lotería de Navidad — sincronización en la nube

Esta versión sustituye el almacenamiento principal en `localStorage` por Supabase.
Los datos se guardan en una fila por usuario y se sincronizan entre ordenador y móvil.

## 1. Crear Supabase

1. Entra en https://supabase.com/
2. Crea un proyecto.
3. Abre **SQL Editor** y ejecuta todo `supabase_schema.sql`.
4. En **Authentication > Providers > Email**, deja habilitado Email.
5. Si quieres que el acceso sea inmediato al crear una cuenta, desactiva temporalmente la confirmación de email; si la mantienes activa, el usuario tendrá que confirmar el correo.

## 2. Configurar la aplicación

En **Project Settings > API** copia:
- Project URL
- Publishable/anon key (la clave pública)

Edita `config.js`:

    window.SUPABASE_URL = 'https://...supabase.co';
    window.SUPABASE_ANON_KEY = '...';

NO pongas aquí una service_role key.

## 3. Datos existentes

La primera vez que un usuario inicia sesión, si todavía no existe una fila en la nube, la aplicación intenta importar automáticamente `control_loteria_db_v15` del navegador local. Esto permite llevar los datos actuales del ordenador a la nube.

IMPORTANTE: haz la primera entrada desde el ordenador que contiene los datos correctos.

## 4. Publicar en Vercel

Sube todos los archivos de esta carpeta a tu repositorio o proyecto de Vercel. No hace falta un build: es una PWA estática.

## 5. Seguridad

RLS está activado. Cada usuario solo puede leer/modificar sus propios datos.

## 6. Service Worker

Se ha cambiado a una estrategia network-first para `index.html`, para evitar que el móvil conserve indefinidamente una versión vieja de la aplicación.
