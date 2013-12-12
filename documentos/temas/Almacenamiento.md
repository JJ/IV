Virtualización del almacenamiento
===

<!--@
prev: Contenedores
next: Gestion_de_configuracion
-->

<div class="objetivos" markdown="1">

Objetivos
--

### Cubre los siguientes objetivos de la asignatura

* Conocer las diferentes tecnologías y herramientas de virtualización
  tanto para procesamiento, comunicación y almacenamiento. 
  
 * Configurar los diferentes dispositivos físicos para acceso a los
  servidores virtuales: acceso de usuarios, redes de comunicaciones o
  entrada/salida
  
 * Diseñar, implementar y construir un centro de procesamiento de
   datos virtual.
   
 * Realizar tareas de administración en infraestructura virtual.
 
### Objetivos específicos
 
 * Conocer las técnicas de provisionamiento de almacenamiento de datos
   para
   máquinas virtuales.
   
 * Saber usar diferentes órdenes y utilidades para crearlas.
 
 </div>
 
 
 La parte verdadera: un disco físico.
 --------
 
 Aunque en principio esté claro que un disco es un disco, en la
 práctica no tiene que ser así. El soporte físico del almacenamiento
 puede ser un disco duro de cualquier formato (rotatorio, SSD), pero
 también una
 [partición](http://en.wikipedia.org/wiki/Partition_%28computing%29)
 de uno, que aparecerá a todos los efectos como un disco físico o lo
 denominado
 [LUN (*Logical Unit Number*)](http://en.wikipedia.org/wiki/Logical_Unit_Number),
 un dispositivo al que se accede usando el protocolo SCSI, un
 protocolo veterano de acceso a discos que permitía conectar varios
 discos cuando nuestro querido SATA sólo podía tener un maestro y un
 esclavo y que se ha licenciado como protocolo para sistemas de discos
 accesibles desde la red, es decir,
 [Storage Area Networks](http://en.wikipedia.org/wiki/Storage_area_network). En
 la práctica, en esta asignatura vamos a usar sobre todo los dos
 primeros pero el segundo se usa en todo centro de datos que se
 precie. 
 
 Cada disco, partición o LUN constituye un volumen físico que tiene
 una serie de bloques llamados *physical extents* (PEs, extensiones
 físicas) y se puede combinar en un [*physical volume group* (PVG,
 grupo de volúmenes físicos)](http://h30499.www3.hp.com/t5/LVM-and-VxVM/what-is-PVG-Physical-Volume-Group/td-p/4675294#.UpuJG0Pzt4w), de forma que un PE de cada volumen en el PVG se usará de forma combinada a la hora de escribir. 
 
 Esta estructura física se reflejará en la estructura lógica, pero la virtualización lo que hace es transformarla de forma que cada elemento lógico equivalga a uno, varios o ningún elemento físico.  

Los
[volúmenes lógicos](http://en.wikipedia.org/wiki/Logical_volume_management)
son una virtualización habitual en los sistemas operativos.  Un
volúmen lógico crea un LE (*logical extent*) a partir de uno PE o
varios en el caso de que se haga *mirroring* transparente. Los LEs se
agrupan en volúmenes lógicos, que aparecen desde el punto de vista del
sistema operativo como cualquier otra partición. En realidad, el
concepto de partición y el de volumen lógico es similar, salvo que una
partición virtualiza siempre parte de un volumen físico y se hace a
un nivel lógico inferior que el de los volúmenes lógicos. En Linux
estos se suelen usar para manejar la partición extendida y crear más
particiones que las cuatro que admite por defecto el formato de tabla
de particiones usual. 

 <div class='ejercicios' markdown="1">
 
 1. ¿Cómo tienes instalado tu disco duro? ¿Usas particiones? ¿Volúmenes lógicos? 
 
2. Si tienes acceso en tu escuela o facultad a un ordenador común para las prácticas, ¿qué almacenamiento físico utiliza? 

3. Buscar ofertas SAN comerciales y comparar su precio con ofertas *locales* (en el propio ordenador) equivalentes.

</div>

<div class='nota' markdown='1'>

En
[esta guía](http://www.idevelopment.info/data/Unix/Linux/LINUX_ManagingPhysicalLogicalVolumes.shtml)
hay un resumen de todos los comandos usados para trabajar con
volúmenes físicos y lógicos en Linux.

</div>

Sistemas de ficheros en espacio de usuario
-----------------------

Los
[FUSE o sistemas de ficheros en espacio de usuario](http://en.wikipedia.org/wiki/Thin_provisioning)
son *drivers* que permiten proyectar sobre el sistema local recursos
remotos como si se trataran de sistemas de ficheros locales y sin
necesidad de usar órdenes privilegiadas para montarlos. Un ejemplo muy
usado es Dropbox, pero en general casi cualquier recurso que se pueda
*mapear* a una estructura de directorios se puede pasar a una metáfora
de sistema de ficheros y hacerlo mediante un programa. Por ejemplo, un
repositorio remoto de `git` podría usarse de esa forma, accediendo a
ficheros en el mismo como si se tratara de ficheros locales (y, de
hecho, eso es lo que hace
[este programa, `gitfuse`](https://github.com/davesque/gitfuse)), que
sólo permite visualizarlos y que está escrito en Python. 

En Linux se usa la librería [FUSE](http://fuse.sourceforge.net/) para
implementarlo. Se puede usar directamente o mediante alguna adaptación
a
[cualquier lenguaje o a cualquier tipo de sistema](http://sourceforge.net/apps/mediawiki/fuse/index.php?title=FileSystems). Por
ejemplo, se puede usar para acceder a ficheros comprimidos
directamente, o a bases de datos, o a la red, o en realidad a casi
cualquier cosa. Por ejemplo, `sshfs` (que debería estar instalado con
el paquete OpenSSH) permite acceder a ficheros remotos como si fueran
locales con el protocolo ssh.

<div class='ejercicios' markdown='1'>

Usar FUSE para acceder a recursos remotos como si fueran ficheros
locales. Por ejemplo, sshfs para acceder a ficheros de una máquina
virtual invitada o de la invitada al anfitrión. 

*Avanzado* Usar los drivers de FUSE para Ruby
 ([aquí explican más o menos como hacerlo con fusefs](http://www.debian-administration.org/articles/619)
 para mostrar el contenido de una estructura de datos en un lenguaje
 como si fuera un
 fichero. [Este es un ejemplo en Python](http://www.stavros.io/posts/python-fuse-filesystem/). 

</div>

El usar la metáfora del sistema de ficheros puede convertir una
estructura de datos remota, o compleja, o simplemente extraña, en una
serie de operaciones perfectamente familiares como leer y escribir en
ficheros o navegar por directorios. Se puede usar tanto
pedagógicamente como para convertir recursos muy diferentes en algo
que pueda ser manejado desde un programa que sólo, o principalmente,
sepa manejar ficheros. En cualquier caso, se trata de un ejemplo
estupendo de virtualización de recursos y de un tipo de recurso que,
también, se puede usar dentro de máquinas virtuales. 


Provisionamiento delgado
----

Una máquina virtual puede usar directamente cualquiera de los
volúmenes físicos o lógicos creados por el sistema operativo, pero lo
más habitual es crear, sobre los volúmenes físicos o lógicos creados por el sistema
operativo,  un almacenamiento virtual en un proceso que se llama
habitualmente
[provisionamiento delgado](http://en.wikipedia.org/wiki/Thin_provisioning). El
término *delgado* indica que el volumen lógico va a tener más espacio
disponible que el espacio físico que realmente ocupa y de forma
práctica se hace creando ficheros en diferentes formatos, ficheros que
serán vistos como un volumen lógico dentro de la máquina virtual con
más espacio del que usan realmente. 

Este almacenamiento virtual puede tener muchos formatos
diferentes. Cada hipervisor, librería, máquina virtual o incluso
[*pools* de recursos admite unos
cuantos; por ejemplo, `libvirt` admite hasta una docena](http://libvirt.org/storage.html). Cualquiera
de estos recursos tendrá que estar disponible (es decir,
*provisionado*) antes de la creación de la máquina virtual, por lo que
conviene *tenerlo a mano* previamente, junto con las herramientas que
trabajan con él. Algunos formatos que son populares son

*
  [`raw` o *poco poblado* (*sparse*)](http://en.wikipedia.org/wiki/Sparse_file):
  son ficheros cuyo formato evita los espacios sin asignar, que se
  representan por metadatos y por lo tanto puede usar en el
  almacenamiento físico menos espacio del asignado inicialmente. Lo
  admiten la mayoría de los sistemas operativos modernos. Para el
  usuario se comportan como los ficheros normales, pero su creación
  necesitará una orden de Linux como esta:
  
	  dd of=fichero-suelto.img bs=1k seek=5242879 count=0
	  
, donde `of` indica el nombre de fichero de salida, `bs` es el tamaño
del bloque y `seek` es el tamaño del fichero en bytes  (menos uno); 
mientras que 

	ls -lks fichero-suelto.img 
	
dice cuantos bloques se han ocupado realmente. También se
[puede hacer](http://stackoverflow.com/questions/257844/quickly-create-a-large-file-on-a-linux-system)
usando `fallocate`:

	fallocate -l 5M fichero-suelto.img
	
lo que tendrá el mismo resultado, aunque este último no funciona en
algunos sistemas de ficheros (como ZFS). 

* [`qcow2`](https://people.gnome.org/~markmc/qcow-image-format.html)
  es un formato usado inicialmente por QEMU pero más adelante
  generalizado a casi todos los gestores de MVs de Linux. Es un
  sistema que usa
  [*copy on write*](http://en.wikipedia.org/wiki/Copy-on-write) para
  mantener la coherencia del resultado en memoria con lo que hay en
  disco a la vez que se optimiza el acceso al mismo. Una forma de
  crear este fichero es con `qemu-img`:
  
	  qemu-img create -f qcow2 fichero-cow.qcow2 5M
	  
lo que aparecerá como un fichero normal y corriente de un tamaño
inferior al indicado (5M). 

Estos ficheros se van a usar como sistemas de ficheros virtuales, pero
eso no quiere decir que haga falta una máquina virtual para
leerlos; se pueden [montar usando `mount`](http://en.wikibooks.org/wiki/QEMU/Images) de la forma siguiente:

	mount -o loop,offset=32256 /camino/a/fichero-suelto.img
	/mnt/mountpoint
	
o, en el caso de qcow2, usando qemu-nbd

	modprobe nbd max_part=16
	qemu-nbd -c /dev/nbd0 fichero-cow.qcow2
	partprobe /dev/nbd0
	mount /dev/nbd0p1 /mnt/image
	
, donde
[NBD se refiere a Network Block Device](http://en.wikipedia.org/wiki/Network_block_device).
En cualquier caso, el objetivo de estas imágenes es precisamente ser
usadas como sistemas de ficheros montables, por lo que, en cualquier
caso, la forma de manipularlas es montándolas en algún anfitrión.
	
<div class='ejercicios' markdown='1'>

Crear imágenes con estos formatos (y otros que se encuentren tales
como VMDK) y manipularlas a base de montarlas o con cualquier otra
utilidad que se encuentre

</div>


Almacenamiento de objetos
----

La metáfora del sistema de ficheros funciona correctamente en la mayor
parte de los casos, pero muchas aplicaciones requieren que se pueda
acceder al almacenamiento mediante un interfaz que permita trabajar
con otro tipo de entidades; por eso el
[almacenamiento de objetos](http://en.wikipedia.org/wiki/Object_storage)
permite manipular entidades en forma de objetos, en vez de ficheros y
directorios; aparte del contenido, los objetos tienen también
metadatos (igual que los ficheros tienen fecha de modificación o un
nombre y camino, que equivale a una identidad única) que permite
indexarlos y manipularlos más fácilmente. 

<div class='nota' markdown='1'>

En [este video](http://www.youtube.com/watch?v=kN7-fzxlllM) se
explica, mediante una animación, qué es el almacenamiento de objetos
en la nube

</div>

En un sistema de almacenamiento de objetos estos se agrupan en cubos
(*buckets*); aparte de este agrupamiento, que no se puede anidar, la
jerarquía de los objetos es totalmente plana y un objeto tiene un ID
único en el cubo o en todo el sistema. El hecho de que un objeto esté
ligado a un ID hace que se pueda almacenar en principio en cualquier
dispositivo físico que esté conectado a la red. 

Los metadatos están también separados físicamente del objeto (a
diferencia de los sistemas de ficheros basados en bloques, en los que
suelen estar ligados al propio fichero o directorio en el que se
encuentra); los sistemas de almacenamiento de objetos suelen tener
servidores diferentes para objetos y para datos, lo que permite
también que sean mucho más escalables. 

Para acceder a los objetos se usan operaciones CRUD (Create, read,
update y delete) habituales, en muchos casos mediante un interfaz REST
basado en la sintaxis del protocolo HTTP. Esto permite cierta
interoperabilidad entre sistemas de diferente procedencia, igual que
todos los sistemas de ficheros usan la misma metáfora de directorios y
ficheros para acceder a los mismos. 

Dado que en la mayor parte de los casos las aplicaciones en nube
requieren este tipo de almacenamiento, muchos sistemas de
almacenamiento en nube, como
[Google cloud storage](https://developers.google.com/storage/index),
[Amazon Elastic Block Store (EBS)](http://aws.amazon.com/es/ebs/) o
[el de SoftLayer](http://www.softlayer.com/cloudlayer/storage/). Todos
estos servicios son de pago (o *freemium* con una capa de pago), pero
también existen soluciones open source que se pueden instalar
localmente como [CEPH](http://ceph.com) u
[OpenStack Cinder](http://en.wikipedia.org/wiki/Openstack#Object_Storage_.28Swift.29). También
se pueden comprar dispositivos físicos que utilizan este tipo de
almacenamiento, como
[Nexenta](http://en.wikipedia.org/wiki/Openstack#Object_Storage_.28Swift.29).

<div class='ejercicios' markdown='1'>

Usar esto en un ejercicio puede ser complicado. No hay sistemas que
ofrezcan almacenamiento gratuito (o que lo ofrezcan sin el uso de una
tarjeta de crédito) y los sistemas como CEPH no son triviales de
usar. El ejercicio, que es de nivel *avanzado*, consistiría en montar
[Lustre](http://lustre.org) o [CEPH](http://ceph.com) o usar Azure o
Amazon para crear un sistema de almacenamiento en bloque.

</div>
