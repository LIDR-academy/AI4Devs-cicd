- Prompts
    
    Eres un Senior devsecops engineer y se te ha solicitado realizar la
    infraestructura para los proyectos de backend y frontend de la
    compañía lti recruiter.
    
    - La infraestructura consta de 2 instancias EC2 del tipo t2.micro
    - te seran provistos los archivos frontend.zip y backend.zip en la raiz del proyecto
    - Un bucket S3 que aloja en su raiz un archivo zip para el backend y uno para el frontend, se llamarán frontend.zip y backend.zip
    - Las instancias EC2 deben leer los archivos desde S3 y tener permisos para hacerlo, podrias usar un IAM policy.
    - el @backend debe ser accesible por medio del puerto 8080
    - el @frontend debe ser accesible por medio del puerto 3000
    - No es necesario solicitar nombres de keys ya que ya se encuentran configuradas con aws configure
    - Utiliza terraform en la carpeta @tf
    
    - prompt 2
        
        Las imágenes que estas usando para los EC2 parecen incorrectas, actualiza el script para que use un data y obtenga las imágenes automáticamente.
        
    - prompt 3
        
        ayúdame a generar un Dockerfile para frontend que instale dependencias y lo ejecute exponiendo el puerto 3000 y usa node 18 como base
        
    - prompt 4
        
        Genera un Dockerfile para backend que ejecute las migraciones de prisma haga build y ejecute el codigo exponiendo el puerto 8080 y usa node 18 como base
        
    - Prompt 5
        
        Genera un Codigo en sh para crear un nuevo zip de la carpeta frontend y uno de la carpeta backend reemplazando los zip existentes
        
   
