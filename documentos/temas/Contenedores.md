Virtualización *ligera* usando contenedores
===

<!--@
prev: Tecnicas_de_virtualizacion
next: 3.Uso_de_sistemas
-->

Un  paso más hacia la virtualización completa: *contenedores*
-------

El aislamiento de grupos de procesos formando una *jaula* o
*contenedor* ha sido una característica de ciertos sistemas operativos
de la rama Unix desde los años 80, en forma del programa
[chroot](http://es.wikipedia.org/wiki/Chroot) (creado por Bill Joy, el
que más adelante sería uno de los padres de Java). La restricción de
uso de recursos de las *jaulas `chroot`*, que ya hemos visto, se limitaba a la protección
del acceso a ciertos recursos del sistema de archivos, aunque son
relativamente fáciles de superar; incluso así, fue durante mucho
tiempo la forma principal de configurar servidores de alojamiento
compartidos y sigue siendo una forma simple de crear virtualizaciones *ligeras*. Las
[jaulas BSD](http://en.wikipedia.org/wiki/FreeBSD_jail) constituían un
sistema más avanzado, implementando una
[virtualización a nivel de sistema operativo](http://en.wikipedia.org/wiki/Operating_system-level_virtualization)
que creaba un entorno virtual prácticamente indistinguible de una
máquina real (o máquina virtual real). Estas *jaulas* no sólo impiden
el acceso a ciertas partes del sistema de ficheros, sino que también
restringían lo que los procesos podían hacer en relación con el resto
del sistema. Tiene como limitación, sin embargo, la obligación de
ejecutar la misma versión del núcleo del sistema.

<div class='nota' markdown='1'>

En
[esta presentación](http://www.slideshare.net/dotCloud/scale11x-lxc-talk-16766275)
explica como los espacios de nombres son la clave para la creación de
contenedores y cuáles son sus ventajas frente a otros métodos de
virtualización

</div>


El mundo Linux no tendría capacidades similares hasta bien entrados los años 90, con
[vServers, OpenVZ y finalmente LXC](http://en.wikipedia.org/wiki/Operating_system-level_virtualization#Implementations). Este
último, [LXC](http://lxc.sourceforge.net), se basa en el concepto de
[grupos de control o CGROUPS](http://en.wikipedia.org/wiki/Cgroups),
una capacidad del núcleo de Linux desde la versión 2.6.24 que crea
*contenedores* de procesos unificando diferentes capacidades del
sistema operativo que incluyen acceso a recursos, prioridades y
control de los procesos. Los procesos dentro de un contenedor están
*aislados* de forma que sólo pueden *ver* los procesos dentro del
mismo, creando un entorno mucho más seguro que las anteriores
*jaulas*. Estos [CGROUPS han sido ya vistos en el tema anterior](Intro:concepto_y_soporte_fisico.md). 

Dentro de la familia de sistemas operativos Solaris (cuya última
versión libre se denomina
[illumos](http://en.wikipedia.org/wiki/Illumos), y tiene también otras
versiones como SmartOS) la tecnología
correspondiente se denomina
[zonas](http://en.wikipedia.org/wiki/Solaris_Zones). La principal
diferencia es el bajo *overhead* que le añaden al sistema operativo y
el hecho de que se les puedan asignar recursos específicos; estas
diferencias son muy leves al tratarse simplemente de otra
implementación de virtualización a nivel de sistema operativo.

Un contenedor es, igual que una jaula, una forma *ligera* de virtualización, en el sentido
que no requiere un hipervisor para funcionar ni, en principio, ninguno
de los mecanismos hardware necesarios para llevar a cabo
virtualización. Tiene la limitación de que la *máquina invitada* debe
tener el mismo kernel y misma CPU que la máquina anfitriona, pero si
esto no es un problema, puede resultar una alternativa útil y ligera a
la misma. A diferencia de las jaulas, combina restricciones en el
acceso al sistema de ficheros con otras restricciones aprovechando
espacios de nomgres y grupos de control. `lxc` es la solución de
creación de contenedores más fácil de usar hoy en día en Linux.

<div class='ejercicios' markdown="1">
Instala LXC en tu versión de Linux favorita.
</div>

Esta virtualización *ligera* tiene, entre otras ventajas, una
*huella* escasa: un ordenador normal puede admitir 10 veces más contenedores
(o *tápers*) que máquinas virtuales; su tiempo de arranque es de unos
segundos y, además, tienes mayor control desde fuera (desde el anfitrión) del que se pueda
tener usando máquinas virtuales. 

Usando `lxc`
--

No todos los núcleos del sistema operativo pueden usar este tipo de container; para empezar,
dependerá de cómo esté compilado, pero también del soporte que tenga
el hardware. `lxc-checkconfig` permite comprobar si está preparado
para usar este tipo de tecnología y también si se ha configurado correctamente. Parte de la configuración se
refiere a la instalación de `cgroups`, que hemos visto antes; el resto
a los espacios de nombres y a capacidades *misceláneas* relacionadas
con la red y el sistema de ficheros. 

![Usando lxc-chkconfig](../img/lxcchkconfig.png)

Hay que tener en cuenta que si no aparece alguno de esas capacidades
como activada, LXC no va a funcionar. Pero si no hay ningún problema y
todas están *enabled* se puede
[usar lxc con relativa facilidad](http://www.stgraber.org/2012/05/04/lxc-in-ubuntu-12-04-lts/)
siempre que tengamos una distro como Ubuntu relativamente moderna:

	sudo lxc-create -t ubuntu -n una-caja
	
crea un contenedor denominado `una-caja` e instala Ubuntu en él. Esto
tardará un rato mientras se bajan una serie de paquetes y se
instalan. O se
puede usar una imagen similar a la que se usa en
[EC2 de Amazon](http://aws.amazon.com/es/ec2/):

	sudo lxc-create -t ubuntu-cloud -n nubecilla

que funciona de forma ligeramente diferente, porque se descarga un
fichero `.tar.gz` usando `wget` (y tarda también un rato). Podemos
listar los contenedores que tenemos disponibles con `lxc-list`, aunque
en este momento cualquier contenedor debería estar en estado
`STOPPED`.

Para arrancar el contenedor y conectarse a él, 

	sudo lxc-start -n nubecilla
	
Dependiendo del contenedor que se arranque, habrá una configuración
inicial; en este caso, se configuran una serie de cosas y
eventualmente sale el login, que será para todas las máquinas creadas
de esta forma `ubuntu` (también clave). Lo que hace esta orden es
automatizar una serie de tareas tales como asignar los CGROUPS, crear
los namespaces que sean necesarios, y crear un puente de red tal como
hemos visto anteriormente. En general, creará un puente llamado
`lxcbr0` y otro con el prefijo `veth`. 

<div class='ejercicios' markdown='1'>

Comprobar qué interfaces puente ha creado y explicarlos

</div>

Una vez arrancados los
contenedores, si se lista desde fuera aparecerá de esta forma:

	jmerelo@penny:~/txt/docencia/infraestructuras-virtuales/IV/documentos$ sudo lxc-list
	RUNNING
		contenedor
		nubecilla

	FROZEN

	STOPPED
	
Y, dentro de la misma, tendremos una máquina virtual con estas
apariencias:

![Dentro del contenedor LXC](../img/lxc.png)

Para el usuario del contenedor aparecerá exactamente igual que
cualquier otro ordenador: será una máquina virtual que, salvo error o
brecha de seguridad, no tendrá acceso al anfitrión, que sí podrá tener
acceso a los mismos y pararlos cuando le resulte conveniente. 

	sudo lxc-stop -n nubecilla
	
Las
[órdenes que incluye el paquete](https://help.ubuntu.com/lts/serverguide/lxc.html#lxc-admin)
permiten administrar las máquinas virtuales, actualizarlas y explican
cómo usar otras plantillas de las suministardas para crear
contenedores con otro tipo de sistemas, sean o no debianitas. Se
pueden crear sistemas basados en Fedora; también clonar contenedores
existentes para que vaya todo rápidamente. 

<div class='ejercicios' markdown='1'>

1. Crear y ejecutar un contenedor basado en Debian.

2. Crear y ejecutar un contenedor basado en otra distribución, tal
como Fedora. *Nota* En general, crear un contenedor basado en *tu*
distribución y otro basado en otra que no sea la tuya.  

</div>

Los contenedores son la implementación de todas las tecnologías vistas
anteriormente: espacios de nombres, CGroups y puentes de red y como
tales pueden ser configurados para usar sólo una cantidad determinada
de recursos, por ejemplo
[la CPU](http://www.slideshare.net/dotCloud/scale11x-lxc-talk-16766275). Para
ello se usan los ficheros de configuración de cada una de las máquinas
virtuales. Sin embargo, tanto para controlar como para visualizar los
tápers (que así vamos a llamar a los contenedores a partir de ahora)
es más fácil usar [lxc-webpanel](http://lxc-webpanel.github.io/), un
centro de control por web que permite iniciar y parar las máquinas
virtuales, aparte de controlar los recursos asignados a cada una de
ellas y visualizarlos, tal como se muestra a continuación.

![Visualizando uno de los tápers](../img/Minube-lxc.png)

La página principal te da una visión general de los contenedores
instalados y desde ella se pueden arrancar o parar. 

![Página inicial de LXC-Webpanel](../img/Overview-lxc.png)

<div class='ejercicios' markdown='1'>

1. Instalar lxc-webpanel y usarlo para arrancar, parar y visualizar las
máquinas virtuales que se tengan instaladas.

2. Desde el panel restringir los recursos que pueden usar: CPU
*shares*, CPUs que se pueden usar (en sistemas multinúcleo) o cantidad
de memoria.
</div>


Configurando tápers
----

Una vez creados los tápers, son en casi todos los aspectos como una
instalación normal de un sistema operativo: se puede instalar lo que
uno quiera. Sin embargo, una de las ventajas de la infraestructura
virtual es precisamente la (aparente) configuración del *hardware*
mediante *software*: de la misma forma que se crea, inicia y para
desde el anfitrión una MV, se puede configurar para que ejecute unos
servicios y programas determinados.

A este tipo de aplicaciones y sistemas se les denomina
[SCM por *software configuration management*](http://en.wikipedia.org/wiki/Software_configuration_management);
a pesar de ese nombre, se dedican principalmente a configurar
hardware, no software. Un sistema de este estilo permite, por ejemplo,
crear un táper (o, para el caso, una máquina virtual, o muchas de
ellas) y automáticamente *provisionarla* con el software necesario
para comportarse como un
[PaaS](http://jj.github.io/IV/documentos/temas/Intro:concepto_y_soporte_fisico#usando_un_servicio_paas)
o simplemente como una máquina de servicio al cliente. 

En general, un SCM permite crear métodos para instalar una aplicación
o servicio determinado, expresando sus dependencias, los servicios que
provee y cómo se puede trabajar con ellos. Por ejemplo, una base de
datos ofrece precisamente ese servicio; un sistema de gestión de
contenidos dependerá del lenguaje en el que esté escrito; además, se
pueden establecer *relaciones* entre ellos para que el CMS use la BD
para almacenar sus tablas. 

Hay
[decenas de sistemas CMS](http://en.wikipedia.org/wiki/Comparison_of_open-source_configuration_management_software),
aunque hoy en día los hay que tienen cierta popularidad, como Salt,
Ansible, Chef, Juju y Puppet. Todos ellos tienen sus ventajas e
inconvenientes, pero para la configuración de tápers se puede usar
directamente [Juju](http://juju.ubuntu.com), creado por Canonical
especialmente para máquinas virtuales de ubuntu que se ejecuten en la
nube de Amazon. En este punto nos interesa también porque se puede
usar directamente con contenedores LXC, mientras que no todos lo
hacen.

Para instalarlo conviene usar la última versión; la que hay en los
repositorios de algunas versiones de Ubuntu no tiene todas las
capacidades. Por tanto:

	sudo add-apt-repository ppa:juju/stable
	sudo apt-get update && sudo apt-get install juju-core
	
Si has instalado previamente con sudo apt-get install juju te lo
desinstalará automáticamente. Esto añade un repositorio PPA (creado
por el desarrollador); actualiza los contenidos del local e instala
`juju`, que está basado en Python y por tanto instalará un montón de
librerías del mismo, inclusive Twisted y varias más. 

Para empezar a trabajar con él, se escribe

	juju init -w
	
<div class='nota' markdown='1'>

En el
[documento de instalación](https://juju.ubuntu.com/docs/getting-started.html)
pone incorrectamente que basta con hacer 

	juju init
	
En ese caso escribirá el fichero de configuración en pantalla

</div>

Esta orden escribe en el subdirectorio `~/.juju`, que también crea, el
fichero `environments.yaml`, que contiene información sobre los
*entornos* con los que suele trabajar: proveedores de servicios de
nube y el local, que es el que vamos a probar. Por omisión, el fichero
trabajará con Amazon EC2. Tenemos que cambiarlo a `local` [si queremos
trabajar con contenedores LXC](https://juju.ubuntu.com/docs/config-local.html) editando el
fichero y cambiando la línea 
	
	#default: amazon
	
comentándola de esta forma, por ejemplo, y añadiendo 

	default: local

Este es el entorno con el que se va a trabajar por omisión; usando

	juju switch amazon
	
por ejemplo, se puede cambiar a ese entorno. 

<div class='nota' markdown='1'>

Para [trabajar en local hace falta instalar MongoDB](http://marcoceppi.com/2013/07/compiling-juju-and-the-local-provider/). Si no lo tienes
instalado, haz

	sudo apt-get install mongodb-server
	
</div>

Si tienes ya algún táper creado, te fastidias. A `juju`,
aparentemente, le gustan los suyos propios. Pero la verdad es que es
fácil crearlo, simplemente

	juju bootstrap
	
te creará un táper con su propia configuración, algo así como 

	bash$ lxc-ls 
	
	contenedor  jmerelo-local-machine-1  jmerelo-local-machine-2
	nubecilla
	
Es decir, `usuario-machine-número`. A estas alturas no tengo muy claro
como se puede entrar a través de lxc, pero usando `juju` se puede
hacer fácilmente. Lo vemos más adelante.

A partir de la creación de este táper, se pueden instalar
cosas. `juju` usa [*encantos*](https://jujucharms.com/), scripts que expresan qué necesitan y qué
provee cada aplicación. Son simplemente *scripts* que usan un lenguaje
basado en YAML, pero ya hay *charms* para las tareas más comunes:
instalar servicios web o lenguajes de programación. Por ejemplo, para
instalar mediawiki simplemente se escribiría 

	juju deploy mediawiki
	
No hace falta que indiquemos la máquina en principio, porque en todo
momento se trabaja con la máquina por defecto (en mi caso
`jmerelo-machine-1`). Lo que ocurre es que con esto no se consigue
gran cosa. Mediawiki usa mysql, por lo que habrá que instalarlo
también

	juju deploy mysql
	
No sólo eso, sino que habrá que indicar que mediawiki va a usar
precisamente mysql como base de datos. Se trata de añadir [una
*relación*](https://juju.ubuntu.com/docs/charms-relations.html) con 

	juju add-relation mediawiki mysql
	
Una vez hecho esto, se tiene que
[exponer](https://juju.ubuntu.com/docs/charms-exposing.html) el
servicio para que pueda ser usado por el público, lo que implicará que
se enganche al servidor web, por ejemplo

	juju expose mediawiki
	
Con esto se puede mostar ya el estado de la máquina:

	juju status

que mostrará algo así:

	machines:
  "0":
    agent-state: started
    agent-version: 1.12.0.1
    instance-id: localhost
    instance-state: missing
    series: precise
  "1":
    agent-state: started
    agent-version: 1.12.0.1
    instance-id: jmerelo-local-machine-1
    instance-state: missing
    series: precise
  "2":
    agent-state: started
    agent-version: 1.12.0.1
    instance-id: jmerelo-local-machine-2
    instance-state: missing
    series: precise
services:
  mysql:
    charm: cs:precise/mysql-27
    exposed: false
    relations:
      cluster:
      - mysql
      db:
      - wordpress
    units:
      mysql/0:
        agent-state: started
        agent-version: 1.12.0.1
        machine: "1"
        public-address: 10.0.3.15
  wordpress:
    charm: cs:precise/wordpress-16
    exposed: true
    relations:
      db:
      - mysql
      loadbalancer:
      - wordpress
    units:
      wordpress/0:
        agent-state: started
        agent-version: 1.12.0.1
        machine: "2"
        public-address: 10.0.3.23

`0` es la máquina anfitriona; en este caso muestro un ejemplo en el
que se ha instalado wordpress; en el mismo se muestra la relación con
la base de datos y también con un *loadbalancer* para equilibrar la
carga. Como dato interesante, esta orden nos da la IP local del táper
que hemos creado, por lo que accediendo desde el navegador a
http://10.0.3.15 nos mostrará la página de inicio de MediaWiki

<div class='ejercicios' markdown='1'>

Instalar `juju` y, usándolo, instalar MediaWiki en un táper. 

</div>

Estos contenedores se pueden manejar junto con otros proveedores de
infraestructuras virtuales usando herramientas como la librería
[libvirt](http://en.wikipedia.org/wiki/Libvirt), que abstrae las
características generales de todos ellos y permite trabajar, usando
*drivers* específicos, con todo tipo de contenedor o máquina virtual. 

<div class='ejercicios' markdown='1'>

Instalar `libvirt`. Te puede ayudar
[esta guía para Ubuntu](https://help.ubuntu.com/12.04/serverguide/libvirt.html). 

</div>

`libvirt` ofrece un interfaz de aplicación usable desde un programa,
pero también un *shell*, `virsh`, para gestión desde línea de
órdenes. Si tienes hipervisores instalados, puedes usar `libvirt`
directamente, pero si tienes sólo los contenedores anteriores, tendrás
que usar el [driver para `lxc`](http://libvirt.org/drvlxc.html). Lo
que permite `libvirt` es independizar la gestión de las máquinas
virtuales de la implementación física de las mismas: desde un
contenedor hasta una máquina virtual usando diferentes
hipervisores. Con las diferentes herramientas, se pueden instalar,
clonar, arrancar y conectarse a las diferentes máquinas virtuales o
gestionar las existentes.

<div class='nota' markdown='1'>

En
[este mensaje a la lista de correo de libvirt](https://lists.linux-foundation.org/pipermail/containers/2008-September/013237.html)
explica como usarlo para crear rápidamente un contenedor con el mismo
y gestionarlo desde `virsh`

</div>

Se pueden usar máquinas virtuales ya instaladas, pero facilita mucho
la labot
[instalarlas directamente con `virt-install`](https://fedoraproject.org/wiki/Getting_started_with_virtualization#Creating_a_guest_with_virt-install). Esta
orden usará los drivers instalados para crear un contenedor y
colocarlo bajo el control de `libvirt`.

<div class='ejercicios' markdown='1'>

Instalar un contenedor usando `virt-install`.

</div>

Orquestación de contenedores
---

Los contenedores son un ejemplo de máquinas virtuales, pero ya tienen
ciertas características, como el aislamiento y la gestión
independiente, que las asemeja a las máquinas virtuales *reales*. En
un momento determinado puede hacer falta crear una serie de máquinas
virtuales con características determinadas y usar un *script* con
órdenes de `juju` puede llegar a ser un poco molesto. Se hace
necesario que se usen herramientas para crear y configurar estos
entornos.

Estas herramientas se denominan, en general,
[gestores de configuración](http://en.wikipedia.org/wiki/Configuration_management). [Vagrant](http://en.wikipedia.org/wiki/Vagrant_%28software%29)
es uno de ellos, pero también hay otros: Chef, Salt y Puppet, por
ejemplo. 
