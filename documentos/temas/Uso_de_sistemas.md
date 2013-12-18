Virtualización completa: uso de máquinas virtuales
==

<!--@
prev: Intro_concepto_y_soporte_fisico
next: Contenedores
-->

<div class="objetivos" markdown="1">

<h2>Objetivos</h2>

1.   Conocer las diferentes tecnologías y herramientas de
virtualización tanto para procesamiento, comunicación y
almacenamiento. 

2. Diseñar, construir y analizar las prestaciones de un centro de
proceso de datos virtual. 

3. Documentar y mantener una plataforma virtual.

4. Realizar tareas de administración en infraestructura virtual.

</div>

Introducción
------------------

El objetivo de las plataforma de virtualización es, eventualmente,
crear una máquina virtual completa que funcione de forma aislada 
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
arquitectura x86 tienen una serie de instrucciones que permiten usarla de manera segura y eficiente]/(http://en.wikipedia.org/wiki/X86_virtualization). Esta
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
operativo, por ejemplo [Debian](http://www.debian.org/distrib/). Con
esos dos ficheros, uno de almacenamiento virtual y una ISO para poder
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

<div class='ejercicios' markdown="1">

Crear varias máquinas virtuales con algún sistema operativo libre,
Linux o BSD. Si se
quieren distribuciones que ocupen poco espacio con el objetivo
principalmente de hacer pruebas se puede usar
[CoreOS](http://coreos.com/) (que sirve como soporte para Docker)
[GALPon Minino](http://minino.galpon.org/en), hecha en Galicia para el
mundo,
[Damn Small Linux](http://www.damnsmalllinux.org/download.html),
[SliTaz](http://www.slitaz.org/en/) (que cabe en 35 megas) y
[ttylinux](http://ttylinux.net/) (basado en línea de órdenes solo). 

</div>
