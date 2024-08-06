# Material docente para la asignatura Infraestructura Virtual

[![Checks README](https://github.com/JJ/Test-Text/workflows/Checks%20README/badge.svg)](https://github.com/JJ/IV/actions?query=workflow%3A%22Comprueba+README%22)
|
[![Lint Markdown](https://github.com/JJ/IV/workflows/Lint%20Markdown/badge.svg)](https://github.com/JJ/IV/actions?query=workflow%3A%22Lint+Markdown%22)
|
[![markdown-link-check](https://github.com/JJ/IV/actions/workflows/linkchecker.yml/badge.svg)](https://github.com/JJ/IV/actions/workflows/linkchecker.yml)

[Infraestructura virtual](https://grados.ugr.es/sites/grados/default/public/guias-firmadas/2022-2023/296114N.pdf)
es una asignatura obligatoria de la rama "Tecnologías de la Información" del
primer cuatrimestre del cuarto curso del Grado de Ingeniería Informática y
optativa en otras ramas y en el Doble Grado de Informática y Matemáticas.

La asignatura en el curso 24-25 [se
imparte](https://etsiit.ugr.es/sites/centros/etsiit/public/inline-files/HorariosGII%2824-25%29.pdf)
en el aula 1.3 los viernes de 12:30 a 14:30 (grupo conjunto) y en la
-1.2 los jueves de 8:30 a 10:30 y de 12:30 a 14:30 (grupos
divididos). Se recuerda a los estudiantes que en todas las clases será
necesario llevar el portátil, ya que son siempre clases prácticas; por
lo mismo, se recomienda encarecidamente la asistencia a todas las
clases para realizar las prácticas in situ y que el profesor pueda
ayudarles.

> Las clases de cursos anteriores están grabadas, y puedes acceder a ellas [en
> esta lista de reproducción de
> YouTube](https://www.youtube.com/playlist?list=PLsYEfmwhBQdKIwbMDIwK64pt3Fs03BDz9).
> Conviene que te refieras a ellas *sólo para los conceptos*, no para los temas
> administrativos.

Se usará [GitHub](https://github.com) para el proyecto, la forma principal de
examinar la asignatura; cada una de las entregas representan haber alcanzado
objetivos de aprendizaje, y por lo tanto se denominan *objetivos*.

Los materiales de la asignatura están enlazados desde abajo y
disponibles con una licencia libre. Los fuentes de los mismos están en
[GitHub](https://github.com/JJ/IV).

La temporización de la asignatura y los objetivos de cada sesión figuran en la
[bitácora](https://github.com/JJ/IV-/blob/master/sesiones/README.md) de
clase. Enlazaremos también en ese fichero las grabaciones que se hagan de las
sesiones en vivo.

Estos son los [objetivos de la asignatura](documentos/objetivos.md), cuyas
sesiones de clase se irán reflejando en un repositorio de GitHub.

En resumen, nuestra intención es que el estudiante al final de la asignatura sea
capaz de hacer lo siguiente:

1. Definir el problema, entorno de trabajo y pruebas para desarrollo de una
   aplicación en particular y desplegarlo en un PaaS.
2. Usar ese entorno para configurar integración continua en una aplicación.
3. Crear un entorno virtual para desarrollar y alojar la aplicación y comprenda
   el soporte físico de las técnicas usadas para crear tal entorno virtual.
4. Entienda las técnicas de configuración automática de entornos virtuales y
   las sepa aplicar en los entornos anteriores.
5. Use lo aprendido para despliegue masivo de aplicaciones en la nube.

El *objetivo del proyecto* es que el estudiante se familiarice con la
metodología usada habitualmente en desarrollo de aplicaciones (en la nube y
cualquier otro tipo), por lo tanto, lo importante es que vaya, a través de la
puesta en práctica en un proyecto propio, interiorizando las mejores prácticas
en ingeniería de software.

## Prácticas - Actividades académicas dirigidas en grupos divididos

> Previo a la asignatura, es conveniente
> que [consultes este curso](https://jj.github.io/curso-tdd), con
> material suplementario a lo que se imparte en la asignatura. Los
> temas relevantes se enlazarán en cada hito.

La parte práctica de esta asignatura consiste en la realización de un proyecto a
lo largo de la misma, cubriendo diferentes objetivos de aprendizaje a la vez que
se realizan diferentes productos mínimamente viables de ese proyecto. Los
proyectos [consisten en crear la infraestructura virtual junto con una
aplicación desarrollada según el modelo
DevOps](documentos/proyecto/README.md). A grosso modo, los objetivos se
organizarán de la forma siguiente.

1. [Objetivo cero: Uso básico de
   herramientas, problema a resolver](documentos/proyecto/0.Repositorio.md).
2. [Historias de usuario y
   planificación](documentos/proyecto/1.Planificacion.md).
3. [Modelización del problema](documentos/proyecto/2.Modelo.md).
4. [Automatización de las tareas](documentos/proyecto/3.Automatizar.md).
5. [Tests unitarios para la clase/s diseñadas](documentos/proyecto/4.Tests.md).
6. Técnicas de virtualización: [Contenedores](documentos/proyecto/5.Docker.md)
   para pruebas.
7. [Integración continua](documentos/proyecto/6.CI.md).
8. [Servicios esenciales](documentos/proyecto/7.Servicios.md).
9. [REST](documentos/proyecto/8.REST.md).
10. [Implementación de REST](documentos/proyecto/9.Microservicio.md).

En estas prácticas se realizarán una serie de actividades para ayudar
a interiorizar los conceptos.

1. [Juego de rol: empatizar con el cliente para definir un problema](documentos/actividades/juego-rol-design-thinking.md).

Este último para crédito adicional:

1. [PaaS](documentos/proyecto/10.PaaS.md).

Estas prácticas se han hecho otros años:

1. [Provisionamiento de máquinas
   virtuales](documentos/proyecto/6.Provision.md).
2. [Virtualización de aplicaciones](documentos/proyecto/5.IaaS.md).
3. Sistemas [serverless](documentos/proyecto/5.Serverless.md).
4. [Creando microservicios](documentos/proyecto/6.Microservicio.md).
5. Desplegando a la nube:
   [Platform as a Service](documentos/proyecto/7.PaaS.md).

## Material adicional

> El temario está sólo como complemento, porque hay que partir de los objetivos
de aprendizaje semanales y los objetivos a entregar. Esto se ha usado como
material primario antes de 2021, pero ya no se considera material principal y
está, en muchos casos, sin actualizar.

1. [Introducción](documentos/temas/Intro_concepto_y_soporte_fisico.md):
   conceptos y soporte físico. Esta introducción es *cultura general*; aunque
   conviene conocerlo, no es imprescindible para llevar a cabo, en general, el
   proyecto de la asignatura. Se aconseja vivamente, sin embargo, leerlo y
   llevar a cabo los ejercicios de autoevaluación.
2. [Iniciación a DevOps: desarrollo basado en pruebas](documentos/temas/Desarrollo_basado_en_pruebas.md).
3. [Usando contenedores](documentos/temas/Contenedores.md).
4. [Integración continua](documentos/temas/Integracion_continua.md).
5. Breve introducción a [REST](documentos/temas/REST.md).
6. [Puesta en marcha de microservicios](documentos/temas/Microservicios.md).
7. [Platform as a Service](documentos/temas/PaaS.md).

Estos temas se pueden consultar como material adicional, han dejado de formar
parte del temario de la asignatura:

1. [Introducción e historia de los contenedores](documentos/temas/Intro_contenedores.md).
2. [Técnicas de virtualización](documentos/temas/Tecnicas_de_virtualizacion.md).
3. [Aislamiento de recursos](documentos/temas/Aislamiento_de_recursos.md).
4. [Almacenamiento virtual](documentos/temas/Almacenamiento.md).
5. [Gestión de configuraciones](documentos/temas/Gestion_de_configuraciones.md).
6. Computación [*serverless*](documentos/temas/Serverless.md).

## Seminarios

Material adicional interesante para la asignatura, que se impartirá
(en todo caso) fuera del horario lectivo.

1. [Mini-tutorial de Markdown, por Justo Javier Galera
   (JotaGalera)](documentos/seminarios/MarkDown_tutorial.md).
2. [Introducción ligera a git](preso/intro-git.html).
3. [Introducción ligera al lenguaje Ruby](documentos/seminarios/ruby.md).

## Tutorías virtuales

Las tutorías virtuales se realizarán preferiblemente a través del grupo
de Telegram; habrá que solicitar al profesor ser añadido. Finalmente, el
profesor está disponible por Telegram y Google Meet (en todos los
casos: `jjmerelo`); para cualquier videotutoría se pide consultar con cierta
antelación.

## Criterios de evaluación

Los criterios de evaluación figuran en la
[ficha de la asignatura](https://grados.ugr.es/sites/grados/default/public/guias-firmadas/2024-2025/296114N.pdf)
en la web del grado, y
[se especifican en el repositorio de la clase](https://github.com/JJ/IV-/blob/master/Metodolog%C3%ADa_y_criterios_de_evaluaci%C3%B3n.md).

## Convocatoria extraordinaria (AL FINAL DEL CUATRIMESTRE)

Si no se ha superado la asignatura en la convocatoria ordinaria, en la
extraordinaria habrá que entregar los diferentes objetivos del proyecto no
entregados, con fecha tope
el día que se haya anunciado oficialmente para el examen.
