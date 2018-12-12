Gestión de infraestructuras virtuales
===

<!--@
prev: Uso_de_sistemas
-->

<div class="objetivos" markdown="1">

## Objetivos de la asignatura

* Diseñar, construir y analizar las prestaciones de un centro de
  proceso de datos virtual. 
  
* Documentar y mantener una plataforma virtual.

* Realizar tareas de administración en infraestructura virtual.

## Objetivos específicos

1. Aprender lenguajes de configuración usados en infraestructuras virtuales.
2. Saber cómo aplicarlos en un caso determinado.
3. Conocer los sistemas de gestión de la configuración,
provisionamiento y monitorización más usados hoy en día.

</div>

Introducción
---

Los [contenedores](Contenedores.md) son un ejemplo de virtualización que ya tienen
ciertas características de las máquinas virtuales, como el aislamiento y la gestión
independiente. Pero en general, un contenedor aisla un solo servicio y en arquitecturas de aplicaciones modernas es muchas veces necesario crear máquinas 
virtuales con características determinadas tales como diferentes sistemas operativos o diferentes características del sistema de ficheros o kernel, por lo que se hace
necesario usar herramientas para crear y configurar estos
entornos.

Estas herramientas se denominan, en general,
[gestores de configuración](https://en.wikipedia.org/wiki/Configuration_management). [Vagrant](https://en.wikipedia.org/wiki/Vagrant_%28software%29)
es uno de ellos y se sitúa al nivel más alto, pero también hay otros: [Chef](http://www.getchef.com/chef/), Salt y Puppet, por
ejemplo, que se pueden usar desde Vagrant pero que también se usan para gestionar configuraciones complejas de sistemas en la nube.
Todos son libres, pero
[tienen características específicas](https://en.wikipedia.org/wiki/Comparison_of_open_source_configuration_management_software)
que hay que tener en cuenta a la hora de elegir uno u otro. En el caso
específico de
[sistemas operativos](https://en.wikipedia.org/wiki/Configuration_management#Operating_System_configuration_management)
se trata de gestionar automáticamente todas las tareas de
configuración de un sistema, automatizando la edición de ficheros de
configuración, instalación de software y configuración del mismo,
creación de usuarios y autenticación, de forma que se pueda hacer de
forma automática y masiva. 

A continuación veremos diferentes ejemplos de sistemas de
configuración, empezando por Chef. 

Usando Chef para provisionamiento
-----

En el año 2018, Chef ha introducido una nueva versión
denominada
[Chef Workstation](https://blog.chef.io/2018/05/23/introducing-chef-workstation/) que
hace más simple trabajar de forma local o remota. Consultad [los recursos de la misma](https://www.chef.sh/docs/chef-workstation/getting-started/) para
saber más

> [Este vídeo](https://www.youtube.com/watch?v=dTIyS816dOA) es una
> introducción a Chef Workstation, a la vez que explica los conceptos
> básicos para trabajar con los cookbooks de Chef. 
> El [repositorio de la presentación](https://github.com/JJ/chef)
> incluye varios *cookbooks* de ejemplo.

Otros sistemas de gestión de configuración
---

Las principales alternativas a Chef son [Ansible](http://ansible.com),
[Salt](http://www.saltstack.com/) y [Puppet](http://docs.puppetlabs.com/guides/installation.html). Todos ellos se comparan en
[este artículo](http://www.infoworld.com/d/data-center/review-puppet-vs-chef-vs-ansible-vs-salt-231308),
aunque los principales contendientes son
[Puppet y Chef, sin que ninguno de los dos sea perfecto](http://www.infoworld.com/d/data-center/puppet-or-chef-the-configuration-management-dilemma-215279?source=fssr). 

De todas ellas, vamos a
[ver Ansible](https://davidwinter.me/introduction-to-ansible/)
que parece ser uno de los que se está desarrollando con más intensidad
últimamente. [Ansible es](https://en.wikipedia.org/wiki/Ansible_%28software%29)
sistema de gestión remota de configuración que permite gestionar
simultáneamente miles de sistemas diferentes. Está basado en YAML para
la descripción de los sistemas y escrito en Python. 

Se puede instalar como un módulo de Python, usando por ejemplo la utilidad de
instalación de módulos `pip` (que habrá que instalar si no se tiene);
también se puede instalar directamente desde su repositorio PPA en Ubuntu

```
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get install ansible
```

El resto de las utilidades son también necesarias y en realidad se
instalan automáticamente al instalar ansible. Estas utilidades se
tienen que instalar *en el anfitrión*, no hace falta instalarlas en el
invitado, que lo único que necesitará, en principio, es tener activada
la conexión por ssh y tener una cuenta válida y forma válida de
acceder a ella.

Cada máquina que se añada al control de Ansible se tiene que añadir a
un
[fichero, llamado inventario](http://docs.ansible.com/intro_inventory.html),
que contiene las diferentes máquinas controladas por el mismo. Por
ejemplo

```
$ echo "ansible-iv.cloudapp.net" > ~/ansible_hosts
```

se puede ejecutar desde el *shell* para meter (`echo`) una cadena con
una dirección (en este caso, una máquina virtual de Azure) en el
fichero `ansible_hosts` situado en mi directorio raíz. El lugar de ese
fichero es arbitrario, por lo que habrá que avisar a Ansible donde
está usando una variable de entorno:

```
	export ANSIBLE_HOSTS=~/ansible_hosts
```

Y, con un nodo, ya se puede comprobar si Ansible funciona con 

```
	$ ansible all -u jjmerelo -m ping
```

Esta orden hace un *ping*, es decir, simplemente comprueba si la
máquina es accesible desde la máquina local. `-u ` incluye el nombre
del usuario (si es diferente del de la máquina local); habrá que
añadir `--ask-pass` si no se ha configurado la máquina remota para
poder acceder a ella sin clave. 

De forma básica, lo que hace Ansible es simplemente ejecutar comandos
de forma remota y simultáneamente. Para hacerlo, podemos usar el
[inventario para agrupar los servidores](http://docs.ansible.com/intro_inventory.html), por ejemplo

```
	[azure]
	iv-ansible.cloudapp.net
```

crearía un grupo `azure` (con un solo ordenador), en el cual podemos
ejecutar comandos de forma remota

```
	$ ansible azure -u jjmerelo -a df
```

nos mostraría en todas las máquinas de Azure la organización del
sistema de ficheros (que es lo que hace el comando `df`). Una vez más,
`-u` es opcional. 

Esta orden usa un *módulo* de ansible y se puede ejecutar también de
esta forma:

```
	$ ansible azure -m shell ls
```

haciendo uso del módulo `shell`. Hay muchos
[más módulos](http://docs.ansible.com/modules.html) a los que se le
pueden enviar comandos del tipo "variable = valor". Por ejemplo, se
puede trabajar con servidores web o
[copiar ficheros](http://docs.ansible.com/intro_adhoc.html#file-transfer)
o
[incluso desplegar aplicaciones directamente usando el módulo `git`](http://docs.ansible.com/intro_adhoc.html#managing-packages)

Finalmente, el concepto similar a las recetas de Chef en Ansible son los
[*playbooks*](https://davidwinter.me/articles/2013/11/23/introduction-to-ansible/),
ficheros en YAML que le dicen a la máquina virtual qué es lo que hay
que instalar en *tareas*, de la forma siguiente

```
	---
	- hosts: azure
	  sudo: yes
	  tasks:
		- name: Update emacs
		  apt: pkg=emacs state=present
```

Esto se guarda en un fichero y se
[le llama, por ejemplo, emacs.yml](../../ejemplos/ansible/emacs.yml),
y se ejecuta con 

```
ansible-playbook ../../ejemplos/ansible/emacs.yml 
```

(recordando siempre el temita del nombre de usuario), lo que dará, si
todo ha ido bien, un resultado como el siguiente

![Instalación de emacs usando ansible](../img/ansible.png)

En el fichero YAML lo que se está expresando es un array asociativo
con las claves `hosts`, `sudo` y `tasks`. En el primero ponemos el
bloque de servidores en el que vamos a actuar, en el segundo si hace
falta hacer sudo o no y en el tercero las tareas que vamos a ejecutar,
en este caso una sola. El apartado de tareas es un vector de hashes,
cada uno de los cuales tiene en `name` el nombre de la tarea, a título
informativo y en las otras claves lo que se va a hacer; `apt` indicará
que hay que instalar un paquete (`pkg`) llamado `emacs` y que hay que
comprobar si está presente o no (`state`). El que se trabaje con
*estados* y no de forma imperativa hace que los *playbooks* sean
*idempotentes*, es decir, si se ejecutan varias veces darán el mismo
resultado que si se ejecutan una sola vez. 

<div class='ejercicios' markdown='1'>

Desplegar la aplicación de DAI  con todos los módulos necesarios
usando un *playbook* de Ansible.

</div>

Orquestación de máquinas virtuales
---------------

A un nivel superior al provisionamiento de máquinas virtuales está la configuración,
orquestación y gestión de las mismas, herramientas como
[Vagrant](http://vagrantup.com) ayudan a hacerlo, aunque también
Puppet e incluso Juju pueden hacer muchas de las funciones de
Vagrant. La ventaja de Vagrant es que permite gestionar el ciclo de vida
completo de una máquina virtual, desde la creación hasta su
destrucción pasando por el provisionamiento y la monitorización o
conexión con la misma. Además, permite trabajar con todo tipo de
hipervisores y provisionadores tales como los que hemos visto
anteriormente.

Con Vagrant [te puedes descargar directamente](https://gist.github.com/dergachev/3866825)
[una máquina configurada de esta lista](http://www.vagrantbox.es/). Por
ejemplo, 

```
	vagrant box add centos65 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box
```

El formato determinará en qué tipo de hipervisor se puede ejecutar; en
general, Vagrant usa VirtualBox, y los `.box` se ejecutan precisamente
en ese formato. Otras imágenes están configuradas para trabajar con
VMWare, pero son las menos. A continuación,

```
	vagrant init centos65
```

crea un fichero `Vagrantfile` (y así te lo dice) que permite trabajar
y llevar a cabo cualquier configuración adicional. Una vez hecho eso
ya podemos inicializar la máquina y trabajar con ella (pero antes voy
a apagar la máquina Azure que tengo ejecutándose desde que empecé a
contar lo anterior)

```
	vagrant up
```

y se puede empezar a trabajar en ella con 

```
vagrant ssh
```

<div class='ejercicios' markdown='1'>

Instalar una máquina virtual Debian usando Vagrant y conectar con ella.
​	
</div>


Una vez creada la máquina virtual se puede entrar en ella y
configurarla e instalar todo lo necesario. Pero, por supuesto,
sabiendo lo que sabemos sobre provisionamiento, Vagrant permite
[provisionarla de muchas maneras diferentes](http://docs.vagrantup.com/provisioning/index.html). En
general, Vagrant usará opciones de configuración diferente dependiendo
del provisionador, subirá un fichero a un directorio temporal del
mismo y lo ejecutará (tras ejecutar todo lo necesario para el mismo). 

La provisión tiene lugar cuando se *alza* una máquina virtual (con
`vagrant up`) o bien explícitamente haciendo `vagrant provision`. En
cualquier caso se lee del Vagrantfile y se llevan a cabo las acciones
especificadas en el fichero de configuración. 

En general, trabajar con un provisionador requiere especificar de cuál
se trata y luego dar una serie de órdenes específicas. Comenzaremos
por el
[*shell*](http://docs.vagrantup.com//provisioning/shell.html), que
es el más simple y, en realidad, equivale a entrar en la máquina y dar
las órdenes a mano. Instalaremos, como hemos hecho en otras ocasiones,
el utilísimo editor `emacs`usando este
[`Vagrantfile`](../../ejemplos/vagrant/provision/Vagrantfile):

```
	VAGRANTFILE_API_VERSION = "2"

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
		config.vm.box = "centos65"

	    config.vm.provision "shell",
			inline: "yum install -y emacs"
	end
```

Recordemos que se trata de un programa en Ruby en el cual configuramos
la máquina virtual. La 4ª línea indica el nombre de la máquina con la
que vamos a trabajar (que puede ser la usada en el caso anterior);
recordemos también que, por omisión, se trabaja con VirtualBox (si se
hiciera con algún otro tipo de hipervisor habría que usar el *plugin*
correspondiente e inicializar la máquina de alguna otra forma). La
parte en la que efectivamente se hace la provisión va justamente a
continuación. La orden `config.vm.provision` indica que se va a usar
el sistema de provisión del `shell`, es decir, órdenes de la línea de
comandos; se le pasa un hash en Ruby  (variable: valor, tal como en
JavaScript, separados por comas) en el que la clave `inline` indica el
comando que se va a ejecutar, en este caso `yum`, el programa para
instalar paquetes en CentOS, y al que se le indica `-y` para que
conteste *Yes* a todas las preguntas sobre la instalación. 

Este Vagrantfile no necesita nada especial para ejecutarse: se le
llama directamente cuando se ejecuta `vagrant up` o explícitamente
cuando se llama con `vagrant provision`. Lo único que hará es instalar
este programa bajándose todas sus dependencias (y tardará un rato).

<div class='ejercicios' markdown='1'>

Crear un script para provisionar `nginx` o cualquier otro servidor
web que pueda ser útil para alguna otra práctica
​	
</div>

<div class='nota' markdown='1'>

El provisionamiento por *shell* admite
[muchas más opciones](http://docs.vagrantup.com//provisioning/shell.html):
se puede usar un fichero externo o incluso alojado en un sitio web
(por ejemplo, un Gist alojado en GitHub). Por ejemplo,
[este para provisionar nginx y node](https://gist.github.com/DamonOehlman/5754302)
(no leer hasta después de hacer el ejercicio anterior).

</div>

El problema con los guiones de *shell* (y no sé por qué diablos pongo
guiones si pongo *shell*, podía poner scripts de *shell* directamente y
todo el mundo me entendería, o guiones de la concha y nadie me
entendería) es que son específicos de una máquina. Por eso Vagrant
permite muchas otras formas de configuración, incluyendo casi todos
los sistemas de provisionamiento populares (Chef, Puppet, Ansible,
Salt) y otros sistemas con Docker, que también hemos visto. La ventaja
de estos sistemas de más alto nivel es que permiten trabajar
independientemente del sistema operativo. Cada uno de ellos tendrá sus
opciones específicas, pero veamos cómo se haría lo anterior usando el
provisionador
[chef-solo](http://docs.vagrantup.com/provisioning/chef_solo.html).

Para empezar, hay que provisionar la máquina virtual para que funcione
con chef-solo y hay que hacerlo desde shell o Ansible;
[este ejemplo](../../ejemplos/vagrant/provision/chef-with-shell/Vagrantfile)
que usa
[este fichero shell](../../ejemplos/vagrant/provision/chef-with-shell/chef-solo.sh)
puede provisionar, por ejemplo, una máquina CentOS. 

Una vez preinstalado chef (lo que también podíamos haber hecho con
[una máquina que ya lo tuviera instalado, de las que hay muchas en `vagrantbox.es`](http://www.vagrantbox.es/) 
y de hecho es la mejor opción porque chef-solo no se puede instalar en
la versión 6.5 de CentOS fácilmente por no tener una versión
actualizada de Ruby)
incluimos en el Vagrantfile. las órdenes para usarlo en
[este Vagrantfile](../../ejemplos/vagrant/provision/chef/Vagrantfile) 

```
	VAGRANTFILE_API_VERSION = "2"

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
		config.vm.box = "centos63"

	    config.vm.provision "chef_solo" do |chef|
			chef.add_recipe "emacs"
		end

	end
```

Este fichero usa un bloque de Ruby para pasarle variables y
simplemente declara que se va a usar la receta `emacs`, que
previamente tendremos que haber creado en un subdirectorio `cookbooks`
que descienda exactamente del mismo directorio y que contenga
simplemente `package 'emacs'` que tendrá que estar en un fichero 

```
	cookbooks/emacs/recipes/default.rb
```

Con todo esto se puede configurar emacs.

<div class='nota' markdown='1'>
Pero, la verdad, seguro que
es más fácil hacerlo en Ansible y/o en otro sistema operativo que no
sea CentOS porque yo, por lo pronto, no he logrado instalar chef-solo
en ninguna de las máquinas pre-configuradas de VagrantBoxes. 
</div>


<div class='ejercicios' markdown='1'>

Configurar tu máquina virtual usando vagrant con el provisionador
​	chef.
​	
</div>

Desde Vagrant se puede crear también una
[caja base](http://docs.vagrantup.com/boxes/base.html) con lo
mínimo necesario para poder funcionar, incluyendo el soporte para ssh
y provisionadores como Chef o Puppet. Se puede crear directamente en
VirtualBox y usar
[`vagrant package`](http://docs.vagrantup.com//cli/package.html)
para *empaquetarla* y usarla para su consumo posterior. 

A donde ir desde aquí
-------

Este es el último tema del curso, pero a partir de aquí se puede
seguir aprendiendo sobre DevOps en [el blog](http://devops.com/) o
[en IBM](https://www.ibm.com/cloud-computing/products/devops/). Libros como
[*DevOps for Developers*](https://www.amazon.es/dp/B009D6ZB0G?tag=atalaya-21&camp=3634&creative=24822&linkCode=as4&creativeASIN=B009D6ZB0G&adid=0PB61Y2QD9K49W3EP8MN&)
pueden ser también de ayuda.

Si no lo has hecho ya, es hora de comenzar
[la última práctica](../proyecto/5.IaaS.md). 
​	
