# DidaktikApp

Aplicación móvil interactiva para la enseñanza de la didáctica en carreras docentes mediante simulaciones, evaluación adaptativa y planificación pedagógica.

## Descripción

DidaktikApp es una plataforma educativa desarrollada como proyecto de titulación que busca fortalecer las competencias didácticas de estudiantes de carreras docentes a través de experiencias interactivas, simulaciones pedagógicas y retroalimentación personalizada.

## Objetivo

Desarrollar una aplicación móvil interactiva que contribuya al aprendizaje de la didáctica mediante recursos educativos, simulaciones y evaluación adaptativa.

## Funcionalidades

- Registro e inicio de sesión de usuarios.
- Simulaciones de escenarios educativos.
- Evaluaciones interactivas.
- Retroalimentación adaptativa.
- Sistema de progreso académico.
- Gamificación mediante puntos e insignias.
- Biblioteca de recursos educativos.
- Foros de discusión.
- Mentorías académicas.
- Seguimiento del desempeño estudiantil.

## Algoritmo ADA

El sistema incorpora el algoritmo ADA (Análisis Didáctico Adaptativo), encargado de:

- Analizar respuestas del estudiante.
- Detectar fortalezas.
- Identificar áreas de mejora.
- Generar recomendaciones personalizadas.
- Elaborar planes de acción adaptativos.
- Ajustar la retroalimentación según el desempeño.

## Tecnologías Utilizadas

### Frontend

- React
- Vite
- JavaScript
- Tailwind CSS

### Backend

- Supabase
- PostgreSQL

### Inteligencia Artificial

- Algoritmo ADA
- Sistema de retroalimentación adaptativa

## Estructura General del Sistema

### Módulos Principales

- Usuarios
- Cursos
- Recursos
- Evaluaciones
- Progreso estudiantil
- Logros e insignias
- Biblioteca digital
- Foros de discusión
- Mentorías académicas

## Base de Datos

La aplicación utiliza PostgreSQL mediante Supabase.

### Principales Entidades

- usuarios
- cursos
- recursos
- evaluaciones
- resultados_evaluaciones
- progreso_estudiantes
- puntos_usuario
- logros
- usuarios_logros
- publicaciones_foro
- mentorias

## Configuración

Crear un archivo `.env.local` en la raíz del proyecto con la siguiente configuración:

```env
NEXT_PUBLIC_SUPABASE_URL=https://ebrilatmfufeqmndemag.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVicmlsYXRtZnVmZXFtbmRlbWFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5MjcwODAsImV4cCI6MjA3MjUwMzA4MH0.-sHj7O2rL69EpvB2AY-kh8U__jOPy6Ip-MDTKFq-H7Y
```

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/domynll/prototipo.git
```

### 2. Ingresar a la carpeta del proyecto

```bash
cd prototipo
```

### 3. Instalar dependencias

```bash
npm install
```

### 4. Ejecutar el proyecto

```bash
npm run dev
```

### 5. Abrir en el navegador

```text
http://localhost:5173
```

## Repositorio Oficial

Repositorio GitHub:

```text
https://github.com/domynll/prototipo
```
