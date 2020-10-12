# Virtualización *ligera* usando contenedores: Introducción

## Un paso más hacia la virtualización completa: *contenedores*

El aislamiento de grupos de procesos formando una *jaula* o *contenedor* ha
sido una característica de ciertos sistemas operativos de la rama Unix desde
los años 80, en forma del programa
[chroot](https://es.wikipedia.org/wiki/Chroot) (creado por Bill Joy, el que más
adelante sería uno de los padres de Java). La restricción de uso de recursos de
las *jaulas `chroot`*, que ya hemos visto, se limitaba a la protección del
acceso a ciertos recursos del sistema de archivos, aunque son relativamente
fáciles de superar; incluso así, fue durante mucho tiempo la forma principal de
configurar servidores de alojamiento compartidos y sigue siendo una forma
simple de crear virtualizaciones *ligeras*. Las
[jaulas BSD](https://en.wikipedia.org/wiki/FreeBSD_jail) constituían un sistema
más avanzado, implementando una
[virtualización a nivel de sistema operativo](https://en.wikipedia.org/wiki/Operating_system-level_virtualization)
que creaba un entorno virtual prácticamente indistinguible de una máquina real
(o máquina virtual real). Estas *jaulas* no solo impiden el acceso a ciertas
partes del sistema de ficheros, sino que también restringían lo que los
procesos podían hacer en relación con el resto del sistema. Tiene como
limitación, sin embargo, la obligación de ejecutar la misma versión del núcleo
del sistema.

<div class='nota' markdown='1'>

En
[esta presentación](http://www.slideshare.net/dotCloud/scale11x-lxc-talk-16766275)
explica como los espacios de nombres son la clave para la creación de
contenedores y cuáles son sus ventajas frente a otros métodos de
virtualización

</div>

El mundo Linux no tendría capacidades similares hasta bien entrados los años
90, con
[vServers, OpenVZ y finalmente LXC](https://en.wikipedia.org/wiki/Operating_system-level_virtualization#Implementations).
Este último, [LXC](https://linuxcontainers.org/), se basa en el concepto de
[grupos de control o CGROUPS](https://en.wikipedia.org/wiki/Cgroups), una
capacidad del núcleo de Linux desde la versión 2.6.24 que crea *contenedores*
de procesos unificando diferentes capacidades del sistema operativo que
incluyen acceso a recursos, prioridades y control de los procesos. Los procesos
dentro de un contenedor están *aislados* de forma que solo pueden *ver* los
procesos dentro del mismo, creando un entorno mucho más seguro que las
anteriores *jaulas*. Estos
[CGROUPS han sido ya vistos en otro tema](Intro_concepto_y_soporte_fisico).

Dentro de la familia de sistemas operativos Solaris (cuya última
versión libre se denomina
[illumos](https://en.wikipedia.org/wiki/Illumos), y tiene también otras
versiones como SmartOS) la tecnología
correspondiente se denomina
[zonas](https://en.wikipedia.org/wiki/Solaris_Zones). La principal
diferencia es el bajo *overhead* que le añaden al sistema operativo y
el hecho de que se les puedan asignar recursos específicos; estas
diferencias son muy leves al tratarse simplemente de otra
implementación de virtualización a nivel de sistema operativo.

Un contenedor es, igual que una jaula, una forma *ligera* de virtualización, en
el sentido que no requiere un hipervisor para funcionar ni, en principio,
ninguno de los mecanismos hardware necesarios para llevar a cabo
virtualización. Tiene la limitación de que la *máquina invitada* debe tener el
mismo kernel y misma CPU que la máquina anfitriona, pero si esto no es un
problema, puede resultar una alternativa útil y ligera a la misma. A diferencia
de las jaulas, combina restricciones en el acceso al sistema de ficheros con
otras restricciones aprovechando espacios de nombres y grupos de control. `lxc`
es la solución de creación de contenedores más fácil de usar hoy en día en
Linux.

<div class='ejercicios' markdown="1">

Instala LXC en tu versión de Linux favorita. Normalmente la versión en
desarrollo, disponible tanto en [GitHub](http://github.com/lxc/lxc)
como en el [sitio web](http://linuxcontainers.org) está bastante más
avanzada; para evitar problemas sobre todo con las herramientas que
vamos a ver más adelante, conviene que te instales la última versión y
si es posible una igual o mayor a la 1.0.

</div>

Esta virtualización *ligera* tiene, entre otras ventajas, una *huella* escasa:
un ordenador normal puede admitir 10 veces más contenedores (o *tápers*) que
máquinas virtuales; su tiempo de arranque es de unos segundos y, además, tienes
mayor control desde fuera (desde el anfitrión) del que se pueda tener usando
máquinas virtuales.

## Usando `lxc`

> Esta sección tiene principalmente un interés histórico y desde el
> punto de vista de la creación de aplicaciones que manejen
> contenedores. En la empresa se usará principalmente Docker.

No todos los núcleos del sistema operativo pueden usar este tipo de contenedor
ligero; para empezar, dependerá de cómo esté compilado, pero también del
soporte que tenga el hardware. `lxc-checkconfig` permite comprobar si está
preparado para usar este tipo de tecnología y también si se ha configurado
correctamente. Parte de la configuración se refiere a la instalación de
`cgroups`, que hemos visto antes; el resto a los espacios de nombres y a
capacidades *misceláneas* relacionadas con la red y el sistema de ficheros.

![Usando lxc-chkconfig](../img/lxcchkconfig.png)

Hay que tener en cuenta que si no aparece alguno de esas capacidades como
activada, LXC no va a funcionar. Pero si no hay ningún problema y todas están
*enabled* se puede
[usar lxc con relativa facilidad](https://stgraber.org/2012/05/04/lxc-in-ubuntu-12-04-lts/)
siempre que tengamos una distro como Ubuntu relativamente moderna:

```shell
sudo lxc-create -t ubuntu -n una-caja
```

crea un contenedor denominado `una-caja` e instala Ubuntu en él. Esto
tardará un rato mientras se bajan una serie de paquetes y se
instalan. O se
puede usar una imagen similar a la que se usa en
[EC2 de Amazon](https://aws.amazon.com/es/ec2/):

```shell
sudo lxc-create -t ubuntu-cloud -n nubecilla
```

que funciona de forma ligeramente diferente, porque se descarga un
fichero `.tar.gz` usando `wget` (y tarda también un rato). Podemos
listar los contenedores que tenemos disponibles con `lxc-ls -f`, aunque
en este momento cualquier contenedor debería estar en estado
`STOPPED`.

Para arrancar el contenedor y conectarse a él,

```shell
sudo lxc-start -n nubecilla
```

Dependiendo del contenedor que se arranque, habrá una configuración
inicial; en este caso, se configuran una serie de cosas y
eventualmente sale el login, que será para todas las máquinas creadas
de esta forma `ubuntu` (también clave). Lo que hace esta orden es
automatizar una serie de tareas tales como asignar los `CGROUPS`, crear
los namespaces que sean necesarios, y crear un puente de red tal como
hemos visto anteriormente. En general, creará un puente llamado
`lxcbr0` y otro con el prefijo `veth`.

Una vez arrancados los
contenedores, si se lista desde fuera aparecerá de esta forma:

```shell
jmerelo@penny:~/txt/docencia/infraestructuras-virtuales/IV/documentos$ sudo lxc-list
RUNNING
    contenedor
    nubecilla

FROZEN

STOPPED
```

Y, dentro de la misma, tendremos una máquina virtual con estas
apariencias:

![Dentro del contenedor LXC](../img/lxc.png)

Para el usuario del contenedor aparecerá exactamente igual que
cualquier otro ordenador: será una máquina virtual que, salvo error o
brecha de seguridad, no tendrá acceso al anfitrión, que sí podrá tener
acceso a los mismos y pararlos cuando le resulte conveniente.

```shell
sudo lxc-stop -n nubecilla
```

Las
[órdenes que incluye el paquete](https://help.ubuntu.com/lts/serverguide/lxc.html)
permiten administrar las máquinas virtuales, actualizarlas y explican cómo usar
otras plantillas de las suministradas para crear contenedores con otro tipo de
sistemas, sean o no debianitas. Se pueden crear sistemas basados en Fedora;
también clonar contenedores existentes para que vaya todo rápidamente.

<div class='ejercicios' markdown='1'>

Crear y ejecutar un contenedor basado en tu distribución y otro basado en otra
distribución, tal como Fedora. *Nota* En general, crear un contenedor basado en
*tu* distribución y otro basado en otra que no sea la tuya.

> Fedora, al parecer, tiene problemas si estás en Ubuntu 13.04 o superior, así
> que en tal caso usa cualquier otra distro. Por ejemplo, Óscar Zafra ha
> logrado instalar Gentoo usando un script descargado desde su sitio, como
> indica en este
> [comentario en el issue](https://github.com/IV-GII/GII-2013/issues/87#issuecomment-28639976).

</div>

Los contenedores son la implementación de todas las tecnologías vistas
anteriormente: espacios de nombres, CGroups y puentes de red y como
tales pueden ser configurados para usar solo una cantidad determinada
de recursos, por ejemplo
[la CPU](https://www.slideshare.net/dotCloud/scale11x-lxc-talk-16766275). Para
ello se usan los ficheros de configuración de cada una de las máquinas
virtuales. Sin embargo, tanto para controlar como para visualizar los
tápers (que así vamos a llamar a los contenedores a partir de ahora)
es más fácil usar [lxc-webpanel](https://lxc-webpanel.github.io/), un
centro de control por web que permite iniciar y parar las máquinas
virtuales, aparte de controlar los recursos asignados a cada una de
ellas y visualizarlos, tal como se muestra a continuación.

![Visualizando uno de los tápers](../img/Minube-lxc.png)

La página principal te da una visión general de los contenedores
instalados y desde ella se pueden arrancar o parar.

![Página inicial de LXC-Webpanel](../img/Overview-lxc.png)

Cada solución de virtualización tiene sus ventajas e
inconvenientes. La principal ventaja de los contenedores son el
aislamiento de recursos y la posibilidad de manejarlos, lo que hace
que se use de forma habitual en proveedores de infraestructuras
virtuales. El hecho de que se virtualicen los recursos también implica
que haya una diferencia en las prestaciones, que puede ser apreciable
en ciertas circunstancias.

## A dónde ir desde aquí

Al [tema de contenedores](Contenedores.md) del que se ha desgajado
esto.

Si te interesa, puedes consultar cómo se
[virtualiza el almacenamiento](Almacenamiento) que, en general, es
independiente de la generación de una máquina virtual. También puedes ir
directamente al [tema de uso de sistemas](Uso_de_sistemas) en el que se
trabajará con sistemas de virtualización completa.
