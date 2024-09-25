# Generación Personal Access Token

Los token caducan cada año, así que cada curso hay que generar uno nuevo.

Hay que hacer lo siguiente

* General un Personal Access Token (PAT): Perfil → Settings → Developer settings
  (está al final)
* Generar un PAT con permisos sólo para el repositorio IV-
  - Acceso de lectura a metadatos (esto es obligatorio)
  - Acceso de lectura y escritura a PRs y Actions
* Almacenar el PAT en el repo: Settings → Actions → Repository secrets →
  `COMMENT_TOKEN` (se le llama así desde el script que pone los revisores
  aleatorios).
  
