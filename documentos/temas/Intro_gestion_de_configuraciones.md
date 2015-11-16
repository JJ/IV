---
layout: index


prev: Tecnicas_de_virtualizacion
next: Almacenamiento
---

Virtualización *ligera* usando contenedores
===

<!--@
prev: Tecnicas_de_virtualizacion
next: Almacenamiento
-->

<div class="objetivos" markdown="1">

Objetivos
--

### Cubre los siguientes objetivos de la asignatura

* Conocer las diferentes tecnologías y herramientas de virtualización tanto para procesamiento, comunicación y almacenamiento. 
* Instalar, configurar, evaluar y optimizar las prestaciones de un servidor virtual.
* Configurar los diferentes dispositivos físicos para acceso a los
  servidores virtuales: acceso de usuarios, redes de comunicaciones o entrada/salida.
* Diseñar, implementar y construir un centro de procesamiento de datos virtual.
* Documentar y mantener una plataforma virtual.
* Optimizar aplicaciones sobre plataformas virtuales. 
* Realizar tareas de administración en infraestructura virtual.

### Objetivos específicos

2. Crear infraestructuras virtuales completas.

3. Comprender los pasos necesarios para la configuración automática de las mismas.

</div>

Configurando las aplicaciones en un táper
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
capacidades (aunque puedes usarla directamente con `sudo apt-get install juju` en Ubuntu 14.04. Por tanto:

	sudo add-apt-repository ppa:juju/stable
	sudo apt-get update && sudo apt-get install juju-core
	
Si has instalado previamente con `sudo apt-get install juju` te lo
desinstalará automáticamente. Esto añade un repositorio PPA (creado
por el desarrollador); actualiza los contenidos del local e instala
`juju`, que está basado en Python y por tanto instalará un montón de
librerías del mismo, inclusive Twisted y varias más. 

Para empezar a trabajar con él, se escribe

	juju init

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
	
MongoDB reserva una gran cantidad de espacio (del orden de 10 gigas) para sus bases de datos, por lo que tendrás que tener bastantes gigas libres para usarlo. 
	
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
http://10.0.3.15 nos mostrará la página de inicio de MediaWiki. Al instalar un *servicio* en una *máquina* se crean una serie de *unidades*. Esas unidades son como mini-contenedores que están a cargo de ejecutar el servicio que se ha instalado mediante juju. 

<div class='ejercicios' markdown='1'>

1. Instalar `juju`.

2. Usándolo, instalar `MySQL` en un táper. 

</div>

Para desmontar los servicios se tiene que hacer en orden inverso a su creación: primero hay que destruir las unidades, de esta forma: 

	sudo juju destroy-unit mysql/0

La destrucción de las máquinas sólo se puede hacer una vez que todas las unidades hayan dejado de funcionar, de esta forma:

	sudo juju destroy-machine 2
	
donde 2 es el número de la máquina que aparecería en status. La máquina `0` siempre es la máquina anfitriona, que no se puede destruir a no ser que queramos ver el fin del universo conocido. 


Los números de máquina no se reutilizan, y cuando se ejecuta 

	sudo juju add-machine
	
se creará una con número posterior al último utilizado:

	environment: local
  machines:
    "0":
      agent-state: started
      agent-version: 1.16.3.1
      dns-name: 10.0.3.1
      instance-id: localhost
      series: precise
    "4":
      instance-id: pending
      series: precise

La nueva máquina aparecerá inicialmente de esta forma, porque la orden regresa antes de que se complete la orden. Posteriormente, si todo ha ido bien, aparecerá el estado completo de esta nueva máquina. Si ha ido mal, aparecerá algo como:

	 agent-state-info: '(error: error executing "lxc-create": No such file or directory
      - bad template: ubuntu-cloud; bad template: ubuntu-cloud)'
    instance-id: pending
    series: precise

Cuando algo va mal en `juju`, hay que echar mano de los logs. En algún momento funcionará `juju debug-log`, pero por lo pronto hay que apañarse con el registro de errores del mismo, que se puede consultar (y se debe borrar con cierta frecuencia, porque engorda que da gusto), en `~/.juju/local/log/machine-0.log`; en este caso sería el de la máquina anfitriona, pero cada una de las máquinas tendrá su propio registro. 

	2013-11-21 21:28:16 DEBUG juju.rpc.jsoncodec codec.go:107 <- {"RequestId":110,"Type":"Provisioner","Request":"SetStatus","Params":{"Entities":[{"Tag":"machine-4","Status":"error","Info":"error executing \"lxc-create\": No such file or directory - bad template: ubuntu-cloud; bad template: ubuntu-cloud","Data":null}],"Machines":null}}
	
	Lo que indica que falta una plantilla del tipo de máquina que se
	ha usado, por algún error en la instalación de `lxc-templates`,
	seguramente. 
	
	

<div class='ejercicios' markdown='1'>

1. Destruir toda la configuración creada anteriormente
2. Volver a crear la máquina anterior y añadirle mediawiki y una
relación entre ellos.
3. Crear un script en shell para reproducir la configuración usada en
las máquinas que hagan falta.

</div>

Breve introducción a los hipervisores
-----

Un [hipervisor](http://en.wikipedia.org/wiki/Hypervisor) es un monitor
de máquinas virtuales que permite instalarlas, activarlas, monitorizar
su actividad e interaccionar con ellas de las formas posibles. Un
hipervisor se denomina
[*bare-metal*](http://en.wikipedia.org/wiki/Bare_machine) o Tipo uno
si se ejecuta *antes* que el sistema operativo (siendo, por tanto, un
sistema operativo en sí) o Tipo 2 si se arranca como una aplicación
del sistema operativo; VirtualBox sería un ejemplo de este último.

Un hipervisor denomina *dominios* a las máquinas virtuales con las que
trabaja, siendo él mismo también un dominio denominado [*dominio
0*](http://wiki.xen.org/wiki/Dom0). Las MVs alojadas son *dominios de usuario* o *DomU*.

Usando los hipervisores de forma uniforme
---

Estos contenedores se pueden manejar junto con otros proveedores de
infraestructuras virtuales (en general, hipervisores, aunque algunos como User Mode Linux pueden no serlo) usando herramientas como la librería
[libvirt](http://en.wikipedia.org/wiki/Libvirt), que abstrae las
características generales de todos ellos y permite trabajar, usando
*drivers* específicos, con todo tipo de contenedor o máquina
virtual. `libvirt` es un interfaz de aplicación a los diferentes
hipervisores y gestores de contenedores que pueda haber en un
ordenador, y se puede usar tanto desde el interfaz de la línea de
órdenes como conectando con un servicio directamente desde una
aplicación. 

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
y gestionarlo desde `virsh`.

</div>

Se pueden usar máquinas virtuales ya instaladas, pero facilita mucho
la labor posterior
[instalarlas directamente con `virt-install`](https://fedoraproject.org/wiki/Getting_started_with_virtualization#Creating_a_guest_with_virt-install). Esta
orden usará los drivers instalados para crear un contenedor y
colocarlo bajo el control de `libvirt`.

<div class='ejercicios' markdown='1'>

Instalar un contenedor usando `virt-install`.

</div>

De hecho, también se pueden usar contenedores que hayan sido instalados usando `lxc` (como no podía ser de otra forma, por otro lado). Por [ejemplo](http://wiki.centos.org/HowTos/LXC-on-CentOS6), esta orden 

    virt-install --connect lxc:/// --name esa_maquina --ram 512 --vcpu 1 --filesystem /var/lib/libvirt/lxc/taper --noautoconsole
	
instalaría usando el conector para lxc	una máquina con el nombre indicado, medio giga de RAM, una sola CPU virtual y un filesystem ya instalado previamente en el subdirectorio `taper`. 

Una vez instalados diferentes contenedores, `virsh` permite trabajar
con ellos
	
A dónde ir desde aquí
-----

En el [siguiente tema](Almacenamiento) veremos cómo crear y configurar el
almacenamiento virtual que, en general, es independiente de la
generación de una máquina virtual. También puedes ir directamente al
[tema de uso de sistemas](Uso_de_sistemas) en el que se trabajará
con sistemas de virtualización completa. 
	
