# Automatización de tareas en la nube

<!--@
prev: Provision
next: Orquestacion
-->

<div class="objetivos" markdown="1">

## Objetivos

1. Conocer las diferentes tecnologías y herramientas de
   virtualización tanto para procesamiento, comunicación y
   almacenamiento.

2. Diseñar, construir y analizar las prestaciones de un centro de
   proceso de datos virtual.

3. Documentar y mantener una plataforma virtual.

4. Realizar tareas de administración de infraestructuras virtuales.

</div>

## Trabajando en la nube

Lo primero es crear metadatos relativos a la instancia de la máquina
   virtual. Cosas como el *grupo de recursos*, que indica cómo va a
   escalar, el centro de datos en el que se va a alojar, y alguna cosa
   adicional, como el tipo de instancia que se va a usar.

Todas las plataformas suelen tener una utilidad de línea de órdenes, o
varias, que permite acceder al API de la misma una vez identificados
ahí. Generalmente son libres, así que también se pueden usar desde tu
propio programa. A continuación veremos como trabajar en alguna de
ellas.

<!-- incluir instrucciones para usar CLI de Python -->

El [CLI de Azure](https://github.com/Azure/azure-cli#installation)
está basado en Python y se puede instalar siguiendo las instrucciones
arriba. Es bastante similar al anterior, pero hay muchas tareas que se
realizan mucho más fácilmente usando valores por omisión relativamente
fáciles. Además, devuelve los resultados en JSON por lo que es
relativamente fácil trabajar con ellos de forma automática.

Comencemos por crear un grupo de recursos

```shell
az group create -l westeurope -n CCGroupEU
```

Esto crea un grupo de recursos en Europa Occidental.

## A dónde ir desde aquí

Si no lo has visto, en el [siguiente tema](Gestion_de_configuraciones.md) pondremos en
práctica todos los conceptos aprendidos en este tema y
[en el tema dedicado a almacenamiento](Almacenamiento.md) para crear configuraciones que sean
fácilmente gestionables y adaptables a un fin determinado. También se
puede ir a [el hito del proyecto](../3.IaaS.md) para aplicarlo al mismo.

Si lo que necesitas es un sistema ligero de virtualización, puedes
mirar cómo virtualizar con [contenedores](Contenedores.md).
