---
layout: index


prev: Desarrollo_basado_en_pruebas
next: Integracion_continua
---

# Contenedores y cómo usarlos

<!--@
prev: Desarrollo_basado_en_pruebas
next: Integracion_continua
-->

<div class="objetivos" markdown="1">

## Objetivos

### Cubre los siguientes objetivos de la asignatura

* Conocer las diferentes tecnologías y herramientas de virtualización tanto
  para procesamiento, comunicación y almacenamiento.
* Instalar, configurar, evaluar y optimizar las prestaciones de un servidor
  virtual.
* Configurar los diferentes dispositivos físicos para acceso a los servidores
  virtuales: acceso de usuarios, redes de comunicaciones o entrada/salida.
* Diseñar, implementar y construir un centro de procesamiento de datos virtual.
* Documentar y mantener una plataforma virtual.
* Optimizar aplicaciones sobre plataformas virtuales.
* Conocer diferentes tecnologías relacionadas con la virtualización
  (Computación Nube, Utility Computing, Software as a Service) e
  implementaciones tales como Google AppSpot, OpenShift o Heroku.
* Realizar tareas de administración en infraestructura virtual.

### Objetivos específicos

1. Entender cómo las diferentes tecnologías de virtualización se integran en la
   creación de contenedores.

2. Crear infraestructuras virtuales completas.

3. Comprender los pasos necesarios para la configuración automática de las
   mismas.

</div>

## Gestión de contenedores con `docker`

> El mundo de los contenedores no se inició con Docker; se usa desde
> hace muchos años en diferentes sistemas operativos, y en Linux con
> `lxc`. Hablamos sobre ello en [esta introducción](Intro_contenedores.md).

[Docker](https://www.docker.com) es una herramienta de gestión de contenedores
que permite no solo instalarlos, sino trabajar con el conjunto de ellos
instalados (orquestación) y exportarlos de forma que se puedan desplegar en
diferentes servicios en la nube. La tecnología de
[Docker](https://en.wikipedia.org/wiki/Docker_%28software%29) es relativamente
reciente, habiendo sido publicada su primera versión en marzo de 2013;
pero hoy en día su uso es prácticamente ubicuo en cualquier entorno de
desarrollo, prueba o despliegue de aplicaciones.

> Hasta el punto que se han creado sistemas operativos específicos,
> tales como [CoreOS](https://coreos.com/)
> (actualmente [Fedora CoreOS suspenso](https://coreos.com/os/eol/), y
> con una versión de comunidad llamada [FlatCar](https://www.flatcar-linux.org/))
> o [RancherOS](https://rancher.com/docs/os/v1.x/en/), creados
> específicamente como soporte para poder ejecutar Docker o sistemas
> similares de contenedores.

## Instalación de un gestor de contenedores

[Instalar `docker`](https://www.docker.com/) es sencillo desde que se
publicó la versión 1.0, especialmente en distribuciones de Linux. Por
ejemplo, para
[Ubuntu hay que dar de alta una serie de repositorios](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

La instalación de `docker` tiene dos partes principales: el *runtime*,
que es un servicio que se ejecuta con privilegios de superusuario, y
un CLI que sirve para lanzar los contenedores y gestionarlos, y que se
debe configurar para que lo pueda hacer directamente el usuario. No
hay nada que obligue a que las dos partes se instalen en la misma
máquina virtual o incluso máquina, por eso en
Windows y OSX se suele instalar el servicio en una máquina virtual
Linux, lo que también permite trabajar con este formato, que es el más
común.

Docker es una tecnología abierta y apoyada
por [Open Container Initiative](https://opencontainers.org/), que
apoya los diferentes componentes de la tecnología; eso ha propiciado
que haya otros marcos de construcción y ejecución de contenedores
tales
como
[Podman/Buildah](https://developers.redhat.com/blog/2019/02/21/podman-and-buildah-for-docker-users/)
o [`rkt`](https://coreos.com/rkt/) (que parece que continúa dentro de FlatCar). Este
tiene la ventaja de que se puede
ejecutar sin necesidad de instalar ningún servicio con privilegios de
administrador.

> En ciertas configuraciones puede ser que no se tenga acceso desde los
> contenedores a la red; pasa en ciertas configuraciones WiFi. En ese caso hay
> que cambiar los DNS en la configuración de Docker. Si no tienes ese problema,
> no pasa nada.

<div class='ejercicios' markdown='1'>

Instalar docker y/o otro gestor de contenedores como Podman/Buildah.

</div>

`docker` permite instalar contenedores, que son conjuntos de procesos
y sistema de ficheros aislados, y trabajar con
ellos. Normalmente el ciclo de vida de un contenedor pasa por su
creación y, más adelante, ejecución de algún tipo de programa, por
ejemplo de instalación de los servicios que queramos; luego se puede
salvar el estado del táper y clonarlo o realizar cualquier otro tipo
de tareas.

Así que comencemos desde el principio:
[vamos a ejecutar `docker` y trabajar con el contenedor creado](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

Primero, se ejecuta como un servicio

```shell
sudo docker -d &
```

> En las últimas instalaciones se activa este servicio durante la
> instalación.

La línea de órdenes de docker conectará con este daemon, que mantendrá
el estado de docker y demás. Cada una de las órdenes se ejecutará
también como superusuario, al tener que contactar con este *daemon*
usando un socket protegido.

A partir de ahí, podemos crear un contenedor descargándolo del
repositorio oficial

```shell
docker pull ubuntu
```

Esta orden, `pull`, descarga un contenedor básico de Ubuntu y lo instala. Hay
muchas imágenes creadas y se pueden crear y compartir en el sitio web de
Docker, al estilo de las librerías de Python o los paquetes Debian. Se pueden
[buscar todas las imágenes de un tipo determinado, como Ubuntu](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=ubuntu&starCount=0)
o [buscar las imágenes más populares](https://hub.docker.com/explore/). Estas
imágenes contienen no solo sistemas operativos *bare bones*, sino también otros
con una funcionalidad determinada.

<div class='ejercicios' markdown='1'>

1. Instalar a partir de docker una imagen alternativa de Ubuntu y alguna
   adicional, por ejemplo de CentOS.

2. Buscar e instalar una imagen que incluya MongoDB.

</div>

El contenedor tarda un poco en instalarse, mientras se baja o no la imagen;
esta imagen se compone de *capas*, por eso se ve cómo se van instalando estas
capas, a veces simultáneamente. Una vez bajada, se pueden empezar a ejecutar
comandos. Lo bueno de `docker` es que permite ejecutarlos directamente sin
necesidad de conectarse a la máquina; la gestión de la conexión y demás la hace
el *daemon*.

Podemos ejecutar, por ejemplo, un listado de los directorios

```shell
docker run --rm alpine ls
```

> Por favor, obsérvese que no estamos usando `sudo` para usar el cliente de
> Docker.

`run` es el comando de
docker que estamos usando, `--rm` hace que la máquina se borre una vez
ejecutado el comando. `alpine` es el nombre de la máquina, el mismo
que le hayamos dado antes cuando hemos hecho pull y finalmente `ls`,
el comando que estamos ejecutando. Este comando arranca el contenedor,
lo ejecuta y a continuación sale de él. Esta es una de las ventajas de
este tipo de virtualización: es tan rápido arrancar que se puede usar
para un simple comando y dejar de usarse a continuación, y de hecho
hasta se puede borrar el contenedor correspondiente.

Esta imagen de Alpine no contiene bash, pero si el shell básico
llamado `ash` y que está instalado en `sh`,
por lo que podremos *meternos* en la misma ejecutando

```shell
docker run -it alpine sh
```

Dentro de ella podemos trabajar como un consola cualquiera, pero
teniendo acceso solo a los recursos propios.

### Trabajando con Alpine Linux

Alpine es una instalación peculiar y más bien mínima, pero es muy
interesante para usarla como base para nuestros propios contenedores,
por su minimalismo. Conviene
[consultar el wiki](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management)
para ver las tareas que se pueden realizar en ella.

La máquina instalada la podemos usar con el nombre de la imagen con
que la hayamos descargado, pero cada
táper tiene un id único que se puede ver con

```shell
docker ps -a=false
```

siempre que se esté ejecutando, obteniendo algo así:

```plain
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
b76f70b6c5ce        ubuntu:12.04        /bin/bash           About an hour ago   Up About an hour                        sharp_brattain
```

El primer número es el ID de la máquina que podemos usar también para
referirnos a ella en otros comandos. También se puede usar

```shell
docker images
```

Que, una vez más, devolverá algo así:

```plain
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              12.04               8dbd9e392a96        9 months ago        128 MB
ubuntu              latest              8dbd9e392a96        9 months ago        128 MB
ubuntu              precise             8dbd9e392a96        9 months ago        128 MB
ubuntu              12.10               b750fe79269d        9 months ago        175.3 MB
ubuntu              quantal             b750fe79269d        9 months ago        175.3 MB
```

El *IMAGE ID* es el ID interno del contenedor, que se puede usar para
trabajar en una u otra máquina igual que antes hemos usado el nombre
de la imagen:

```shell
docker run b750fe79269d du
```

## Cómo trabajar imágenes de contenedores interactivamente

En vez de ejecutar las cosas una a una podemos
directamente
[ejecutar un shell](https://docs.docker.com/engine/getstarted/step_two/):

```shell
docker run -i -t ubuntu /bin/bash
```

que [indica](https://docs.docker.com/engine/reference/commandline/cli/) que se
está creando un seudo-terminal (`-t`) y se está ejecutando el comando
interactivamente (`-i`); estad dos opciones se pueden unir en `-it`. A partir
de ahí sale la línea de órdenes, con privilegios de superusuario, y podemos
trabajar con la máquina e instalar lo que se nos ocurra.

*Recuerda que la orden `run` de docker ejecuta dicho comando en un
contenedor nuevo*

Si quieres “reutilizar” un contenedor y usar alguna
orden en él tendrás que buscar su nombre:

```docker ps -a```

Posteriormente arrancar el contenedor:

```docker start <nombre>```

Para finalmente ejecutar el comando deseado:

```docker exec <nombre> <comando>```

Igual que hacíamos con la opción `run`.

Por supuesto una vez se termine de usar es importante detenerlo para
que no siga en segundo plano:

```docker stop <nombre>```

<div class='ejercicios' markdown='1'>

Crear un usuario propio e instalar alguna aplicación tal como `nginx` en el
contenedor creado de esta forma, usando las órdenes propias del sistema
operativo con el que se haya inicializado el contenedor.

</div>

Los contenedores se pueden arrancar de forma independiente con `start`

```shell
docker start ed747e1b64506ac40e585ba9412592b00719778fd1dc55dc9bc388bb22a943a8
```

pero hay que usar el ID largo que se obtiene dando la orden de esta
forma

```shell
docker images --no-trunc
```

Para entrar en ese contenedor tienes que averiguar qué IP está usando
y los usuarios y claves y por supuesto tener ejecutándose un cliente
de `ssh` en la misma. Para averiguar la IP:

```shell
docker inspect ed747e1b64506ac40e585ba9412592b00719778fd1dc55dc9bc388bb22a943a8
```

te dirá toda la información sobre la misma, incluyendo qué es lo que
está haciendo en un momento determinado. Para finalizar, se puede
parar usando `stop`.

Hasta ahora el uso de docker
[no es muy diferente del contenedor, pero lo interesante](https://stackoverflow.com/questions/17989306/what-does-docker-add-to-just-plain-lxc)
es que se puede guardar el estado de un contenedor tal como está usando
[commit](https://docs.docker.com/engine/reference/commandline/commit)

```shell
docker commit 8dbd9e392a964056420e5d58ca5cc376ef18e2de93b5cc90e868a1bbc8318c1c nuevo-nombre
```

que guardará el estado del contenedor tal como está en ese
momento. Este `commit` es equivalente al que se hace en un
repositorio; para enviarlo al repositorio habrá que usar `push` (pero
solo si uno se ha dado de alta antes).

<div class='ejercicios' markdown='1'>

Crear a partir del contenedor anterior una imagen persistente con
commit.

</div>

## Diseñando infraestructura virtual usando Docker: Dockerfiles

Se pueden construir contenedores más complejos, pero el problema de
construirlos a mano es que no es reproducible, y realmente fuera de
una fase de prueba inicial para comprobar que está todo no se
aconseja.

Una funcionalidad interesante
de los mismos es la posibilidad de usarlos como *sustitutos* de
una orden o comando, de forma que sea mucho más fácil trabajar con alguna
configuración específica de una aplicación o de un lenguaje de
programación determinado. Pero hay que especificar de forma precisa
todo lo necesario para ejecutar esa orden. Ese es el papel de los
Dockerfiles, especificar de forma reproducible la infraestructura
necesaria para que se ejecute una aplicación.

Por ejemplo,
[esta, llamada `alpine-raku`](https://hub.docker.com/r/jjmerelo/alpine-raku/)
que se puede usar en lugar del intérprete de Perl6 y usa como base la distro
ligera Alpine:

```dockerfile
FROM alpine:latest

ARG VER="2020.01"
LABEL version="2.3.2" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Environment
ENV PATH="/root/raku-install/bin:/root/raku-install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git" \
    PKGS_TMP="perl curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile"

# Basic setup, programs and init
RUN mkdir /home/raku \
    && apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && rakudobrew build moar $VER --configure-opts='--prefix=/root/raku-install' \
    && rm -rf /root/.rakudobrew/versions/moar-$VER \
    && rakudobrew register moar-$VER /root/raku-install \
    && rakudobrew global moar-$VER \
    && rakudobrew build-zef \
    && zef install Linenoise App::Prove6 \
    && apk del $PKGS_TMP \
    && rm -rf /root/.rakudobrew /root/raku-install/zef

# Runtime
WORKDIR /home/raku
ENTRYPOINT ["raku"]
```

La elección de la base del contenedor, que se hace generalmente en la
primera línea usando el comando `FROM`, es fundamental. En este caso,
usamos la base que se ha hecho más popular por su pequeño tamaño,
[Alpine Linux](https://alpinelinux.org/). Este pequeño tamaño viene a
costa de una serie de recortes en la librería básica y en las
utilidades, por lo que es posible que haya alguna cosa que no funcione
exactamente igual, y por supuesto diferencia en el nivel de
prestaciones. Por eso, en algunos casos, habrá que buscar diferentes
tipos de contenedores base. En general, siempre que se elige una herramienta,
habrá que justificarlo en el documento correspondiente.

Para instalar las dependencias, usa `apk`, la orden de Alpine para
instalar paquetes e instala lo necesario para que eche a andar el
gestor de intérpretes de Perl6 llamado `rakudobrew`. Este gestor tarda
un buen rato, hasta minutos, en construir el intérprete a través de
diferentes fases de compilación, por eso este contenedor sustituye eso
por la simple descarga del mismo. Instala además alguna utilidad
relativamente común, pero lo que lo hace trabajar "como" el intérprete
es la orden `ENTRYPOINT ["raku"]`. `ENTRYPOINT` se usa para señalar
a qué orden se va a concatenar el resto de los argumentos en la línea
de órdenes, en este caso, tratándose del intérprete de Perl 6, se
comportará exactamente como él. Para que esto funcione también se ha
definido una variable de entorno en:

```dockerfile
ENV PATH="/root/.rakudobrew/bin:${PATH}"
```

que añade al `PATH` el directorio donde se encuentra. Con estas dos
características se puede ejecutar el contenedor con:

```shell
docker run -t jjmerelo/alpine-raku -e "say π  - 4 * ([+]  <1 -1> <</<<  (1,3,5,7,9...10000))  "
```

Si tuviéramos `raku` instalado en local, se podría escribir
directamente

```shell
raku -e "say π  - 4 * ([+]  <1 -1> <</<<  (1,3,5,7,9...10000))  "
```

o algún otro
[*one-liner* de Perl6](https://gist.github.com/JJ/9953ba0a98800fed205eaae5b5a6410a).

En caso de que se trate de un servicio o algún otro tipo de programa
de ejecución continua, se puede usar directamente `CMD`. En este caso,
`ENTRYPOINT` da más flexibilidad e incluso de puede evitar usando

```shell
docker run -it --entrypoint "sh -l -c" jjmerelo/alpine-raku
```

que accederá directamente a la línea de órdenes, en este caso
`busybox`, que es el *shell* que provee Alpine.

Por otro lado, otra característica que tiene este contenedor es que, a
través de `VOLUME`, hemos creado un directorio sobre el que podemos
*montar* un directorio externo, tal como hacemos aquí:

```shell
docker run --rm -t -v `pwd`:/app  \
        jjmerelo/alpine-raku /app/horadam.p6 100 3 7 0.25 0.33
```

En realidad, usando `-v` se puede montar cualquier directorio externo
en cualquier directorio interno. `VOLUME` únicamente *marca* un
directorio específico para ese tipo de labor, de forma que se pueda
usar de forma genérica para interaccionar con el contenedor a través
de ficheros externos o para *copiar* (en realidad, simplemente hacer
accesibles) estos ficheros al contenedor. En el caso anterior,
podíamos haber sustituido `/app` en los dos lugares donde aparece por
cualquier otro valor y habría funcionado igualmente.

En este caso, además, usamos `--rm` para borrar el contenedor una vez
se haya usado y `-t` en vez de `-it` para indicar que solo estamos
interesados en que se asigne un terminal y la salida del mismo, no
vamos a interaccionar con él.

En muchos casos el `Dockerfile` estará dentro de un repositorio y
usará los mismos ficheros que hay en el mismo; este es el caso más
habitual cuando queremos crear un contenedor de test. Por ejemplo, este que
se usa para el servicio web que hemos venido usando en la asignatura:

```dockerfile
FROM python:3
LABEL version="1.0.0" maintainer="JJMerelo@GMail.com"

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt

RUN mkdir HitosIV data
ADD data/hitos.json data/
ADD HitosIV/* HitosIV/

CMD [ "hug",  "-p 80", "-f","HitosIV/hugitos.py" ]

EXPOSE 80
```

En este caso estamos usando `FROM python:3`, la imagen *oficial* de Python
mantenida por el mismo equipo que lo crea. El usar imágenes oficiales de un
lenguaje es mucho más conveniente que usar la de un sistema operativo y
posteriormente instalar el lenguaje y cualquier otra cosa que necesite; en este
caso, la imagen lleva también `pip`. Sin embargo, siempre hay otras alternativas
a considerar. Empresas como Bitnami mantienen también imágenes para muchos
lenguajes y servicios en GitHub, y en algunos casos puede haber imágenes
simplemente mantenidas por usuarios que tengan una característica determinada.

Para algunas bibliotecas puede haber también imágenes
oficiales; siempre nos ahorrará trabajo usar esas imágenes, sean
oficiales o no, porque en muchos casos están optimizadas con solo las
partes del sistema operativo necesarias y ocupan mucho menos espacio
siendo, por tanto, más rápidas para descargar. Sin embargo, las
mejores prácticas aconsejan que siempre se busque la imagen más
adecuada para cada aplicación en particular teniendo en cuenta
consideraciones de disponibilidad de bibliotecas y, sobre todo, tamaño
y prestaciones.

Aparte de usar las imágenes oficiales para la versión 3 de Python,
copia todo a el directorio de trabajo definido y finalmente *expone*
(usando `EXPOSE`)
un puerto; este puerto es el puerto del propio contenedor y en caso de
desplegarse directamente es el que se usará, pero si se está
ejecutando localmente habrá que probarlo de esta forma

```shell
docker run -p 8000:80 -it --rm minick/imagen:mitag
```

donde `minick/imagen:mitag` es nuestro prefijo y tag elegidos para este caso
en particular. Este contenedor, por ejemplo, está alojado en Docker
Hub como
[`jjmerelo/tests-python`](https://hub.docker.com/r/jjmerelo/tests-python/).

<div class='ejercicios' markdown='1'>

Crear un Dockerfile para el servicio web que testee la clase que se ha
venido desarrollando hasta ahora.

</div>

## Desplegando directamente contenedores

Docker tiene un repositorio público de contenedores llamado
[Docker Hub](https://hub.docker.com). En este repositorio se pueden
subir imágenes desde la línea de órdenes o bien dar de altas
repositorios para que se *construya* una nueva imagen Docker cada vez
que se haga pull a un repositorio en GitHub. Aparte de dejar
disponibles herramientas útiles, Docker Hub también sirve para alojar
imágenes que queramos desplegar en algún otro servicio. Se pueden
subir todas las imágenes públicas que se desee, aunque hay un servicio
de pago que permite tener imágenes privadas.

Dado que Docker es simplemente una herramienta que se puede desplegar en
cualquier sistema operativo, desplegar contenedores es tan sencillo como
simplemente subirlos junto con una imagen que lo tenga instalado. Sin embargo,
desplegar contenedores es tan común que en los últimos años han surgido una
serie de
[servicios de despliegue de contenedores](https://blog.codeship.com/the-shortlist-of-docker-hosting/);
aparte de los diferentes servicios de *cloud* que ofrecen una opción para
trabajar con contenedores. Estos servicios permiten desplegar directamente o
desde GitHub o desde Docker Hub, a partir de imágenes públicas o privadas
alojadas allí.

Que sepamos, [Now](https://zeit.co) es el único servicio que permite
despliegues gratuitos simplemente con la restricción de que debe ser
público el contenedor con los datos que pueda contener.

También se pueden desplegar contenedores directamente en una serie de
servicios de pago, incluyendo todos los proveedores de cloud y algunos
específicos como [Quay.io](https://quay.io). Este último permite
cuenta gratuita de un mes, que se puede usar como prueba.

<div class='ejercicios' markdown='1'>

Desplegar un contenedor en alguno de estos servicios, de prueba
gratuita o gratuitos.

</div>

## A dónde ir desde aquí

Primero, hay que
[llevar a cabo el hito del proyecto correspondiente a este tema](../proyecto/3.Docker).

Si te interesa, puedes consultar cómo se
[virtualiza el almacenamiento](Almacenamiento) que, en general, es
independiente de la generación de una máquina virtual. También puedes ir
directamente al [tema de uso de sistemas](Uso_de_sistemas) en el que se
trabajará con sistemas de virtualización completa.

Aunque inicialmente iguales, el
[tema equivalente de Cloud Computing](https://jj.github.io/CC/documentos/temas/Contenedores)
ha ido divergiendo y en este momento es más completo en algunos aspectos.
