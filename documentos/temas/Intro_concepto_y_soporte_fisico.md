Introducción a la infraestructura virtual: concepto y soporte físico
==

<!--@
next: Tecnicas_de_virtualizacion
-->

<div class="objetivos" markdown="1">

<h2>Objetivos</h2>


1. Conocer la historia de la Computación Virtual, sus orígenes y
razones de su existencia.

2. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica. 

3. Comprender la diferencia entre infraestructura virtual y real. 

4. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.

5. Conocer diferentes tecnologías relacionadas con la virtualización
(Computación nube, *Utility Computing*, *Software as a Service* o Google
AppSpot) 

6. Conocer el concepto de software libre y su importancia dentro de la
computación nube.

7. Usar el sistema de control de fuentes `git`para desarrollo
colaborativo y para despliegue de aplicaciones en la nube.

</div>


<div class="nota" markdown="1">

Se puede consultar
[esta presentación para tener una visión general sobre los servicios en la nube](http://jj.github.io/cloud-computing/#/step-1)

</div>

Introducción 
------------------

En general y en informática, un recurso [virtual](http://en.wikipedia.org/wiki/Virtualization) es un recurso
*irreal*, es decir, un recurso que no se corresponde exactamente con
un recursos físico. Así, *memoria virtual* es la memoria que, en
realidad, está almacenada en parte en un disco o *realidad virtual* es
un entorno inmersivo generado por ordenador que imita a la realidad
(al menos en la inmersión). Una infraestructura virtual será un
recurso -procesador, memoria, disco, aplicación- que no corresponde
exactamente a su equivalente real (no tiene un procesador físico, o un
disco físico exclusivo) sino que se ha creado a través de una serie de
mecanismos computacionales para funcionar como tal.

Una *nube* o *recurso en la nube* es un recurso al que se puede
acceder *bajo demanda*, que es *escalable* y que, desde el punto de
vista dle usuario, se *facturable según uso*, no por acceso.

El [origen
  de la palabra](http://en.wikipedia.org/wiki/Cloud_computing#Origin_of_the_term) viene de la tradicional representación de recursos
  en la red como una nube. 

<div class='ejercicios' markdown='1'>
Consultar en el catálogo de alguna tienda de informática el precio de
un ordenador tipo servidor y calcular su coste de amortización a
cuatro y siete años. Consultar
[este artículo en Infoautónomos sobre el tema](http://www.infoautonomos.com/consultas-a-la-comunidad/988/). 
</div>

Tecnologías de virtualización: un poco de historia
---

Tecnológicamente la computación nube se basa en el proceso progresivo
  de virtualización de recursos computacionales que ha tenido lugar
  prácticamente desde que se empezaron a usar los sistemas de tiempo
  compartido o *time-share* en los años 50. Estos sistemas convertían una sola máquina real en
  diversas *máquinas virtuales*, una por usuario. A estos sistemas se 
  accedía mediante terminales *tontos*, con usuarios *percibiendo* un
  uso exclusivo de los recursos, es decir, teniendo acceso a un
  *ordenador virtual*
  
  En realidad en estos sistemas la protección de memoria o de CPU era
  relativa; la virtualización de recursos en el sentido que la
  conocemos ahora tiene su origen en los 
  *mainframes* de los 60. La
  [línea temporal de tecnologías de virtualización](http://en.wikipedia.org/wiki/Timeline_of_virtualization_development)
  sitúa en los años 60 el desarrollo de los primeros sistemas de
  [memoria virtual](http://en.wikipedia.org/wiki/Virtual_memory) por parte de IBM, con el primer monitor de máquinas virtuales hecho
  en los años 80 sobre el procesador 80286.  
  
  El concepto de *red privada virtual* o VPN (*virtual private
  network*) es posterior y comenzó a usarse en los años noventa,
  simultáneamente a lo que se puede considerar las primeras
  aplicaciones virtuales, los [servicios de correo web](http://en.wikipedia.org/wiki/Webmail) tales como Yahoo
  o Hotmail, que son en realidad una virtualización de las
  aplicaciones de lectura del correo electrónico.  
  
  Todos los conceptos, por lo tanto, tienen origen en el pasado
  pero la computación nube tal como la conocemos resurge a principios
  de siglo por la potencia alcanzada por los
  procesadores y sobre todo por la existencia de soporte físico en los
  mismos para llevar a cabo virtualización de diferentes recursos
  tales como CPU, memoria, almacenamiento y red. Productos privativos como VMWare
  existen desde principios de siglo y otros libres, como [Xen](http://en.wikipedia.org/wiki/Xen), desde el
  año 2003. 
  
  El primer servicio en
  tener esa denominación fue el
  [*elastic compute cloud*](http://en.wikipedia.org/wiki/Amazon_EC2),
  de Amazon, un servicio de creación de máquinas virtuales bajo
  demanda surgido en 2006. A partir de ese momento, se lanzaron
  diferentes servicios similares.
  
  La virtualización de la infraestructura permite:
  
  * Creación y configuración de la misma bajo demanda. En vez de
    desplazar a un técnico, o hacerlo remotamente, se puede
    automatizar la creación de un recurso (a base de *recetas* o
    *plantillas*) y llevarse a cabo cuantas veces se necesite.
	
 * Simplificación del control y despliegue de recursos: permite usar
   diferentes sistemas operativos y en cada caso el más adecuado para
   la tarea que se requiera.
   
* Permite que el *vendor* aproveche mejor el hardware, usando la
  capacidad para servir a diferentes clientes a lo largo del día o de
  la semana y creando tanta infraestructura virtual como la física
  pueda soportar. Esto también reduce la cantidad de energía consumida.
  
* Portabilidad: una máquina virtual se puede mover físicamente de un
    ordenador a otro cuando sea necesario.
	
* Ahorro de costes iniciales en un centro de datos frente a una
      instalación tradicional, aunque eventualmente
      [algunos negocios puedan optar, si tienen un uso intensivo y regular, en volver a una instalación tradicional](https://exploreb2b.com/articles/startups-move-away-from-cloud). 
	  
Todas estas ventajas hacen que,
	  [en el año 2013, más de la mitad de los negocios americanos usan infraestructura virtual](http://www.forbes.com/sites/reuvencohen/2013/04/16/the-cloud-hits-the-mainstream-more-than-half-of-u-s-businesses-now-use-cloud-computing/). 
  
<div class='ejercicios' markdown="1">
Usando las tablas de precios de servicios de alojamiento en Internet y
de proveedores de servicios en la nube, Comparar el coste durante un
año de un ordenador con un procesador estándar (escogerlo de forma que
sea el mismo tipo de procesador en los dos vendedores) y con el resto
de las características similares (tamaño de disco duro equivalente a
transferencia de disco duro) si la infraestructura comprada se usa
sólo el 1% o el 10% del tiempo.
</div>

Tipos de virtualización
-----------------------

El término *virtualización* abarca diferentes técnicas y tecnologías
que tienen todas el mismo objetivo: crear recursos que, desde el punto
de vista de un programa, sean exclusivos. Cada una de las tecnologías
necesita una aplicación determinada para usarse y, en muchos casos,
soporte a nivel de hardware. En todo caso, el sistema operativo o
aplicación que ejecuta las operaciones necesarias para virtualizr se
denomina *anfitrión* y el que se ejecuta *dentro* de la máquina
virtual *invitado*. 

* La
  [virtualización plena](http://en.wikipedia.org/wiki/Full_virtualization)
  virtualiza todos los aspectos de un ordenador para poder ejecutar
  sistemas operativos y otros programas sin modificar. Las
  aplicaciones necesarias para llevarlas a cabo se llaman
  [hipervisores o programas de control](http://en.wikipedia.org/wiki/Hypervisor),
  y para que se consigan de forma completa necesitan soporte hardware
  tal como
  [reescritura binaria y *ensombrecimiento* de estructuras de datos](http://en.wikipedia.org/wiki/X86_virtualization). La
  mayoría de los procesadores modernos de Intel y AMD tienen este tipo
  de soporte. 
  
* La
   [virtualización parcial](http://en.wikipedia.org/wiki/Hardware_virtualization#Partial_virtualization)
   sólo virtualiza algún recurso: la memoria, por ejemplo.
   
* La
  [paravirtualización](http://en.wikipedia.org/wiki/Paravirtualization)
  requiere modificación de los sistemas operativos    

* La
[virtualización a nivel de sistema operativo](http://en.wikipedia.org/wiki/Operating_system-level_virtualization)
sólo permite que anfitrión y cliente usen el mismo sistema operativo
pero con invitados aislados del anfitrión y entre sí. En este caso, en
vez de hablarse de máquinas virtuales se habla de *jaulas*, *zonas* o
*contenedores*; generalmente se trata de aplicaciones de un sistema
operativo determinado y el soporte suele estar a nivel del núcleo de
los mismos. 

* La
  [virtualización de aplicaciones](http://en.wikipedia.org/wiki/Application_virtualization)
  empaqueta aplicaciones de forma que se ejecuten en un entorno que
  las aísla del resto del sistema operativo; una parte es el uso de
  [virtualización de escritorio](http://en.wikipedia.org/wiki/Desktop_virtualization) que permite aplicar una serie de aplicaciones
  generalmente desde un navegador. En general, los programas
  necesarios se denominan *emuladores*; WINE (Windows Emulator)
  permite, por ejemplo, ejecutar aplicaciones de Windows sin
  modificación en Linux y CygWin crea un entorno similar para Windows,
  aunque en este caso las aplicaciones se tienen que
  recompilar. Programas como [CDE](http://github.com/pgbovine/CDE/) en Linux
  permiten empaquetar aplicaciones para que se ejecuten de forma
  independiente en cualquier sistema operativo Linux.

* La *virtualización de entornos de desarrollo* es una práctica
habitual en lenguajes de scripting tales como Perl, Python o Ruby. Se
trata de reproducir entornos de producción de la forma más fiel
posible, incluyendo las versiones de intérpretes y librerías usadas en
el entorno de producción. Esta práctica permite también probar una
aplicación en diferentes versiones con una sola orden. `virtualenv`, `perlbrew`
`rbenv` o `RVM` son diferentes aplicaciones que permiten realizarlo
para diferentes lenguajes. 

<div class='ejercicios' markdown="1">
1. [¿Qué tipo de virtualización usarías en cada caso? Comentar en el foro](https://github.com/IV-GII/GII-2013/issues/1)

2. Crear un programa simple en cualquier lenguaje interpretado para
Linux, empaquetarlo con CDE y probarlo en diferentes distribuciones.
</div>

En realidad, la *contenedorización* de aplicaciones puede usar las
técnicas que se explican en el resto de la asignatura; de hecho, se
pueden crear *paquetes* que permiten ejecutar una aplicación con todas
las dependencias necesarias. Por ejemplo, [docker](http://docker.io)
es una aplicación que permite crear fácilmente aplicaciones
*contenidas* desde línea de órdenes para su uso en cualquier tipo de
contenedor, desde simples contenedores Linux hasta máquinas
virtuales. 

<div class='ejercicios' markdown="1">
Hacer el
[tutorial de línea de órdenes de docker](https://www.docker.io/gettingstarted/#)
para comprender cómo funciona.

*Avanzado* Instalarlo y crear una aplicación contenedorizada
</div>


Desarrollo colaborativo y despliegue de aplicaciones: `git`
----------------------------------------------------------

[git](http://git-scm.com) es un programa distribuido de gestión de
control de versiones. Se diseñó originalmente para la gestión de
fuentes del núcleo de Linux, pero hoy en día se usa también de forma
extensiva para despliegue de aplicaciones.

Un sistema de control de versiones permite saber a quién corresponde
cada cambio en un fuente y revertir tales cambios si hay algún
problema en los mismos. También permite trabajar simultáneamente con
diferentes versiones y, eventualmente, fusionarlas conservando los
cambios en las mismas. El hecho de que se puedan revertir los cambios
y también integrarse en un flujo de desarrollo (que incluya
integración continua, por ejemplo) es la clave de su popularidad en el
despliegue de aplicaciones en la nube.

<div class='nota' markdown='1'>

Esta
[presentación sobre Git y su uso en GitHub](http://www.slideshare.net/jjmerelo/introduccin-al-uso-git-y-github-para-trabajo-colaborativo)
está más enfocada al uso general, pero las órdenes básicas que se usan
para desplegar en la nube se tratan también.

</div>

<div class='ejercicios' markdown="1">
Instala el sistema de gestión de fuentes `git`
</div>

El ciclo básico de uso de `git` consiste, tras la clonación, en hacer
`pull` - modificar - `commit` - `push`. Este último sincroniza la
versión local con la versión remota. Se pueden hacer varios `commits`
antes de hacer `push`; todos los cambios se subirán al hacerlo. En
realidad el programa es mucho más complejo y admite múltiples cambios,
pero a este nivel es suficiente con conocer esto. 

<div class='ejercicios' markdown="1">
1. Crear un proyecto y descargárselo con git. Al crearlo se marca la
opción de incluir el fichero Readme.
2. Modificar el readme y subir el fichero modificado.
</div>

<div class='nota' markdown='1'>

Este [video de 14 minutos](http://www.youtube.com/watch?v=ygbWIJWe29Y)
sirve como introducción al uso de git

</div>


Restricción y medición del uso de recursos: `cgroups`
-----

<div class='nota' markdown='1'>

Este [video de RedHat](http://www.youtube.com/watch?v=KX5QV4LId_c)
explica cómo y en qué ocasiones usar cgroups para gestionar los
recursos de un servidor

</div>

Un primer paso hacia la creación de entornos y más adelante máquinas
virtuales es la implantación de un mecanismo de contención a nivel del
núcleo que permita segregar grupos de procesos y asignarles diferentes
recursos, o limitar el uso de los mismos, según el grupo.  En Linux
esto se consigue usando los denominados
[grupos de control o CGROUPS](http://en.wikipedia.org/wiki/Cgroups),
un mecanismo que se implantó por primera vez a principios de los años
90.

`cgroups` usan un mecanismo común a todos los Linux denominado
sistemas de ficheros virtuales, igual que el sistema `/proc` presente
en todos. En este caso, los que tienen soporte a nivel de kernel
permiten crear un sistema de ficheros en `/cgroups` o en
`/sys/fs/cgroups` a partir del cual se controla el uso de los mismos. 

Si ese sistema de ficheros virtual está ya activado, se puede listar
su contenido usando `ls` o el navegador de ficheros. Si no lo está, se
monta con

	mount -t cgroup cgroup /sys/fs/cgroup/
	
o 

		mount -t cgroup cgroup /cgroup/
		
dependiendo de donde esté configurado.

Un listado de ese directorio arrojará algo como esto

	blkio.io_merged                   cpuset.memory_pressure
	blkio.io_queued                   cpuset.memory_pressure_enabled
	blkio.io_service_bytes            cpuset.memory_spread_page
	blkio.io_serviced                 cpuset.memory_spread_slab
	...
	
con diferentes ficheros, unos de lectura y escritura y otros de
lectura, que permiten controlar y monitorizar la actividad de los
diferentes grupos de control.

Crear un *grupo de control* es tan simple como crear un subdirectorio

	mkdir /cgroup/buenos

aunque se tiene que hacer con permisos de superusuario, para lo cual,
en Ubuntu, habrá que hacer

	sudo su - root
	
La creación de ese grupo automáticamente hace que se creen una serie
de subdirectorios específicos para cada grupo de control, tales como
estos:
 
	 ...
	cpuset.cpu_exclusive              memory.usage_in_bytes
	cpuset.cpus                       memory.use_hierarchy
	cpuset.mem_exclusive              notify_on_release
	cpuset.mem_hardwall               tasks

Este último es, precisamente, el fichero que contiene los PIDs de las
tareas que vamos a regular. Por ejemplo, si queremos limitar todas las
tareas iniciadas desde un intérprete de comandos, averiguamos el PID
de ese intérprete con

	ps aux | grep bash
	
por ejemplo y escribimos, también usando privilegios de root

	echo 0 > /cgroup/malos/cpuset.cpus 
	echo 0 > /cgroup/malos/cpuset.mems 

Estas dos órdenes son imprescindibles para asignar las CPUs por
omisión de las tareas, y sin ellas no se podrá escribir en el
siguiente fichero. En caso de tener varias CPUs, podemos usar el
número de CPU en el que queremos que se ejecute cada grupo de control.

Una vez hecho eso, se asignan las tareas a cada grupo de control

	echo xxx > /cgroup/buenos/tasks
	
Se puede crear otro grupo de control llamado *malos*, por ejemplo,
procediendo de la misma forma, y no olvidando asignar las CPUs y las
memorias antes que las tareas, o no te dejará escribir en las mismas. 

Una vez hecho eso, cada grupo de control será gestionado de forma
independiente y con las restricciones y límites que le
impongamos. Podemos, por ejemplo, limitar el *ancho de banda* de la
CPU:

	echo 512 > /cgroup/buenos/cpu.shares
	
Aunque en este caso lo que hemos hecho ha sido aumentarlo del 1024 que
se le asigna por defecto. 

Lo más importante es la *contabiliad* que se hace por separado para
cada uno de los grupos; los ficheros con el prefijo `cpuacct`nos darán
información sobre uso; por ejemplo:

	cat /cgroup/malos/cpuacct.usage
	
devolverá un valor similar a

	72012663139

que nos dará una idea del uso de cada grupo en particular y nos
permitirá comparar entre un grupo y otro.

<div class='ejercicios' markdown="1">

1. Crear diferentes grupos de control sobre un sistema operativo
Linux. Ejecutar en uno de ellos el navegador, en otro un procesador de
textos y en uno último cualquier otro proceso. Comparar el uso de
recursos de unos y otros durante un tiempo determinado. 

2. Calcular el coste real de uso de recursos de un ordenador teniendo
en cuenta sus costes de amortización. Añadir los costes eléctricos
correspondientes. 

</div>

El paguete `cgroup-bin` (`libcgroup` en ArchLinux, puede variar en
otras distros) [permite un control por línea de órdenes](https://wiki.archlinux.org/index.php/Cgroups) algo
más sencillo sin necesidad de trabajar directamente con sistemas de
ficheros virtuales. Con una serie de órdenes o un fichero de
configuración en `/etc/cgconfig.conf` [se pueden controlar los
diferentes grupos de control y limitar y contabilizar el uso de
recursos por parte de los diferentes procesos](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Resource_Management_Guide/) que se hayan asignado en
los grupos.

Los grupos se crean con la orden `cgcreate`:

	sudo cgcreate -a un_usuario -g memory,cpu,cpuacct:teestoyviendo
	
Esta orden crea un grupo `teestoyviendo` que se encarga de controlar
memoria, CPU y de contabilizar el uso de recursos de la CPU y da
permiso a `un_usuario` para que trabaje con él. El resto de las
órdenes que afecten a este grupo las podrá realizar este usuario. Por
ejemplo, se pueden crear subgrupos con

	cgcreate -g memory,cpu,cpuacct:teestoyviendo/wp
	cgcreate -g memory,cpu,cpuacct:teestoyviendo/navegadores
	
Y cada uno de estos subgrupos se podrá controlar por separado,
teniendo su subdirectorio correspondiente dentro de
`/sys/fs/cgroup/(memory|cpu|cpuacct)` .

Esta librería tiene otra orden, `cgexec`, para ejecutar órdenes dentro
de un grupo determinado, de forma que no haya que añadir el PID de un
proceso a un fichero dentro del sistema de ficheros virtuales
anterior. 

	cgexec   -g memory,cpu,cpuacct:teestoyviendo/wp lowriter
	
Con [cgclassify](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Resource_Management_Guide/sec-Moving_a_Process_to_a_Control_Group.html), para finalizar, podemos cambiar un proceso de
grupo. La sintaxis es la misma que en el caso de cgexec (es decir, usa
la opción `-g`) pero habrá que pasarle un número de proceso. 

Si se quiere trabajar con usuarios en vez de procesos, se puede usar
[cgrules](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Resource_Management_Guide/sec-Moving_a_Process_to_a_Control_Group.html#The_cgred_Service),
un fichero de configuración que permite especificar a qué grupo
pertenece cada usuario e incluso qué comandos de qué usuario deben
pertenecer a cada grupo. Con ello se le puede asignar, por ejemplo,
más prioridad en la CPU o entrada/salida a unos usuarios que a otros. 


<div class='ejercicios' markdown="1">
1. [Discutir diferentes escenarios de limitación de uso de recursos o
de asignación de los mismos a una u otra CPU](https://github.com/IV-GII/GII-2013/issues/4).
2. Implementar usando el fichero de configuración de `cgcreate` una
política que dé menos prioridad a los procesos de usuario que a los
procesos del sistema (o viceversa).
3. Usar un programa que muestre en tiempo real la carga del sistema
tal como `htop`y comprobar los efectos de la migración en tiempo real
de una tarea *pesada* de un procesador a otro (si se tiene dos núcleos
en el sistema).
4. Configurar un servidor para que el servidor web que se ejecute
reciba mayor prioridad de entrada/salida que el resto de los usuarios.
</div>

<div class='nota' markdown='1'>

Algunas aplicaciones están preparadas de serie para usar cgroups: 
[este manual explican cómo asignarle calidades de servicio usando CGROUPS a un marco web denominado uWSCGI](http://uwsgi-docs.readthedocs.org/en/latest/Cgroups.html).

</div>

Virtualización a nivel de *hardware* 
----------------------------------

Los sistemas operativos modernos ofrecen *puentes* para poder usar las
capacidades de virtualización que contienen los procesadores de
sobremesa y portátiles modernos. Hay dos
[tecnologías principales dentro del mundo x86](http://en.wikipedia.org/wiki/X86_virtualization):
[VT-x de Intel](http://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_.28VT-x.29)
y
[AMD-V](http://en.wikipedia.org/wiki/X86_virtualization#AMD_virtualization_.28AMD-V.29). En
algunos casos, esta tecnología está desactivada en la BIOS, por lo que
habrá que comprobar si está activada o no en nuestro caso
particular. Para hacerlo se usa este comando en Linux:

    egrep '^flags.*(vmx|svm)' /proc/cpuinfo
	
`/proc/cpuinfo` es el fichero del sistema de ficheros virtual `/proc`
que da acceso mediante "ficheros" a las estructuras de datos del
núcleo de linux; `cpuinfo` lista las características de la CPU y `vmx`
es el *flag* que se usa para indicar que el procesador usa esta
tecnología; `smd` es el *flag* para AMD-V. `egrep` busca líneas de un
fichero que contengan la expresión regular indicada, y si aparecen los
*flags* listará la línea completa. Si no lista nada, entonces es que
el procesador no tiene esa funcionalidad o está desactivada.

<div class='ejercicios' markdown="1">
Comprobar si el procesador o procesadores instalados lo tienen. ¿Qué
modelo de procesador es? ¿Qué aparece como salida de esa orden?
</div>

Lo que implementan estas tecnologías son una serie de instrucciones
para proteger zonas de memoria, crear máquinas virtuales *anidadas* y
facilitar la virtualización de los buses de entrada/salida. 

Normalmente esta aceleración hardware de la virtualización no se
expone directamente al usuario, sino que se añade una capa de
abstracción en el sistema operativo que, habitualmente, no distingue
entre la aceleración de hardware usada. Esta capa se incluye en el
núcleo del sistema operativo y se expone de alguna forma (a través
de un dispositivo virtual, por ejemplo) para que los *hipervisores* o
aplicaciones para gestionar máquinas virtuales puedan usarlo. 

Esta infraestructura en Linux se llama
[KVM, Kernel-based Virtual Machine](http://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine)
(aunque también se ha usado en otros sistemas operativos). Este
dispositivo se encarga de gestionar la aplicación de memoria del
invitado al anfitrión, crear los dispositivos virtuales de entrada
salida y presentar la salida de video del invitado en el anfitrión. En
realidad, KVM tampoco se usa directamente en general (aunque es una
parte del núcleo con sus características como cualquier otra) sino que
lo habitual es que se use a través de hipervisores tales como
[QEMU](http://en.wikipedia.org/wiki/QEMU). KVM sólo está activado si
puede usar la aceleración por hardware del procesador. 

<div class='ejercicios' markdown="1">
Comprobar si el núcleo instalado en tu ordenador contiene este módulo
del kernel usando la orden `kvm-ok`.
</div>


Niveles de infraestructura virtual
-----

Ya se ha visto en este tema dos niveles de virtualización diferentes,
pero desde el punto de vista comercial se habla de
[tres niveles: *Infrastructure*, *Platform* y *Software* *as a service*](http://en.wikipedia.org/wiki/Cloud_computing)

![Capas de computación nube](http://upload.wikimedia.org/wikipedia/commons/3/3c/Cloud_computing_layers.png)

El nivel superior consiste en una aplicación que, en vez de trabajar
de forma autónoma en el ordenador, tiene una parte contenida en el
servidor. Aunque el desarrollo de las mismas tiene técnicas propias y
el objetivo de la asignatura es crear una aplicación que se pueda
vender como un SaaS, el principal foco de la asignatura será los dos
primeros niveles: Infraestructura como Servicio y Plataforma como
Servicio. La mayoría de los temas estánd dedicados a la creación,
diseño y mantenimiento de IaaS, por lo que dedicaremos especial
atención en este tema al nivel PaaS.

A diferencia del IaaS, que proporciona algo similar al *bare metal* o capacidades de
máquina (CPU, almacenamiento, entrada salida y red) que uno puede
configurar y usar según necesidad, un PaaS contiene infraestructura y
una *pila de soluciones* o *solution stack* completa que permita
desplegar en el mismo nuestras propias aplicaciones.


<div class='ejercicios' markdown="1">

[Comentar diferentes soluciones de *Software as a Service* de uso
habitual.](https://github.com/IV-GII/GII-2013/issues/11)

</div>

Entornos virtuales de desarrollo
---

Los lenguajes de scripting tales como Perl, Python y Ruby tienen
ciclos de desarrollo muy rápidos que hacen que a veces convivan en
producción diferenets versiones de los mismos, incluso *major*
versions. Eso hace complicado desarrollar e incluso probar los
programas que se desarrollan: si el sistema operativo viene con Perl
5.14, puede que haga falta probar o desarrollar para 5.16 o 5.18 o
incluso probar 5.19.

Por eso desde hacer cierto tiempo se han venido usando *entornos
virtuales de desarrollo* tales como
[virtualenv para Python](http://www.virtualenv.org/en/latest/),
[nodeenv para node.js](https://pypi.python.org/pypi/nodeenv/)
[rbenv para Ruby](https://github.com/sstephenson/rbenv) y
[perlbrew para Perl](http://perlbrew.pl).

Una vez instalados, estos programas permiten instalar fácilmente
nuevas versiones de tu lenguaje de programación (con las librerías
asociadas) y probar un programa en todas ellas. Se usan principalmente
para reflejar localmente los entornos que se usan en producción; por
ejemplo, usar en el entorno de desarrollo local la misma versión y
librerías que nos vamos a encontrar en un PaaS tal como los que
veremos a continuación.

<div class='ejercicios' markdown="1">

Instalar un entorno virtual para tu lenguaje de programación favorito
(uno de los mencionados arriba, obviamente).

</div>

Usando un servicio PaaS
-----

La mayoría de los servicios PaaS están ligados a una pila de
soluciones determinada o a un vendedor determinado. Han surgido
muchos, por ejemplo, en torno a [node.js](http://nodejs.org), un
intérprete de JavaScript asíncrono que permite crear fácilmente
aplicaciones REST.

Los servicios PaaS son específicos (sólo alojan una solución
determinada, como [CloudAnt](https://cloudant.com/) que aloja una base
de datos con CouchDB o genéricos, permitiendo una serie de soluciones
en general relativamente limitada; [Heroku](http://heroku.com) y
[OpenShift](http://openshift.com) están entre estos últimos. 

<div class='ejercicios' markdown="1">

Darse de alta en algún servicio PaaS tal como Heroku, Nodejitsu u OpenShift.

</div>

Estos servicios proveen un número limitado de máquinas virtuales y
siguen en general un modelo *freemium*: capacidades básicas son
gratuitas y para conseguir mayores prestaciones o un uso más
intensivo, o bien capacidades que no entren en el paquete básico, hay
que pasar al modelo de pago. Estas máquinas virtuales se denominan
[*dynos*](https://devcenter.heroku.com/articles/dynos) en Heroku y
simplemente aplicaciones en OpenShift, aunque los *dynos* son mucho
más flexibles que las aplicaciones de OpenShift.

La interacción con los PaaS se hace en general a través de una
herramienta de línea de órdenes que permite, para empezar, crear
fácilmente a partir de una plantilla una aplicación básica con las
características definidas; en ambos casos habrá que descargar una
aplicación libre para llevar a cabo ciertas tareas como monitorizar el
status y hacer tests básicos; una vez creado el fuente de la
aplicación el despliegue en la máquina virtual se hace mediante
`git` tal como hemos contado anteriormente. 

Los lenguajes más habituales en las PaaS son los de scripting, que
permiten crear aplicaciones rápidamente; las bases de datos
disponibles son tanto las clásicas DBMS aunque, con más frecuencia, se
usan las bases de datos NoSQL como MongoDB, Redis o CouchDB.

En cualquier caso, los PaaS suelen tener un panel de control que
permite hacer ciertas cosas como configurar *plugins* o *add-ons*
desde la web fácilmente. Estos suelen seguir el mismo modelo freemium:
diferentes tamaños o instancias son gratuitas o tienen un coste; en
algunos casos cualquier instancia tiene un coste. 


<div class='ejercicios' markdown="1">

Crear una aplicación en OpenShift y dentro de ella instalar
WordPress. 

</div>

<div class='nota' markdown='1'>

Este
[video explica como usar `heroku` para aplicaciones en Ruby](http://www.youtube.com/watch?v=dqAXmratgzE);
en
[este un poco más extenso y hecho por una persona de Heroku](http://www.youtube.com/watch?v=VZgHItD9bAQ)
te explica cómo usarlo. No hay muchos videos en español, pero en
[este explica cómo crear una aplicación Django y subirla a Heroku](http://www.youtube.com/watch?v=3k2eg0stnCI)

</div>

A dónde ir desde aquí
-----

En el [siguiente tema](Tecnicas_de_virtualizacion.md) usaremos
diferentes técnicas de virtualización para la creación de contenedores
y jaulas que aislan procesos, usuarios y recursos del resto del sistema. Previamente habrá que [realizar la
práctica correspondiente a esta materia](../practicas/1.PaaS.md). 

