Virtualización completa: uso de máquinas virtuales
==

<!--@
prev: Almacenamiento
next: Gestion_de_configuraciones
-->

<div class="objetivos" markdown="1">

<h2>Objetivos</h2>

1.   Conocer las diferentes tecnologías y herramientas de
virtualización tanto para procesamiento, comunicación y
almacenamiento. 

2. Diseñar, construir y analizar las prestaciones de un centro de
proceso de datos virtual. 

3. Documentar y mantener una plataforma virtual.

4. Realizar tareas de administración de infraestructuras virtuales.

</div>

Introducción
------------------

El objetivo de las plataformas de virtualización es, eventualmente,
crear y gestionar una máquina virtual completa que funcione de forma aislada 
del resto del sistema y que permita trabajar con sistemas
virtualizados de forma flexible, escalable y adaptada a cualquier
objetivo. Eventualmente, el objetivo de este este tema es aprender a
crear
[infraestructura como servicio tal como vimos en el primer tema](Intro_concepto_y_soporte_fisico.md). Para
ello necesitamos configurar una serie de infraestucturas virtuales,
especialmente
[almacenamiento como se vio en el tema anterior](Intro_concepto_y_soporte_fisico).

Los programas que permiten crear infraestructuras virtuales completas
se denominan
[hipervisores](http://en.wikipedia.org/wiki/Hypervisor). Un hipervisor
permite manejar las diferentes infraestructuras desde línea de órdenes
o mediante un programa, y a su vez se habla de dos tipos de
hipervisores: los de *tipo I* o *bare metal* que se ejecutan
directamente sobre el hardware (es decir, el sistema arranca con
ellos) y los de *tipo II* o *alojados*, que se ejecutan dentro de un
sistema operativo tradicional como un módulo del núcleo o simplemente
un programa. En muchos casos la diferencia no está clara, porque hay
hipervisores que son distribuciones de un sistema operativo con
módulos determinados y por lo tanto de Tipo II (si consideramos el
módulo) o de Tipo I (si consideramos el sistema operativo completo),
y en todo caso la distinción es más académica que funcional; en la
práctica, en la mayoría de los casos nos vamos a encontrar con
hipervisores alojados que se ejecutan desde un sistema operativo.

![Ilustración de los dos tipos de hipervisores (alojada en la Wikipedia)](http://upload.wikimedia.org/wikipedia/commons/e/e1/Hyperviseur.png)

Para apoyar la virtualización, casi todos los procesadores actuales y
especialmente [los de las líneas más populares basadas en la
arquitectura x86 tienen una serie de instrucciones que permiten usarla de manera segura y eficiente](http://en.wikipedia.org/wiki/X86_virtualization). Esta
arquitectura tiene dos ramas: la Intel y la AMD, cada uno de los
cuales tiene un conjunto de instrucciones diferentes para llevarla a
cabo. Aunque la mayoría de los procesadores lo incluyen, los
portátiles de gama baja y algunos ordenadores de sobremesa antiguos no
la incluyen, por lo que habrá que comprobar si nuestro procesador lo
hace. Si no lo hiciera, se habla de
[paravirtualización](http://en.wikipedia.org/wiki/Paravirtualization)
en la que los hipervisores tienen que *interpretar* cada imagen del
sistema operativo que alojan (llamado *invitado*) y convertirla en
instrucciones del que aloja (llamado *anfitrión* o *host*). La mayor
parte de los hipervisores, como
[Xen](http://en.wikipedia.org/wiki/Xen) o [KVM](
http://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine) incluyen
también la capacidad de paravirtualizar ciertos sistemas operativos en
caso de que los anfitriones no tengan soporte; por ejemplo, KVM se ha
asociado con [QEMU](http://en.wikipedia.org/wiki/QEMU) que lo usa en
caso de que el procesador tenga soporte. 

A continuación veremos el uso básico de estos sistemas de
virtualización basándonos, sobre todo, en uno de ellos KVM.

Creando máquinas virtuales desde la línea de órdenes.
------

Crear una máquina virtual requiere seguir un proceso similar a la
construcción e instalación del sistema operativo de un ordenador por
primera vez: hay que montar los discos, conectar una unidad externa
donde tengamos los discos de instalación, y a partir de ahí
simplemente llevar a cabo la instalación *a mano* con la única
diferencia que nuestro sistema *invitado* estará ejecutándose como un
proceso (que crea una serie de procesos *aislados*) dentro de nuestro
sistema anfitrión y que lo veremos en una ventana del mismo. 

Vamos a usar en estos ejemplos KVM, por ser un sistema fácil de usar,
pero el proceso en otros hipervisores, incluyendo los sistemas
gráficos, será similar.

<div class='ejercicios' markdown="1">

Instalar los paquetes necesarios para usar KVM. Se pueden
[seguir estas instrucciones](https://wiki.debian.org/KVM#Installation). Ya
lo hicimos [en el primer tema](Intro_concepto_y_soporte_fisico.md),
pero volver a comprobar si nuestro sistema está preparado para
ejecutarlo o hay que conformarse con la paravirtualización.

</div>

A continuación hay que crear un
[disco duro virtual en formato QCOW2](Almacenamiento.md) como hemos
visto anteriormente y descargar una distribución de algún sistema
operativo, por ejemplo [Debian](http://www.debian.org/distrib/). 

Dado que KVM es un módulo del kernel, puede que no esté cargado por
defecto. Dependiendo del procesador que usemos,
[lo cargamos](http://www.linux-kvm.org/page/HOWTO1) con 

	sudo modprobe kvm-amd
	
o

	sudo modprobe kvm-intel
	
	
Con los ficheros de almacenamiento virtual y una ISO para poder
arrancar el sistema ya podemos arrancar KVM para instalarlo usando,
por ejemplo

	qemu-system-x86_64 -hda /media/Backup/Isos/discovirtual.img -cdrom	~/tmp/debian-7.3.0-i386-netinst.iso
	
La opción `-hda` indica el fichero en el que se va a alojar el sistema
operativo instalado y `-cdrom` recibe el camino a la ISO en la que
está el sistema que se va a instalar, en este caso la versión
`netinst`que contiene un sistema operativo mínimo que se instala en su
mayor parte desde la red. El disco duro creado debe tener espacio
suficiente para alojar al sistema operativo, pero puede ser, como en
este caso, un fichero *disperso* que se irá llenando según se vaya
ocupando. Este almacenamiento virtual puede estar en cualquier lugar
del sistema operativo, incluyendo tarjetas o pendrives; la diferencia,
principalmente, será la velocidad paro para pruebas se puede usar
cualquier dispositivo.

<div class='nota' markdown='1'>
Si se ha cortado la instalación o ha habido algún problema el comando
anterior tratará de arrancar de todas formas del disco duro. Se puede
cortar la máquina virtual simplemente cerrando al ventana y [tratar de
arrancar de nuevo empezando por el CD virtual usando](http://www.linux-kvm.com/content/some-new-kvm-options-boot-order-and-process-name)

	qemu-system-x86_64 -hda otro-disco.img -cdrom picaros-diego-b.iso
	-boot once=d
	
con `-boot` se le indica el orden de arranque; `once` indica que sólo
va a ser así esta vez y `d`, como antiguamente, es el CD

</div>

<div class='ejercicios' markdown="1">

1. Crear varias máquinas virtuales con algún sistema operativo libre,
Linux o BSD. Si se
quieren distribuciones que ocupen poco espacio con el objetivo
principalmente de hacer pruebas se puede usar
[CoreOS](http://coreos.com/) (que sirve como soporte para Docker)
[GALPon Minino](http://minino.galpon.org/en), hecha en Galicia para el
mundo,
[Damn Small Linux](http://www.damnsmalllinux.org/download.html),
[SliTaz](http://www.slitaz.org/en/) (que cabe en 35 megas) y
[ttylinux](http://ttylinux.net/) (basado en línea de órdenes solo). 

2. Hacer un ejercicio equivalente usando otro hipervisor como Xen, VirtualBox o
Parallels. 

</div>


<div class='nota' markdown='1'>

En [esta guía](http://www.dedoimedo.com/computers/kvm-intro.html) se
explica cómo trabajar con KVM usando VMM, o *virtual machine manager*,
una herramienta gráfica que trabaja sobre KVM

</div>

La máquina virtual, una vez instalada, se puede arrancar directamente
desde el fichero en el que la hemos instalado, usando una orden [tal
como esta](https://wiki.archlinux.org/index.php/QEMU#Creating_new_virtualized_system) 

	qemu-system-x86_64 -boot order=c -drive	file=/media/Backup/Isos/discovirtual.img,if=virtio
	
En este caso no necesitamos *pegarle* el CD, sino que le indicamos en
qué orden tienen que arrancar (usando el DD, en este caso) y mediante
`-drive` le indicamos que use `virtio`, una paravirtualización de la
entrada/salida que permite acceso mucho más rápido al disco; esto se
lo indicamos mediante la segunda opción `if` al argumento.

<div class='ejercicios' markdown="1">

Crear un *benchmark* de velocidad de entrada salida y comprobar la
diferencia entre usar paravirtualización y arrancar la máquina virtual
simplemente con

	qemu-system-x86_64 -hda /media/Backup/Isos/discovirtual.img
	
</div>

Cuando se tienen varias máquinas funcionando no hace falta que se
abran ventanas para cada una de ellas, pero el problema es
interaccionar con las mismas. Lo podemos hacer de diferentes formas,
pero una de ellas es arrancarlas dentro de un
[servidor VNC](http://en.wikipedia.org/wiki/Virtual_Network_Computing)
con una orden como esta

		qemu-system-x86_64 -hda /media/Backup/Isos/discovirtual.img -vnc :1

Con esto podemos conectar a la máquina virtual usando algún
[cliente de VNC tal como `vinagre`](https://help.ubuntu.com/community/VNC/Clients). Hay
[múltiples opciones más](http://man.cx/qemu-system-x86_64%281%29) en
la línea de órdenes, que nos permiten establecer los tipos de CPU,
todo tipo de periféricos, tamaño de memoria (son 128 megas por
omisión) o nombre del invitado. 

<div class='ejercicios' markdown='1'>

Crear una máquina virtual Linux con 512 megas de RAM y entorno gráfico
LXDE a la que se pueda acceder mediante VNC y `ssh`.

</div>

Trabajando con máquinas virtuales en la nube
----

Azure permite,
[tras la creación de almacenamiento virtual](Almacenamiento.md), la
creación de máquinas virtuales, como es natural. Se puede crear una
máquina virtual desde el panel de control, pero también desde la [línea
de órdenes](https://github.com/WindowsAzure/azure-sdk-tools-xplat). Primero
hay que saber qué imágenes hay disponibles:

	azure vm image list

Por ejemplo, se puede escoger la imagen
`b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu_DAILY_BUILD-trusty-14_04-LTS-amd64-server-20131221-en-us-30GB`
de la última versión de Ubuntu (para salir dentro de cuator meses) o
alguna más probada como la
`b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-13_10-amd64-server-20131215-en-us-30GB`
Con

	azure vm image show b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-13_10-amd64-server-20131215-en-us-30GB
	
nos muestra detalles sobre la imagen; entre otras cosas dónde está
disponible y sobre si es Premium o no (en este caso no lo es). Con
esta (o con otra) podemos crear una máquina virtual

	azure vm create peasomaquina b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-13_10-amd64-server-20131215-en-us-30GB peasousuario PeasoD2clav= --location "West Europe" --ssh

En esta clave tenemos que asignar un nombre de máquina (que se
convertirá en un nombre de dominio `peasomaquina.cloudapp.net`, un
nombre de usuario (como `peasousuario`) que será el superusuario de la
máquina, una clave como `PeasoD2clav=` que debe incluir mayúsculas,
minúsculas, números y caracteres especiales (no uséis esta, hombre),
una localización que en nuestro caso, para producción, será
conveniente que sea *West Europa* pero que para probar podéis
llevárosla a la localización exótica que queráis y, finalmente, para
poder acceder a ella mediante ssh, la última opción, si no no tengo
muy claro cómo se podrá acceder. Una vez hecho esto, conviene que se
cree un par clave pública/privada y se copie al mismo para poder
acceder fácilmente.

La máquina todavía no está funcionando. Con `azure vm list` nos
muestra las máquinas virtuales que tenemos y el nombre que se le ha
asignado y finalmente con `azure vm start` se arranca la máquina y
podemos conectarnos con ella usando `ssh` Una de las primeras cosas
que hay que hacer cuando se arranque es actualizar el sistema para
evitar problemas de seguridad. A partir de ahi, podemos instalar lo
que queramos. El arranque tarda cierto tiempo y dependerá de la
disponibilidad de recursos; evidentemente, mientras no esté arrancada
no se puede usar, pero conviene de todas formas apagarla con 

	azure vm shutdown maquina
	
cuando terminemos la sesión y no sea necesaria, sobre todo porque,
dado que se pagan por tiempo de uso, se puede incurrir en costes
innecesarios. 

<div class='ejercicios' markdown='1'>

Crear una máquina virtual ubuntu e instalar en ella un servidor
nginx para poder acceder mediante web.

</div>

En principio, para configurar la máquina virtual hay que hacerlo como
siempre se ha hecho: trabajando desde línea de órdenes, editando ficheros de configuración e instalando
los paquetes que hagan falta. Pero
[conociendo `juju`](Contenedores.md) tambien
[se puede trabajar con él](https://juju.ubuntu.com/docs/config-azure.html)
para instalar lo que haga falta. Se puede empezar, por ejemplo
[instalando el GUI de juju](https://juju.ubuntu.com/docs/howto-gui-management.html)
para poder a partir de ahí manejar despliegues en máquinas virtuales
desde él. 

<div class='ejercicios' markdown='1'>

Usar `juju` para hacer el ejercicio anterior.

</div>

Trabajar con estas máquinas virtuales como se tratara de máquinas
reales no tiene mucho sentido. El uso de infraestructuras virtuales,
precisamente, lo que permite es automatizar la creación y
provisionamiento de las mismas de forma que se puedan crear y
configurar máquinas en instantes y personalizarlas de forma
masiva. Veremos como hacerlo en el
[siguiente tema](Gestion_de_configuraciones). 

##Automatizando la creación de máquinas virtuales

Una máquina virtual es, desde el punto de vista del administrador,
algo parecido a una máquina real: se arranca con el disco de
instalación y a partir de ahí se instala manualmente. Sin embargo, se
puede intentar también crear automáticamente un disco duro con al
menos parte de las herramientas necesarias y arrancar a partir de
ahí. A este tipo de actividad se le llama *provisionar* y hay
muchas herramientas útiles para ello, pero esencialmente todas hacen
lo mismo: crear un
[dispositivo virtual de almacenamiento](Almacenamiento.md) e instalar
paquetes en él sin necesidad de arrancar la máquina virtual. Este
almacenamiento, posteriormente, se puede agregar luego a la máquina
virtual que se desee o bien usarse para arrancar una máquina virtual
desde él. La ventaja que tiene este tipo de programas es que permite
automatizar la creación de máquinas virtuales y hacerlo
masivamente. La desventaja es que, a priori, es específico del sistema
operativo, aunque veremos más adelante formas de hacerlo
independiente.

Hay diferentes herramientas que se pueden usar para este tipo de
provisionamiento; [Cobbler](http://www.cobblerd.org/) es una de
ellas. [Cobbler](http://en.wikipedia.org/wiki/Cobbler_%28software%29)
permite trabajar no sólo con almacenamiento virtual, sino también con
cualquier dispositivo conectado por red que se pueda acceder desde
fuera con diferentes protocolos. Sin embargo, esta herramienta es un
poco más avanzada y, para el propósito de este artículo, vamos a usar
[`ubuntu-vm-builder`](http://manpages.ubuntu.com/manpages/hardy/man1/ubuntu-vm-builder.1.html)
(que se llamaba previamente `python-vm-builder`), una herramienta
escrita en Python que permite, desde la línea de órdenes, crear una
imagen virtual con las características que le
demos. `ubuntu-vm-builder` necesita tener un hipervisor funcionando;
puede trabajar con Xen, VMWare, kvm y vmserver. Sólo trabaja con una
distribución: Ubuntu (jolines, que se llama `ubuntu-vm-builder`, ¿qué
te esperabas?).

Por otro lado, [también puede usar virt-manager](https://help.ubuntu.com/community/KVM/CreateGuests) para gestionar las máquinas
virtuales creadas, así que habrá que instalar una serie de utilidades
para echarlo a andar:

	sudo ubuntu-vm-builder kvm virt-manager
	
Con eso ya podemos crear una imagen para usar

	sudo vmbuilder kvm ubuntu --suite precise --flavour server 
		 -o --dest /un/directorio/vacío --hostname paraiv --domain paraiv

Esta orden crea, usando el hipervisor kvm, una instalación de Ubuntu
Precise Pangolin, o sea, 12.04. La versión más moderna que tienen es
la 12.04, así que no sé yo el futuro que tiene esta herramienta, que
en todo caso se puede usar para hacer una serie de pruebas. Por otro
lado, con `flavour` se indica el sabor, que puede ser para distros
modernas (aunque no demasiado) o `virtual` o la versión *server* que
es la que elegimos aquí. La siguiente opción `-o` sobreescribe el
contenido de la imagen si existiera y el resto asigna tanto un nombre
externo que podamos usar nosotros desde `virt-manager`(`domain`)
aunque ahora mismo hay un bug que impide usarlo correctamente, como un
hombre interno para el propio ordenador.

Esta orden creará, tras una buena cantidad de minutos, un fichero de nombre ignoto (algo así como
`tmpGAPl8O.qcow2`) en el que habrá una distribución Ubuntu instalada
con un solo usuario, `ubuntu` con la misma clave. Como no se le ha
indicado ninguna personalización, tendrá el teclado en inglés y la
hora que le parezca bien. Una vez construido podemos arrancarlo con 

	sudo qemu-system-x86_64 -drive file=/directorio/donde/este/tmpGAPl8O.qcow2,if=none,id=drive-ide0-0-0,format=qcow2

y trabajar con ella, o directamente con 

	sudo qemu-system-x86_64 -hda /que/me/dir/tmpGAPl8O.qcow2

que carga el sistema del disco duro virtual creado.

<div class='ejercicios' markdown='1'>

Instalar una máquina virtual Ubuntu 12.04 para el hipervisor que
tengas instalado.

</div>

Como la máquina creada anteriormente necesita más trabajo todavía que
una máquina instalada desde una ISO (por aquello de que necesita
instalar idioma, usuarios y demás), en realidad ubuntu-vm-builder
[permite configurar el tamaño del disco, la IP, qué mirror se va a usar para descargar los paquetes, usuarios, claves y también qué paquetes se van a instalar, al menos en el caso de los más comunes](https://help.ubuntu.com/community/KVM/CreateGuests). En
todo caso, este programa permite crear configuraciones de forma fácil
y reproducible usando una sola orden. 

<div class='nota' markdown='1'>

Aparentemente,
[los errores señalados arriba están siendo solucionados](https://bugs.launchpad.net/ubuntu/+source/vm-builder/+bug/1174148)
pero no se encuentran en las últimas versiones disponibles en los
repositorios. Por otro lado
[esta transcripción de una charla por IRC](http://nicolas.barcet.com/drupal/ubuntu-dev-week-vmbuilder)
nos da unas pocas más pistas sobre cómo trabajar con VM y responde a
algunas preguntas. 

</div>

A dónde ir desde aquí
-----

En el [siguiente tema](Gestion_de_configuraciones) pondremos en
práctica todos los conceptos aprendidos en este tema y
[el anterior](Almacenamiento) para crear configuraciones que sean
fácilmente gestionables y adaptables a un fin determinado.
Antes, habrá que hacer y entregar la
[tercera práctica](../practicas/3.MV).

Si lo que necesitas es un sistema ligero de virtualización, puedes
mirar cómo virtualizar con [contenedores](Contenedores.mv).

