#Practicas de la asignatura Infraestuctura Virtual

Lo primero y más importante que hay que tener en cuenta en los
proyectos que se van a llevar a cabo a lo largo de la asignatura es
que son de la asignatura, es decir, que tienen que aplicar los
conocimientos adquiridos en la asignatura, básicamente
infraestructuras virtuales y uso de Infraestructura/Plataformas/Software as a service. El
objetivo del proyecto es crear un producto mínimamente viable que 
sea de uno de los tipos descritos a continuación.

En años anteriores se hicieron las siguientes
[propuestas](propuestas.md), pero este año el tema del proyecto será
totalmente libre. Los *proyectos son individuales* y cada persona será
evaluada según el avance en su propio proyecto. Eso no quiere decir
que un proyecto corresponda a una aplicación: una sola aplicación se
puede dividir en varios proyectos individuales, pero cada uno de esos
proyectos tiene que tocar un porcentaje considerable de objetivos de
la asignatura. Es decir, no se puede dividir un proyecto en test,
infraestructura y despliegue y que cada parte la haga una persona,
pero sí puede haber un proyeco que consista en test y infraestructura
y otro que consista en otra parte de la infraestructura y despliegue.

Los proyectos podrán usar el lenguaje y herramientas que se desee,
siempre que sean libres o se usen de forma legal. Se valorará
especialmente la originalidad de la herramienta usada (lo que viene a
decir que si no usáis Django y Bootstrap igual que en DAI la
puntuación podrá ser mayor). En todo caso, *la aplicación en sí* no
forma parte del proyecto en general (salvo que se trate de una
aplicación en una plataforma de software como servicio). Sólo la parte
de *infraestructura virtual* formará parte de la aplicación.

En ese sentido, habrá dos tipos de proyectos

## Proyectos en la nube

Se tratará de proyectos en los que se usarán las características
únicas de un IaaS/PaaS/SaaS para crear una aplicación, es decir, usar las
capacidades de almacenamiento de datos, APIs, escalado automático y demás. Serán proyectos
que usarán plataformas como Google AppSpot, Azure o similares,
CouchBase, Heroku u Openshift, o,
en general, plataformas que ofrezcan un conjunto rico de servicios
configurable o no. Estos proyectos serán más estrictamente de
desarrollo.

## Proyectos DevOps/IaaS

En estos proyectos se desarrolla principalmente la infraestructura
necesaria para desarrollar, probar y desplegar una aplicación que no
necesariamente tiene que ser parte del mismo. Tendrá, por tanto, tres
partes 

* Configuración y gestión de la infraestructura de desarrollo:
  entornos virtuales de programación y librerías y otros entornos necesarios para
  trabajar.
* Configuración de los tests necesarios para llevar a cabo integración
  y publicación continua. En caso de que no estén desarrollados, habrá
  que llevar a cabo ese desarrollo.
* Configuración de la infraestructura en nube en la que se vaya a
  desplegar la aplicación, incluyendo monitorización de la misma.
* Configuración de las herramientas de despliegue necesarias para
  automatizar el despliegue de la aplicación usando una sola orden en
  los ordenadores o sistemas, especialmente nube, en los que se use.

El proyecto consistirá en la infraestructura necesaria para que:
* Un desarrollador pueda instalar la infraestrucura necesaria para
trabajar en el proyecto con una o pocas órdenes.
* Un *testeador* pueda probar la corrección del trabajo realizado
hasta el momento con una orden.
* Un *desplegador* pueda desplegar la aplicación a un servidor de
prueba y de producción con una sola orden.

## Hitos del proyecto

Los hitos del proyecto corresponderán a las prácticas de la asignatura
y se listarán a continuación. Tendrán un plazo determinado, aunque se
abrirán plazos extraordinarios con nota máxima decreciente en un punto
cada dos semanas. 

## Concluyendo

Cualquier proyecto que se presente, de los ofertados un año o de los
que alguna persona proponga, podrán seguir la temática que deseen,
pero la parte evaluable *en esta asignatura* será la que se haga
dentro de los dos tipos anteriores.
