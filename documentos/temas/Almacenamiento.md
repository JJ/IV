---
layout: index

prev: Contenedores
next: Gestion_de_configuracion

---

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
operativo también un almacenamiento virtual en un proceso que se llama
habitualmente
[provisionamiento delgado](http://en.wikipedia.org/wiki/Thin_provisioning). El
término *delgado* indica que el volumen lógico va a tener más espacio
disponible que el espacio físico que realmente ocupa y de forma
práctica se hace creando ficheros en diferentes formatos, ficheros que
serán vistos como un volumen lógico dentro de la máquina virtual con
más espacio del que usan realmente. 



