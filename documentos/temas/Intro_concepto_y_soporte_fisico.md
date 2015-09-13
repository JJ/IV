---
layout: index


next: Desarrollo_basado_en_pruebas
---

Introducción a la infraestructura virtual: concepto y soporte físico
==

<!--@
next: Desarrollo_basado_en_pruebas
-->

<div class="objetivos" markdown="1">

##Objetivos 

### Cubre los siguientes objetivos de la asignatura

1. Conocer la historia de la Computación Virtual, sus orígenes y
razones de su existencia.

2. Conocer los conceptos relacionados con el proceso de virtualización
tanto de software como de hardware y ponerlos en práctica. 

3. Comprender la diferencia entre infraestructura virtual y real. 

4. Justificar la necesidad de procesamiento virtual frente a real en el contexto de una infraestructura TIC de una organización.

### Objetivos específicos

5. Conocer diferentes tecnologías relacionadas con la virtualización
(Computación nube, *Utility Computing*, *Software as a Service* o Google
AppSpot) 

6. Conocer el concepto de software libre y su importancia dentro de la
computación nube.

6. Entender el concepto de *DevOps* y las técnicas y tecnologías que cubre. 

7. Usar el sistema de control de fuentes `git`para desarrollo
colaborativo y para despliegue de aplicaciones en la nube.

</div>


<div class="nota" markdown="1">

Se puede consultar
[esta presentación para tener una visión general sobre los servicios en la nube](https://jj.github.io/cloud-computing/)

</div>

Introducción 
------------------

En general y en Informática, un recurso [virtual](https://en.wikipedia.org/wiki/Virtualization) es un recurso
*irreal*, es decir, un recurso que no tiene equivalente físico directo. Así, *memoria virtual* es la memoria que, en
realidad, está almacenada en parte en un disco o *realidad virtual* es
un entorno inmersivo generado por ordenador que imita a la realidad
(al menos en que se puede situar uno *dentro* de ella). Una infraestructura virtual será un
recurso -procesador, memoria, disco, conjunto de aplicaciones o incluso una sola aplicación- que no corresponde
exactamente a su equivalente real (no tiene un procesador físico, o un
disco físico exclusivo) sino que se ha creado a través de una serie de
mecanismos computacionales para funcionar como tal.

A partir de esto, un *recurso en la nube* es aquel al que se puede
acceder *bajo demanda*, que es *escalable* y que, desde el punto de
vista del usuario, se *facturable según uso*, no por el hecho de tener acceso.

El [origen
  de la palabra](https://en.wikipedia.org/wiki/Cloud_computing#Origin_of_the_term) viene de la tradicional representación de recursos
  en la red como una nube. 

<div class='ejercicios' markdown='1'>
Consultar en el catálogo de alguna tienda de informática el precio de
un ordenador tipo servidor y calcular su coste de amortización a
cuatro y siete años. Consultar
[este artículo en Infoautónomos sobre el tema](http://www.infoautonomos.com/consultas-a-la-comunidad/988/). 
</div>

Desde el punto de vista del desarrollo, la creación y gestión de
infraestructuras virtuales entra dentro del concepto de
[*DevOps*](https://en.wikipedia.org/wiki/DevOps), un concepto que
abarca tanto sistemas como desarrollo y que está a caballo de
ambos. En primer lugar, *DevOps* implica la automatizació de las
tareas de creación de un puesto de trabajo para desarrollo, pero
también la sistematización de pruebas, de despliegue y de las tareas
de configuración relacionadas con la misma, todo ello en un entorno de
desarrollo ágil. En concreto, *DevOps* comprende
[los 7 aspectos siguientes, vistos en la página de una herramienta, Rex, usada para ello](https://www.rexify.org/):

1. Automatización de tareas relacionadas con el desarrollo. En
   resumen, que no haya que recordar comandos para hacer todo tipo de
   cosas (instalación de librerías o configuración de una máquina)
   sino que haya *scripts* que lo homogeneicen y automaticen.

2. Virtualización: uso de recursos virtuales para almacenamiento,
   publicación y, en general, todos los pasos del desarrollo y
   despliegue de software.

5. Provisionamiento de los servidores: los servidores virtuales a los
   que se despliegue deben estar preparados con todas las herramientas
   necesarias para publicar la aplicación.

6. Gestión de configuraciones: la gestión de las configuraciones de
   los servidores y las órdenes para provisionamiento deben estar
   controladas por un sistema de gestión de versiones que permita
   pruebas y también controlar en cada momento el entorno en el que
   efectivamente se está ejecutando el software.

3. Despliegue en la nube: publicación de aplicaciones en servidores
   virtuales.


4. [Ciclo de vida del software](https://es.slideshare.net/colmbennett/software-rollout)
   definición de las diferentes fases en la vida de una aplicación,
   desde el diseño hasta el soporte.

7. Despliegue continuo: el ciclo de vida de una aplicación debe ir
   ligado a ciclos de desarrollo ágiles en los que cada nueva
   característica se introduzca tan pronto esté lista y probada; el
   despliegue continuo implica integración continua de las nuevas
   características y arreglos, tanto en el software como el hardware. 



Tecnologías de virtualización: un poco de historia
---

Tecnológicamente la computación nube se basa en el proceso progresivo
  de virtualización de recursos computacionales que ha tenido lugar
  prácticamente desde que se empezaron a usar los sistemas de tiempo
  compartido o *time-share* en los años 50. Estos sistemas convertían una sola máquina real en
  diversas *máquinas virtuales*, una por usuario. A estos sistemas se 
  accedía mediante terminales *tontos*, con usuarios *percibiendo* un
  uso exclusivo de los recursos, es decir, teniendo acceso a un
  *ordenador virtual*.
  
  En realidad en estos sistemas la protección de memoria o de CPU era
  relativa; la virtualización de recursos en el sentido que la
  conocemos ahora tiene su origen en los 
  *mainframes* de los 60. La
  [línea temporal de tecnologías de virtualización](https://en.wikipedia.org/wiki/Timeline_of_virtualization_development)
  sitúa en los años 60 el desarrollo de los primeros sistemas de
  [memoria virtual](https://en.wikipedia.org/wiki/Virtual_memory) por parte de IBM, con el primer monitor de máquinas virtuales hecho
  en los años 80 sobre el procesador 80286.  
  
  El concepto de *red privada virtual* o VPN (*virtual private
  network*) es posterior y comenzó a usarse en los años noventa,
  simultáneamente a lo que se puede considerar las primeras
  aplicaciones virtuales, los [servicios de correo web](https://en.wikipedia.org/wiki/Webmail) tales como Yahoo
  o Hotmail, que son en realidad una virtualización de las
  aplicaciones de lectura del correo electrónico.  
  
  Todos los conceptos, por lo tanto, tienen origen en el pasado
  pero la computación nube tal como la conocemos resurge a principios
  de siglo por la potencia alcanzada por los
  procesadores y sobre todo por la existencia de soporte físico en los
  mismos para llevar a cabo virtualización de diferentes recursos
  tales como CPU, memoria, almacenamiento y red. Productos privativos como VMWare
  existen desde principios de siglo y otros libres, como [Xen](https://en.wikipedia.org/wiki/Xen), desde el
  año 2003. 
  
  El primer servicio en
  tener esa denominación fue el
  [*Elastic Compute Cloud*, EC2](https://en.wikipedia.org/wiki/Amazon_EC2),
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
      instalación tradicional, aunque eventualmente algunos negocios puedan optar, si tienen un uso intensivo y regular, en volver ella. 
	  
Todas estas ventajas hacen que,
	  [ya en el año 2013, más de la mitad de los negocios americanos usan infraestructura virtual](http://www.forbes.com/sites/reuvencohen/2013/04/16/the-cloud-hits-the-mainstream-more-than-half-of-u-s-businesses-now-use-cloud-computing/). 
  
<div class='ejercicios' markdown="1">
Usando las tablas de precios de servicios de alojamiento en Internet y
de proveedores de servicios en la nube, Comparar el coste durante un
año de un ordenador con un procesador estándar (escogerlo de forma que
sea el mismo tipo de procesador en los dos vendedores) y con el resto
de las características similares (tamaño de disco duro equivalente a
transferencia de disco duro) en el caso de que la infraestructura comprada se usa
sólo el 1% o el 10% del tiempo.
</div>

Tipos de virtualización
-----------------------

El término *virtualización* abarca diferentes técnicas y tecnologías
que tienen todas el mismo objetivo: crear recursos que, desde el punto
de vista de un programa, sean exclusivos. Cada una de las tecnologías
necesita una aplicación determinada para usarse y, en muchos casos,
soporte a nivel de hardware. En todo caso, el sistema operativo o
aplicación que ejecuta las operaciones necesarias para virtualizar se
denomina *anfitrión* y el que se ejecuta *dentro* de la máquina
virtual *invitado*. 

* La
  [virtualización plena](https://en.wikipedia.org/wiki/Full_virtualization)
  virtualiza todos los aspectos de un ordenador para poder ejecutar
  sistemas operativos y otros programas sin modificar. Las
  aplicaciones necesarias para llevarlas a cabo se llaman
  [hipervisores o programas de control](https://en.wikipedia.org/wiki/Hypervisor),
  y para que se consigan de forma completa necesitan soporte hardware
  tal como
  [reescritura binaria y *ensombrecimiento* de estructuras de datos](https://en.wikipedia.org/wiki/X86_virtualization). La
  mayoría de los procesadores modernos de Intel y AMD tienen este tipo
  de soporte. 
  
* La
   [virtualización parcial](https://en.wikipedia.org/wiki/Hardware_virtualization#Partial_virtualization)
   sólo virtualiza algún recurso: la memoria, por ejemplo.
   
* La
  [paravirtualización](https://en.wikipedia.org/wiki/Paravirtualization)
  requiere modificación de los sistemas operativos    

* La
[virtualización a nivel de sistema operativo](https://en.wikipedia.org/wiki/Operating_system-level_virtualization)
sólo permite que anfitrión y cliente usen el mismo sistema operativo
pero con invitados aislados del anfitrión y entre sí. En este caso, en
vez de hablarse de máquinas virtuales se habla de *jaulas*, *zonas* o
*contenedores*; generalmente se trata de aplicaciones de un sistema
operativo determinado y el soporte suele estar a nivel del núcleo de
los mismos. 

* La
  [virtualización de aplicaciones](https://en.wikipedia.org/wiki/Application_virtualization)
  empaqueta aplicaciones de forma que se ejecuten en un entorno que
  las aísla del resto del sistema operativo; una parte es el uso de
  [virtualización de escritorio](https://en.wikipedia.org/wiki/Desktop_virtualization) que permite aplicar una serie de aplicaciones
  generalmente desde un navegador. En general, los programas
  necesarios se denominan *emuladores*; WINE (Windows Emulator)
  permite, por ejemplo, ejecutar aplicaciones de Windows sin
  modificación en Linux y CygWin crea un entorno similar para Windows,
  aunque en este caso las aplicaciones se tienen que
  recompilar. Programas como [CDE](https://github.com/pgbovine/CDE/) en Linux
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
1. [¿Qué tipo de virtualización usarías en cada caso? Comentar en el foro](https://github.com/JJ/IV-2015-16/issues/1)

2. Crear un programa simple en cualquier lenguaje interpretado para
Linux, empaquetarlo con CDE y probarlo en diferentes distribuciones.
</div>

En realidad, la *contenedorización* de aplicaciones puede usar las
técnicas que se explican en el resto de la asignatura; de hecho, se
pueden crear *paquetes* que permiten ejecutar una aplicación con todas
las dependencias necesarias. Por ejemplo, [*docker*](https://www.docker.com)
es una aplicación que permite crear fácilmente aplicaciones
*contenidas* desde línea de órdenes para su uso en cualquier tipo de
contenedor, desde simples contenedores Linux hasta máquinas
virtuales. 


Desarrollo colaborativo y despliegue de aplicaciones: `git`
----------------------------------------------------------

[git](https://git-scm.com) es un programa distribuido de gestión de
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
[presentación sobre Git y su uso en GitHub](https://www.slideshare.net/jjmerelo/introduccin-al-uso-git-y-github-para-trabajo-colaborativo)
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
opción de incluir el fichero `README`.
2. Modificar el readme y subir el fichero modificado.
</div>

<div class='nota' markdown='1'>

Este [vídeo de 14 minutos](https://www.youtube.com/watch?v=ygbWIJWe29Y)
sirve como introducción al uso de `git`.

</div>


Virtualización a nivel de *hardware* 
----------------------------------

Los sistemas operativos modernos ofrecen *puentes* para poder usar las
capacidades de virtualización que contienen los procesadores de
sobremesa y portátiles modernos. Hay dos
[tecnologías principales dentro del mundo x86](https://en.wikipedia.org/wiki/X86_virtualization):
[VT-x de Intel](https://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_.28VT-x.29)
y
[AMD-V](https://en.wikipedia.org/wiki/X86_virtualization#AMD_virtualization_.28AMD-V.29). En
algunos casos, esta tecnología está desactivada en la BIOS, por lo que
habrá que comprobar si está activada o no en nuestro caso
particular. Para hacerlo se usa este comando en Linux:

    egrep '^flags.*(vmx|svm)' /proc/cpuinfo
	
`/proc/cpuinfo` es el fichero del sistema de ficheros virtual `/proc`
que da acceso mediante "ficheros" a las estructuras de datos del
núcleo de Linux; `cpuinfo` lista las características de la CPU y `vmx`
es el *flag* que se usa para indicar que el procesador usa esta
tecnología; `smd` es el *flag* para AMD-V. `egrep` busca líneas de un
fichero que contengan la expresión regular indicada, y si aparecen los
*flags* listará la línea completa. Si no lista nada, entonces es que
el procesador no tiene esa funcionalidad o está desactivada.

<div class='ejercicios' markdown="1">
Comprobar si el procesador o procesadores instalados tienen estos *flags*. ¿Qué
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
[KVM, Kernel-based Virtual Machine](https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine)
(aunque también se ha usado en otros sistemas operativos). Este
dispositivo se encarga de gestionar la aplicación de memoria del
invitado al anfitrión, crear los dispositivos virtuales de entrada
salida y presentar la salida de vídeo del invitado en el anfitrión. En
realidad, KVM tampoco se usa directamente en general (aunque es una
parte del núcleo con sus características como cualquier otra) sino que
lo habitual es que se use a través de hipervisores tales como
[QEMU](https://en.wikipedia.org/wiki/QEMU). KVM sólo está activado si
puede usar la aceleración por hardware del procesador. 

<div class='ejercicios' markdown="1">
1. Comprobar si el núcleo instalado en tu ordenador contiene este módulo
del kernel usando la orden `kvm-ok`.

2. Instalar un hipervisor para gestionar máquinas virtuales, que más adelante se podrá usar en pruebas y ejercicios. 
</div>


Niveles de infraestructura virtual
-----

Ya se ha visto en este tema dos niveles de virtualización diferentes,
pero desde el punto de vista comercial se habla de
[tres niveles: *Infrastructure*, *Platform* y *Software* *as a service*](https://en.wikipedia.org/wiki/Cloud_computing)

![Capas de computación nube](https://upload.wikimedia.org/wikipedia/commons/3/3c/Cloud_computing_layers.png)

El nivel superior consiste en una aplicación que, en vez de trabajar
de forma autónoma en el ordenador, tiene una parte contenida en el
servidor. Aunque el desarrollo de las mismas tiene técnicas propias y
el objetivo de la asignatura es crear una aplicación que se pueda
vender como un SaaS, el principal foco de la asignatura será los dos
primeros niveles: Infraestructura como Servicio y Plataforma como
Servicio. La mayoría de los temas están dedicados a la creación,
diseño y mantenimiento de IaaS, por lo que dedicaremos especial
atención en este tema al nivel PaaS.

A diferencia del IaaS, que proporciona algo similar al *bare metal* o capacidades de
máquina (CPU, almacenamiento, entrada salida y red) que uno puede
configurar y usar según la necesidad que haya, un PaaS contiene infraestructura y
una *pila de soluciones* o *solution stack* completa que permita
desplegar en el mismo nuestras propias aplicaciones.

En realidad, pocos vendedores ofrecen simples *IaaS*. Lo más normal es
que permitan usarlos a ese nivel, pero a la vez tengan un sistema
fácil para añadir funcionalidad y combinarla en una pila completa de
soluciones que incluya el sistema de almacenamiento de datos y el
marco web de aplicaciones, junto con sistemas de monitorización y de
análisis de las peticiones. Es difícil hoy en día (año 2015) encontrar un IaaS
simple, de hecho.  


A dónde ir desde aquí
-----

En el temario se verá a continuación [los ciclos de desarrollo modernos usando desarrollo basado en pruebas, *test-driven development*, TDD](Desarrollo_basado_en_pruebas), pero se puede salar direcamente al [tema dedicado a las plataformas como servicio](PaaS) veremos como usarlos. Previamente habrá que [realizar la
práctica correspondiente a esta materia](../practicas/1.Infraestructura). 

