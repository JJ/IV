# Material docente para Infraestructura Virtual

[![Build Status](https://travis-ci.org/JJ/IV.svg?branch=master)](https://travis-ci.org/JJ/IV)

[Infraestructura virtual](http://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/curso_actual/cuarto/tecnologiasdelainformacion/gii_infraestructura_virtual_20172018_firmada)
es una asignatura obligatoria de la rama Tecnologías de la Información
del primer cuatrimestre del cuarto del Grado de Ingeniería
Informática y optativa en otras ramas y el Doble Grado de Informática
y Matemáticas.

La asignatura se imparte en el curso 2017-2018 [los jueves de 11:30 a
13:30 en la 1.5 y tiene dos grupos de *prácticas* los martes y jueves de de 9:30 a 11:30 en la -1.2](http://etsiit.ugr.es/pages/calendario_academico/horarios1718/horariosgii1718/!/download).
Se recuerda a los alumnos que en todas las clases será necesario llevar el portátil, ya que son clases prácticas.

Se usará
[GitHub](http://github.com) para el proyecto cuyos hitos serán considerados "prácticas".

Estos son los [objetivos de la asignatura](documentos/objetivos.md), cuyas sesiones de clase se irán reflejando en [un repositorio de GitHub; este es el de 2017-2018](https://github.com/JJ/IV-17-18).

En resumen, mi intención es que el alumno al final de la asignatura sea capaz de hacer lo siguiente:

1. Definir el entorno de trabajo y pruebas para desarrollo de una aplicación en particular y desplegarlo en un PaaS.
2. Usar ese entorno para configurar integración continua en una aplicación.
3. Crear un entorno virtual para desarrollar y alojar la aplicación y comprenda el soporte físico de las técnicas usadas para crear tal entorno virtual.
4. Entienda las técnicas de configuración automática de entornos virtuales y las sepa aplicar en los entornos anteriores.
5. Use lo aprendido para despliegue masivo de aplicaciones en la nube.

Temario - Programa de la asignatura
------------------------------------------------------

Los materiales de la asignatura están enlazados desde aquí y
disponibles con una licencia libre. Los fuentes de los mismos están en
[GitHub](http://github.com/JJ/IV). La
[temporización de la asignatura y los objetivos de cada sesión figuran en la bitácora de clase](https://github.com/JJ/IV16-17/blob/master/sesiones/README.md).

1. [Introducción: conceptos y soporte físico](documentos/temas/Intro_concepto_y_soporte_fisico.md).
2. [Iniciación a DevOps: desarrollo basado en pruebas](documentos/temas/Desarrollo_basado_en_pruebas.md).
2. [Platform as a Service](documentos/temas/PaaS.md).
3. [Usando contenedores](documentos/temas/Contenedores.md).
5. [Uso de sistemas de virtualización](documentos/temas/Uso_de_sistemas.md).
6. [Gestión de configuraciones](documentos/temas/Gestion_de_configuraciones.md).

Estos temas se pueden consultar como material adicional, pero no forman parte este año del temario de la asignatura:

2. [Técnicas de virtualización](documentos/temas/Tecnicas_de_virtualizacion.md).
4. [Aislamiento de recursos](documentos/temas/Aislamiento_de_recursos.md).
4. [Almacenamiento virtual](documentos/temas/Almacenamiento.md).

Seminarios
---------------

Material adicional interesante para la asignatura, que se impartirá fuera del horario lectivo.

1. [Introducción ligera al lenguaje Ruby](documentos/seminarios/ruby.md).

Prácticas - Actividades académicas dirigidas
-------------

La parte práctica consiste en la realización de un proyecto a lo largo de
la asignatura, con diferentes hitos cuyo contenido corresponde a los objetivos de aprendizaje
cumplidos hasta ese momento. Los proyectos
[consisten en crear la infraestructura virtual de una aplicación desarrollada según el modelo DevOps](documentos/proyecto/README.md). A
grosso modo, los hitos se organizarán de la forma siguiente.

0. [Práctica cero: Uso básico de herramientas](documentos/proyecto/0.Repositorio.md)
1. [Organización de los grupos de práctica y creación del proyecto](documentos/proyecto/1.Infraestructura.md)
2. [Integración continua en el repositorio](documentos/proyecto/2.CI.md)
3. Desplegando a la nube: [Platform as a Service](documentos/proyecto/3.PaaS.md).
4. Técnicas de virtualización [Contenedores para pruebas](documentos/proyecto/4.Docker.md).
4. [Virtualización de aplicaciones](documentos/proyecto/5.IaaS.md).

Tutorías virtuales
----

Las tutorías virtuales se realizarán preferiblemente a través de
[la plataforma de trabajo colaborativo GitHub](https://github.com/JJ/IV-17-18/issues?state=open) y
a través del grupo de Telegram; habrá que solicitar al profesor ser
añadido. Finalmente, el profesor está disponible por Telegram, Skype y
Google Hangouts (en todos los casos: `jjmerelo`).

Criterios de evaluación
---

Los
[criterios de evaluación figuran en la ficha de la asignatura en la web del grado](http://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/espti/infraestructuravirtual),
y
[se especifican en el repositorio de la clase](https://github.com/JJ/IV-17-18/blob/master/Metodolog%C3%ADa_y_criterios_de_evaluaci%C3%B3n.md).

## Convocatoria extraordinaria (en julio)

Si no se ha superado la asignatura en la convocatoria ordinaria, la
extraordinaria consistirá en un examen escrito en septiembre que
puntuará sobre *8 puntos*, siendo el resto proporcional a la nota
obtenida en junio. El examen incluirá tanto preguntas de desarrollo
como ejercicios prácticos en los que se tendrá que esbozar un
programa, script o fichero de configuración o indicar cómo se
resolvería un problema con las técnicas aprendidas en la
asignatura. Se aconseja al alumno que haga los ejercicios de
autoevaluación para alcanzar los objetivos de aprendizaje que se
exigen tanto en junio como en septiembre. El método para preguntar
dudas será el mismo que en la convocatoria ordinaria: lista de correo
e issues de GitHub.
