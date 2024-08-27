** Prompt 1**

Eres un Senior devsecops engineer y se te ha solicitado realizar la
infraestructura para los proyectos de backend y frontend de la
compañía lti recruiter.

- La insfraestructura consta de 2 instancias EC2 del tipo t2.micro
- te seran provistos los archivos zip en la raiz del proyecto
- Un bucket S3 que aloja en su raiz un archivo zip para el backend y uno para el frontend, se llamarán frontend.zip y backend.zip
- Las instancias EC2 deben leer los archivos desde S3 y tener permisos para hacerlo, podrias usar un IAM policy.
- detecta la version de node desde las carpetas correspondientes e instalalo en las instancias
- el @backend debe ser accesible por medio del puerto 8080
- el @frontend debe ser accesible por medio del puerto 3000
- Se requiere que todo el tiempo haya disponibilidad con las EC2, agrega un parametro que no destruya la actual instancia hasta que la nueva este lista
- No es necesario solicitar keys ya que ya las configure con aws configure
- Utiliza terraform en la carpeta @tf 

** Prompt 2**

Remueve la key de acceso de las instancias EC2 ya que la configure localmente con aws configure
y por favor cambia la ruta de los archivos zip a ../backend.zip y ../frontend.zip


** Prompt 3**


