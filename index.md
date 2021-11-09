---
layout: index


---
# Material docente para la asignatura Infraestructura Virtual

[![Checks README](https://github.com/JJ/Test-Text/workflows/Checks%20README/badge.svg)](https://github.com/JJ/IV/actions?query=workflow%3A%22Comprueba+README%22)
|
[![Lint Markdown](https://github.com/JJ/IV/workflows/Lint%20Markdown/badge.svg)](https://github.com/JJ/IV/actions?query=workflow%3A%22Lint+Markdown%22)

[Infraestructura virtual](https://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/curso_actual/cuarto/tecnologiasdelainformacion/infraestructuravirtual)
es una asignatura obligatoria de la rama "Tecnologías de la Información" del
primer cuatrimestre del cuarto curso del Grado de Ingeniería Informática y
optativa en otras ramas y en el Doble Grado de Informática y Matemáticas.

La asignatura se imparte en el curso 21-22 en el aula 1.8 los jueves de 8:30 a
10:30 (grupo conjunto) y en la -1.2 los viernes de 8:30 a 10:30 y de 12:30 a
14:30 (grupos divididos). Se recuerda a los estudiantes que en todas las clases
será necesario llevar el portátil, ya que son en realidad clases prácticas.

> Las clases de años anteriores están grabadas, y puedes acceder a ellas [en
> esta lista de reproducción de
> YouTube](https://www.youtube.com/playlist?list=PLsYEfmwhBQdKIwbMDIwK64pt3Fs03BDz9).

Se usará [GitHub](https://github.com) para el proyecto, la forma principal de
examinar la asignatura; llamaremos *objetivos* a cada una de las entregas que hay
que hacer del mismo.

Estos son los [objetivos de la asignatura](documentos/objetivos), cuyas
sesiones de clase se irán reflejando en
[un repositorio de GitHub; este es el de 2021-22](https://github.com/JJ/IV-21-22).

En resumen, nuestra intención es que el estudiante al final de la asignatura sea
capaz de hacer lo siguiente:

1. Definir el entorno de trabajo y pruebas para desarrollo de una aplicación en
   particular y desplegarlo en un PaaS.
2. Usar ese entorno para configurar integración continua en una aplicación.
3. Crear un entorno virtual para desarrollar y alojar la aplicación y comprenda
   el soporte físico de las técnicas usadas para crear tal entorno virtual.
4. Entienda las técnicas de configuración automática de entornos virtuales y
   las sepa aplicar en los entornos anteriores.
5. Use lo aprendido para despliegue masivo de aplicaciones en la nube.

## Temario - Programa de la asignatura

> Previo a la asignatura, es conveniente
> que [consultes este curso](https://jj.github.io/curso-tdd), con
> material suplementario a lo que se imparte en la asignatura. Los
> temas relevantes se enlazarán en cada hito.

Los materiales de la asignatura están enlazados desde abajo y
disponibles con una licencia libre. Los fuentes de los mismos están en
[GitHub](https://github.com/JJ/IV).

La temporización de la asignatura y los objetivos de cada sesión figuran en la
[bitácora](https://github.com/JJ/IV-20-21/blob/master/sesiones/README.md) de
clase. Enlazaremos también en ese fichero las grabaciones que se hagan de las
sesiones en vivo.

1. [Introducción](documentos/temas/Intro_concepto_y_soporte_fisico):
   conceptos y soporte físico. Esta introducción es *cultura general*; aunque
   conviene conocerlo, no es imprescindible para llevar a cabo, en general, el
   proyecto de la asignatura. Se aconseja vivamente, sin embargo, leerlo y
   llevar a cabo los ejercicios de autoevaluación.
2. [Iniciación a DevOps: desarrollo basado en pruebas](documentos/temas/Desarrollo_basado_en_pruebas).
3. [Usando contenedores](documentos/temas/Contenedores).
4. [Integración continua](documentos/temas/Integracion_continua).
5. Breve introducción a [REST](documentos/temas/REST).
6. Computación [Serverless](documentos/temas/Serverless).
7. [Puesta en marcha de microservicios](documentos/temas/Microservicios).
8. [Platform as a Service](documentos/temas/PaaS).

Estos temas se pueden consultar como material adicional, pero no forman parte
este año del temario de la asignatura:

1. [Introducción e historia de los contenedores](documentos/temas/Intro_contenedores).
2. [Técnicas de virtualización](documentos/temas/Tecnicas_de_virtualizacion).
3. [Aislamiento de recursos](documentos/temas/Aislamiento_de_recursos).
4. [Almacenamiento virtual](documentos/temas/Almacenamiento).
5. [Gestión de configuraciones](documentos/temas/Gestion_de_configuraciones).

## Seminarios

Material adicional interesante para la asignatura, que se impartirá
(en todo caso) fuera del horario lectivo.

1. [Mini-tutorial de Markdown, por Justo Javier Galera
   (JotaGalera)](documentos/seminarios/MarkDown_tutorial).
2. [Introducción ligera a git](preso/intro-git.html).
3. [Introducción ligera al lenguaje Ruby](documentos/seminarios/ruby).

## Prácticas - Actividades académicas dirigidas en grupos divididos

La parte práctica de esta asignatura consiste en la realización de un proyecto a
lo largo de la misma, cubriendo diferentes objetivos de aprendizaje a la vez que
se realizan diferentes productos mínimamente viables de ese proyecto. Los
proyectos [consisten en crear la infraestructura virtual junto con una
aplicación desarrollada según el modelo
DevOps](documentos/proyecto/README.md). A grosso modo, los objetivos se
organizarán de la forma siguiente.

1. [Objetivo cero: Uso básico de
   herramientas](documentos/proyecto/0.Repositorio).
2. [Historias de usuario y
   planificación](documentos/proyecto/1.Infraestructura).
3. [Definición de una entidad](documentos/proyecto/2.Entidad).
4. [Automatización de las tareas](documentos/proyecto/3.Automatizar).
5. [Tests unitarios para la clase/s diseñadas](documentos/proyecto/4.Tests).
6. Técnicas de virtualización: [Contenedores](documentos/proyecto/5.Docker)
   para pruebas.
7. [Integración continua](documentos/proyecto/6.CI).
8. [Servicios esenciales](documentos/proyecto/7.Servicios).

Estas prácticas se han hecho otros años:

1. [Provisionamiento de máquinas
   virtuales](documentos/proyecto/6.Provision).
2. [Virtualización de aplicaciones](documentos/proyecto/5.IaaS).
3. Despliegues [serverless](documentos/proyecto/5.Serverless).
4. [Creando microservicios](documentos/proyecto/6.Microservicio).
5. Desplegando a la nube:
   [Platform as a Service](documentos/proyecto/7.PaaS).

## Tutorías virtuales

Las tutorías virtuales se realizarán preferiblemente a través del grupo
de Telegram; habrá que solicitar al profesor ser añadido. Finalmente, el
profesor está disponible por Telegram y Google Meet (en todos los
casos: `jjmerelo`); para cualquier videotutoría se pide consultar con cierta
antelación.

Se creará también una sala específica en Jitsi para las tutorías,
consultar con el profesor la dirección.

## Criterios de evaluación

Los criterios de evaluación figuran en la
[ficha de la asignatura](https://grados.ugr.es/informatica/pages/infoacademica/guias_docentes/curso_actual/cuarto/tecnologiasdelainformacion/gii_infraestructura_virtual_20172018_firmada)
en la web del grado, y
[se especifican en el repositorio de la clase](https://github.com/JJ/IV-21-22/blob/master/Metodolog%C3%ADa_y_criterios_de_evaluaci%C3%B3n).

## Convocatoria extraordinaria (AL FINAL DEL CUATRIMESTRE)

Si no se ha superado la asignatura en la convocatoria ordinaria, en la
extraordinaria habrá que entregar los diferentes objetivos del proyecto no
entregados (o los que se quieran entregar, si se quiere subir nota), como máximo
el día que se haya anunciado oficialmente para el examen.
