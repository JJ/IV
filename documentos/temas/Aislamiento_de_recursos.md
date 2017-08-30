---
layout: index


prev: Intro_concepto_y_soporte_fisico
next: PaaS
---

Aislamiento de recursos
==

<!--@
prev: Intro_concepto_y_soporte_fisico
next: PaaS
-->

<div class="objetivos" markdown="1">

## Objetivos 


### Cubre los siguientes objetivos de la asignatura

2. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica. 

3. Comprender la diferencia entre infraestructura virtual y real. 

4. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

6. Entender el soporte lógico del aislamiento de recursos.

</div>


Restricción y medición del uso de recursos: `cgroups`
-----

<div class='nota' markdown='1'>

Este [vídeo de RedHat](http://www.youtube.com/watch?v=KX5QV4LId_c)
explica cómo y en qué ocasiones se debe usar `cgroups` para gestionar los
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

Los [`cgroups`](http://kaivanov.blogspot.com.es/2012/07/setting-up-linux-cgroups-control-groups.html) usan un mecanismo común a todos los Linux denominado
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

> En Ubuntu 14.04, por ejemplo, se monta por defecto y está en
> `/sys/fs/cgroup`. Si no, se puede instalar `cgroup-lite` para
> instalarlos cuando se arranque el sistema. 

<div class='ejercicios' markdown="1">
Comprobar si en la instalación hecha se ha instalado cgroups y en qué punto está montado, así como qué contiene. 
</div>

Dependiendo de cómo esté configurado, puede contener algo como esto

	blkio.io_merged                   cpuset.memory_pressure
	blkio.io_queued                   cpuset.memory_pressure_enabled
	blkio.io_service_bytes            cpuset.memory_spread_page
	blkio.io_serviced                 cpuset.memory_spread_slab
	...
	
con diferentes ficheros, unos de lectura y escritura y otros de
lectura, que permiten controlar y monitorizar la actividad de los
diferentes grupos de control. O bien un simple `systemd` o

```
blkio  cpuacct  devices  hugetlb  perf_event
cpu    cpuset   freezer  memory   systemd
```

en caso de que `cgroup-lite` se haya instalado y esté funcionando. 

> *Aviso*: lo siguiente puede que no funcione, dependiendo de la
> configuración. Si se ha configurado con cgroup-lite no va a
> funcionar y sólo se podrán crear grupos dentro de directorios determinados. 

Dependiendo de la configuración que se haya creado, crear un *grupo de control* es tan simple como crear un subdirectorio

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
	
Aunque en este caso lo que hemos hecho ha sido aumentarlo del valor 1024 que
se le asigna por defecto. 

Lo más importante es la *contabilidad* que se hace por separado para
cada uno de los grupos; los ficheros con el prefijo `cpuacct`nos darán
información sobre uso; por ejemplo:

	cat /cgroup/malos/cpuacct.usage
	
devolverá un valor similar a

	72012663139

que nos dará una idea del uso de cada grupo en particular y nos
permitirá comparar entre un grupo y otro.

En el caso en que cgroups viniera ya configurado en el sistema
operativo, se puede trabajar de forma similar, pero limitando recursos
específicos, por ejemplo, CPU, de esta forma

```
root@penny:/sys/fs/cgroup/cpu# mkdir alto
root@penny:/sys/fs/cgroup/cpu# mkdir bajo
root@penny:/sys/fs/cgroup/cpu# ls alto/
cgroup.clone_children  cpu.cfs_period_us  cpu.stat
cgroup.event_control   cpu.cfs_quota_us   notify_on_release
cgroup.procs           cpu.shares         tasks
```

Dentro de este directorio se pueden asignar [diferentes procesadores
mediante `cgroup.procs` o tareas específicas a uno u otro
grupo](http://kaivanov.blogspot.com.es/2012/07/setting-up-linux-cgroups-control-groups.html). Instalar
`cgroup-bin` te proporciona diferentes utilidades, como `lscgroup` o
`cgcreate` que te crea grupos con el mismo nombre en todos los
controladores que desees:

```
root@penny:/sys/fs/cgroup# cgcreate -g cpu,cpuacct:/good
root@penny:/sys/fs/cgroup# find . -name good
./cpuacct/good
./cpu/good
```

Esto se puede usar, entre otras cosas, para medir uso de recursos por
parte de diferentes usuarios o grupos de aplicaciones. Por supuesto,
también para aislar recursos y, por tanto, crear infraestructuras
virtuales, pero esto se verá más adelante.


<div class='ejercicios' markdown="1">

1. Crear diferentes grupos de control sobre un sistema operativo
Linux. Ejecutar en uno de ellos el navegador, en otro un procesador de
textos y en uno último cualquier otro proceso. Comparar el uso de
recursos de unos y otros durante un tiempo determinado. 

2. Calcular el coste real de uso de recursos de un ordenador teniendo
en cuenta sus costes de amortización. Añadir los costes eléctricos
correspondientes. 

</div>

El paquete `cgroup-bin` (`libcgroup` en ArchLinux, puede variar en
otras distros) [permite un control por línea de órdenes](https://wiki.archlinux.org/index.php/Cgroups) algo
más sencillo sin necesidad de trabajar directamente con sistemas de
ficheros virtuales. Con una serie de órdenes o un fichero de
configuración en `/etc/cgconfig.conf` [se pueden controlar los
diferentes grupos de control y limitar y contabilizar el uso de
recursos por parte de los diferentes procesos](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Resource_Management_Guide/) que se hayan asignado en
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
de asignación de los mismos a una u otra CPU](https://github.com/IV-GII/GII-2014/issues/4).
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


A dónde ir desde aquí
-----

En el [siguiente tema](PaaS) veremos como usar sistemas de plataforma como servicio. 

