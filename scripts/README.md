# Scripts para gestionar cosas

Diferentes scripts para crear infraestructura de nuevos repos, por
ejemplo. Es una vez al año, pero viene bien tenerlo ahí.

## Para crear la estructura dle repo de la asignatura `crea-asignatura.pl`

Se ejecuta al principio del año para generar los ficheros
correspondientes. Primero se crea el repo en GitHub. Luego, se cambia
uno al repo y ...

```shell
/path/to/crea-asignatura.pl <este-directorio> <directorio-a-copiar>
```

Necesita Perl y `File::Copy` para funcionar. Y que se cree el
directorio del repo de la asignatura previamente.
