# Prompts

1. [Prompt 1](#prompt-1)
2. [Prompt 2](#prompt-2)
3. [Prompt 3](#prompt-3)
4. [Prompt 4](#prompt-4)
5. [Prompt 5](#prompt-5)
6. [Prompt 6](#prompt-6)
7. [Prompt 7](#prompt-7)
8. [Otros errores](#otros-errores)

## Prompt 1: 

Take a look to this project and describe it purpose

---

The project is a full-stack application designed for managing talent tracking, specifically for handling candidates and interview processes. It includes a frontend built with React and a backend developed using Express and TypeScript, with Prisma as the ORM for database interactions.

### Key Features:
1. **Frontend**:
   - Built with React.
   - Provides user interfaces for recruiters to manage candidates and positions.
   - Includes components like `RecruiterDashboard`, `Positions`, and `CandidateDetails`.

2. **Backend**:
   - Developed with Express and TypeScript.
   - Manages API endpoints for handling candidates, positions, and interview flows.
   - Uses Prisma for database operations.
   - Includes a well-structured directory for application logic, domain models, infrastructure, presentation, and routes.

3. **Database**:
   - Utilizes PostgreSQL, managed via Docker.
   - Prisma schema defines models for `Candidate`, `Education`, `WorkExperience`, `Resume`, and `Application`.

4. **CI/CD and Infrastructure**:
   - Infrastructure setup using Terraform for AWS resources like EC2 instances and S3 buckets.
   - CI/CD pipeline defined using GitHub Actions and Jenkins for automated testing, building, and deployment.

5. **Documentation and Best Practices**:
   - Detailed README files for both frontend and backend.
   - A manifesto for best practices in software development, emphasizing principles like Domain-Driven Design (DDD) and SOLID principles.

### Purpose:
The primary purpose of this project is to facilitate the recruitment process by providing tools for managing candidate information, tracking interview stages, and maintaining a structured and scalable codebase. It aims to improve the efficiency of recruiters by automating and streamlining various aspects of the hiring process.

### Relevant Code References:
- Project structure and setup details:
  
```1:89:README.md
# LTI - Sistema de Seguimiento de Talento

Este proyecto es una aplicación full-stack con un frontend en React y un backend en Express usando Prisma como un ORM. El frontend se inicia con Create React App y el backend está escrito en TypeScript.

## Explicación de Directorios y Archivos

- `backend/`: Contiene el código del lado del servidor escrito en Node.js.
  - `src/`: Contiene el código fuente para el backend.
    - `index.ts`: El punto de entrada para el servidor backend.
    - `application/`: Contiene la lógica de aplicación.
    - `domain/`: Contiene la lógica de negocio.
    - `infrastructure/`: Contiene código que se comunica con la base de datos.
    - `presentation/`: Contiene código relacionado con la capa de presentación (como controladores).
    - `routes/`: Contiene las definiciones de rutas para la API.
    - `tests/`: Contiene archivos de prueba.
  - `prisma/`: Contiene el archivo de esquema de Prisma para ORM.
  - `tsconfig.json`: Archivo de configuración de TypeScript.
- `frontend/`: Contiene el código del lado del cliente escrito en React.
  - `src/`: Contiene el código fuente para el frontend.
  - `public/`: Contiene archivos estáticos como el archivo HTML e imágenes.
  - `build/`: Contiene la construcción lista para producción del frontend.
- `.env`: Contiene las variables de entorno.
- `docker-compose.yml`: Contiene la configuración de Docker Compose para gestionar los servicios de tu aplicación.
- `README.md`: Este archivo, contiene información sobre el proyecto e instrucciones sobre cómo ejecutarlo.

## Estructura del Proyecto

El proyecto está dividido en dos directorios principales: `frontend` y `backend`.

### Frontend

El frontend es una aplicación React y sus archivos principales están ubicados en el directorio `src`. El directorio `public` contiene activos estáticos y el directorio `build` contiene la construcción de producción de la aplicación.

### Backend

El backend es una aplicación Express escrita en TypeScript. El directorio `src` contiene el código fuente, dividido en varios subdirectorios:

- `application`: Contiene la lógica de aplicación.
- `domain`: Contiene los modelos de dominio.
- `infrastructure`: Contiene código relacionado con la infraestructura.
- `presentation`: Contiene código relacionado con la capa de presentación.
- `routes`: Contiene las rutas de la aplicación.
- `tests`: Contiene las pruebas de la aplicación.

El directorio `prisma` contiene el esquema de Prisma.

Tienes más información sobre buenas prácticas utilizadas en la [guía de buenas prácticas](./backend/ManifestoBuenasPracticas.md).

Las especificaciones de todos los endpoints de API los tienes en [api-spec.yaml](./backend/api-spec.yaml).

La descripción y diagrama del modelo de datos los tienes en [ModeloDatos.md](./backend/ModeloDatos.md).


## Primeros Pasos

Para comenzar con este proyecto, sigue estos pasos:

1. Clona el repositorio.
2. Instala las dependencias para el frontend y el backend:
```sh
cd frontend
npm install

cd ../backend
npm install
```
3. Construye el servidor backend:
```
cd backend
npm run build
````
4. Inicia el servidor backend:
```
cd backend
npm start
```
5. En una nueva ventana de terminal, construye el servidor frontend:
```
cd frontend
npm run build
```
6. Inicia el servidor frontend:
```
cd frontend
npm start
```

El servidor backend estará corriendo en http://localhost:3010 y el frontend estará disponible en http://localhost:3000.

```


- Frontend setup and available scripts:
  
```1:47:frontend/README.md
# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.\
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

```


- Backend setup and Prisma integration:
  
```90:127:README.md
## Docker y PostgreSQL

Este proyecto usa Docker para ejecutar una base de datos PostgreSQL. Así es cómo ponerlo en marcha:

Instala Docker en tu máquina si aún no lo has hecho. Puedes descargarlo desde aquí.
Navega al directorio raíz del proyecto en tu terminal.
Ejecuta el siguiente comando para iniciar el contenedor Docker:
```
docker-compose up -d
```
Esto iniciará una base de datos PostgreSQL en un contenedor Docker. La bandera -d corre el contenedor en modo separado, lo que significa que se ejecuta en segundo plano.

Para acceder a la base de datos PostgreSQL, puedes usar cualquier cliente PostgreSQL con los siguientes detalles de conexión:
 - Host: localhost
 - Port: 5432
 - User: postgres
 - Password: password
 - Database: mydatabase

Por favor, reemplaza User, Password y Database con el usuario, la contraseña y el nombre de la base de datos reales especificados en tu archivo .env.

Para detener el contenedor Docker, ejecuta el siguiente comando:
```
docker-compose down
```

Para generar la base de datos utilizando Prisma, sigue estos pasos:

1. Asegúrate de que el archivo `.env` en el directorio raíz del backend contenga la variable `DATABASE_URL` con la cadena de conexión correcta a tu base de datos PostgreSQL. Si no te funciona, prueba a reemplazar la URL completa directamente en `schema.prisma`, en la variable `url`.

2. Abre una terminal y navega al directorio del backend donde se encuentra el archivo `schema.prisma` y `seed.ts`.

3. Ejecuta los siguientes comandos para generar la estructura de prisma, las migraciones a tu base de datos y poblarla con datos de ejemplo:
```
npx prisma generate
npx prisma migrate dev
ts-node seed.ts
```
```


- Best practices and design principles:
  
```1:606:backend/ManifestoBuenasPracticas.md
# **Guía de Buenas Prácticas Proyecto LTI**

## **1. Domain-Driven Design (DDD)**

El **Diseño Guiado por el Dominio (DDD)** es una metodología que se enfoca en modelar el software según la lógica del negocio y el dominio. Al centrar el desarrollo en una comprensión profunda del dominio, DDD facilita la creación de sistemas complejos.

**Ventajas:**

- **Mejora la comunicación:** Promueve un lenguaje común entre desarrolladores y expertos en el dominio, mejorando la comunicación y reduciendo errores de interpretación.
- **Modelos de dominio claros:** Ayuda a construir modelos que reflejan fielmente las reglas y procesos del negocio.
- **Alta mantenibilidad:** Al dividir el sistema en subdominios, facilita el mantenimiento y la evolución del software.

**Componentes Clave:**

- **Entidades:** Objetos con identidad distintiva.
    
    *Antes*
    
    ```tsx
    // Anteriormente, los datos del candidato podrían haber sido manejados como un simple objeto JSON sin métodos.
    const candidate = {
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com'
    };
    ```
    
    *Después*
    
    ```tsx
    export class Candidate {
        id?: number;
        firstName: string;
        lastName: string;
        email: string;
        // Constructor y métodos que encapsulan la lógica de negocio.
        constructor(data: any) {
            this.id = data.id;
            this.firstName = data.firstName;
            this.lastName = data.lastName;
            this.email = data.email;
        }
    }
    ```
    
    <aside>
    💡 **Explicación**: `Candidate` es una entidad ya que tiene un identificador único (**id**) que lo distingue de otros candidatos, incluso si otras propiedades son idénticas.
    
    </aside>
    
- **Value Objects:** Objetos que describen aspectos del dominio sin identidad conceptual.
    
    *Antes*
    
    ```tsx
     // Manejo de información de educación como un simple objeto.
    const education = {
        institution: 'University',
        degree: 'Bachelor',
        startDate: '2010-01-01',
        endDate: '2014-01-01'
    };
    ```
    
    *Después*
    
    ```tsx
    export class Education {
        institution: string;
        title: string;
        startDate: Date;
        endDate?: Date;
        constructor(data: any) {
...
    💡 **Mejora Propuesta:** Revisar y posiblemente rediseñar las relaciones entre entidades para asegurar que reflejen con precisión las necesidades y reglas del dominio. Esto puede incluir la eliminación de relaciones innecesarias o la adición de nuevas relaciones que faciliten operaciones del negocio.
    
    </aside>
    
    **Integración de Eventos de Dominio**
    
    Los eventos de dominio son una parte importante de DDD y pueden ser utilizados para manejar efectos secundarios de las operaciones de dominio de manera desacoplada.
    
    <aside>
    💡 **Mejora Propuesta:** Implementar un sistema de eventos de dominio que permita a las entidades y agregados publicar eventos que otros componentes del sistema pueden manejar sin estar fuertemente acoplados a las entidades que los generan.
    
    </aside>
    

## **2. Principios SOLID y DRY**

**SOLID**

Los principios SOLID son cinco principios de diseño orientados a objetos que ayudan a crear sistemas más comprensibles, flexibles y mantenibles.

- **S - Single Responsibility Principle (SRP):** Cada clase debe tener una única responsabilidad o razón para cambiar.
    
    *Antes*
    
    ```tsx
...
    Separate data access logic into a repository layer to adhere more closely to SRP.
    
    </aside>
    
    *Improvement Example:*
    
    Create a `CandidateRepository` class for database interactions.
    
    ```
    class CandidateRepository {
        async save(candidateData: any) {
            // Database interaction logic here
        }
    }
    ```
    
- **O - Open/Closed Principle (OCP):** Las entidades de software deben estar abiertas para extensión, pero cerradas para modificación.
    
    *Antes*
    
    ```tsx
    // Modificación directa de la clase para añadir funcionalidad.
    class Candidate {
        saveToDatabase() {
            // código para guardar en la base de datos
        }
        // Para añadir nueva funcionalidad, modificamos la clase directamente.
        sendEmail() {
            // código para enviar un email
        }
    }
    ```
    
    *Después*
    
    ```tsx
    export class Candidate {
      saveToDatabase() {
          // código para guardar en la base de datos
      }
    }
    // Extendemos la funcionalidad sin modificar la clase existente.
    class CandidateWithEmail extends Candidate {
      sendEmail() {
          // código para enviar un email
      }
    }
    ```
    
    <aside>
    💡 **Explicación**: La funcionalidad de enviar un email se extiende en una subclase, manteniendo la clase original cerrada para modificaciones pero abierta para extensiones.
    
    **Observation:**
    
    The `addCandidate` function in `backend/src/application/services/candidateService.ts` directly instantiates `Candidate`, `Education`, `WorkExperience`, and `Resume` classes.
    
    **Recommendation:**
    
    Use factory methods to create instances, allowing for easier extension without modifying existing code.
    
    </aside>
    
    *Improvement Example:*
    
    Implement a factory method for creating a Candidate.
    
    ```tsx
    class CandidateFactory {
        static createCandidate(data: any): Candidate {
            return new Candidate(data);
        }
    }
    ```
    
- **L - Liskov Substitution Principle (LSP):** Los objetos de una clase derivada deben ser reemplazables por objetos de la clase base sin alterar el funcionamiento del programa.
    
    *Antes*
    
    ```tsx
    // Subclase que no puede reemplazar completamente a su clase base.
...
    ```tsx
    // Una interfaz grande que los clientes pequeños no usan completamente.
    interface CandidateOperations {
        save();
        validate();
        sendEmail();
        generateReport();
    }
    ```
    
    *Después*
    
    ```tsx
    interface SaveOperation {
        save();
    }
    
    interface EmailOperations {
        sendEmail();
    }
    
    interface ReportOperations {
        generateReport();
    }
    
    class Candidate implements SaveOperation, EmailOperations {
        save() {
            // implementación
        }
    
        sendEmail() {
            // implementación
        }
    }
    ```
    
    <aside>
    💡 **Explicación**: Las interfaces están segregadas en operaciones más pequeñas, permitiendo que las clases implementen solo las interfaces que necesitan.
    
    **Observation:**
    
    The project does not currently use TypeScript interfaces extensively to enforce contracts for classes.
    
    **Recommendation:**
    
    Define more granular interfaces for service classes to ensure they only implement the methods they need.
    
    </aside>
    
    *Improvement Example:*
    
    Define an interface for candidate-related operations.
    
    ```tsx
    interface ICandidateService {
        addCandidate(candidateData: any): Promise<Candidate>;
        findCandidateById(id: number): Promise<Candidate | null>;
    }
    ```
    
- **D - Dependency Inversion Principle (DIP):** Los módulos de alto nivel no deben depender de módulos de bajo nivel; ambos deben depender de abstracciones.
    
    *Antes*
    
    ```tsx
    // Dependencia directa de una implementación concreta.
    class Candidate {
        private database = new MySQLDatabase();
        save() {
            this.database.save(this);
        }
    }
    ```
    
    *Después*
    
    ```tsx
    interface Database {
        save(candidate: Candidate);
    }
    
    class Candidate {
        private database: Database;
        constructor(database: Database) {
            this.database = database;
        }
    
        save() {
            this.database.save(this);
        }
    }
    ```
    
    <aside>
...

[**Patrones de Diseño**](https://www.notion.so/Patrones-de-Dise-o-e006deb558f34f259a68b509f67566c7?pvs=21)

[Prompt: Manifesto Buenas Prácticas](https://www.notion.so/Prompt-Manifesto-Buenas-Pr-cticas-ff4938d307174a4bbdcfc5fd2dbbbe6d?pvs=21)

[Contrato Buenas Prácticas](https://www.notion.so/Contrato-Buenas-Pr-cticas-dd592dd96989406eb226bb240e495f27?pvs=21)
```


- Terraform configuration for infrastructure:
  
```1:29:tf/s3.tf
resource "aws_s3_bucket" "code_bucket" {
  bucket = "lti-project-code-bucket"
  acl    = "private"
}

resource "null_resource" "generate_zip" {
  provisioner "local-exec" {
    command = "sh ../generar-zip.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_s3_bucket_object" "backend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "backend.zip"
  source = "../backend.zip"
  depends_on = [null_resource.generate_zip]
}

resource "aws_s3_bucket_object" "frontend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "frontend.zip"
  source = "../frontend.zip"
  depends_on = [null_resource.generate_zip]
}

```


- CI/CD pipeline configuration:
  
```1:43:prompts/prompts_ci.md
** Prompt 1**

Eres un Senior DevSecOps Engineer y se te ha solicitado realizar un pipeline de CI/CD para la compañía. La estructura del pipeline debe seguir las siguientes especificaciones:

Utiliza un archivo YAML para definir el pipeline de GitHub Actions.

El pipeline debe ejecutarse cuando haya un pull_request en la rama main.

Define un job llamado build.

Agrega los siguientes pasos dentro del job build:

- Instalación de dependencias del backend y frontend dentro de sus carpetas utilizando npm install.
- Ejecución de tests del backend dentro de la carpeta backend utilizando npm test.
- Build del backend y frontend utilizando npm run build.
- Ejecución de migraciones con Prisma dentro de la carpeta backend utilizando npx prisma migrate deploy.
- Instalación de Docker en el entorno, asegurándose de que Docker esté listo para ser usado.
- Instalación de Docker Compose en el entorno.
- Levantamiento de servicios de la base de datos con Docker Compose utilizando docker-compose up -d.
- Ejecucion de frontend y backend.
- Ejecución de tests de Cypress.

Define un job llamado deploy que dependa del job build y que se ejecute solo si el evento es un pull_request.

Dentro del job deploy, incluye los siguientes pasos:

Configuración de credenciales de AWS utilizando las variables de entorno AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, y AWS_REGION.
- Subir el backend a S3 utilizando aws s3 cp para copiar el contenido de la carpeta backend al bucket S3.

- Desplegar el backend en una instancia EC2:
  - Utiliza SSH para conectarte a la instancia EC2.
  - Descarga el código del backend desde S3, instala dependencias, realiza el build y levanta la aplicación.

** Prompt 2**
Puedes hacer los siguientes cambios basado en buenas practicas?
  - Configura Nginx como proxy inverso para el backend en el puerto 8080.
  - Ejecuta en segundo plano el backend ya que esta quedandose corriendo indefinidamente.
  - Los tests estan fallando, debes esperar a que la base de datos, frontend y backend estén listos para que Cypress pueda ejecutar los test.

** Prompt 3**
Parece que la configuracion de Nginx no esta siendo tomada en cuenta, puedes modificar el codigo para que se ejecute en el puerto 80?


```

---

## Prompt 2: 
how can I run it?

---

To run this project, follow these steps:

### 1. **Clone the Repository**
```sh
git clone <repository_url>
cd <repository_name>
```

### 2. **Install Dependencies**
Install the dependencies for both the frontend and backend:
```sh
cd frontend
npm install

cd ../backend
npm install
```

### 3. **Build and Start the Backend**
```sh
cd backend
npm run build
npm start
```

### 4. **Build and Start the Frontend**
Open a new terminal window:
```sh
cd frontend
npm run build
npm start
```

### 5. **Set Up Docker and PostgreSQL**
Ensure Docker is installed on your machine. Then, start the PostgreSQL container:
```sh
docker-compose up -d
```

### 6. **Initialize and Apply Terraform Configuration**
Navigate to the Terraform directory and initialize and apply the configuration:
```sh
cd tf
terraform init
terraform plan
terraform apply -auto-approve
```

### 7. **Run the Jenkins Pipeline**
Ensure Jenkins is installed and running. Create a new pipeline job in Jenkins and use the following `Jenkinsfile` configuration:

```350:428:guion.html
    <pre><code class="language-groovy">pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'lti-project-code-bucket'
        PROJECT_NAME = 'lti-project'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install AWS CLI') {
            steps {
                sh 'curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"'
                sh 'sudo installer -pkg AWSCLIV2.pkg -target /'
            }
        }

        stage('Zip Projects') {
            steps {
                sh '''
                    zip -r backend.zip backend/
                    zip -r frontend.zip frontend/
                '''
            }
        }

        stage('Upload Code to S3') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                        aws s3 cp backend.zip s3://${S3_BUCKET}/backend.zip --region ${AWS_REGION}
                        aws s3 cp frontend.zip s3://${S3_BUCKET}/frontend.zip --region ${AWS_REGION}
                    '''
                }
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                    curl -LO https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
                    unzip terraform_1.5.7_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
</code></pre>
```


### 8. **Run the Application**
After the Terraform apply step, your EC2 instances should be set up and running the backend and frontend applications. You can access them via the public IPs provided by Terraform.

### 9. **Access the Application**
- **Backend**: `http://<backend_public_ip>:8080`
- **Frontend**: `http://<frontend_public_ip>:3000`

### 10. **Common Errors and Solutions**
Refer to the "Errores Comunes y Soluciones" section in the provided HTML guide for troubleshooting common issues.

### Code References
- **Terraform S3 Configuration**:
  
```1:29:tf/s3.tf
resource "aws_s3_bucket" "code_bucket" {
  bucket = "lti-project-code-bucket"
  acl    = "private"
}

resource "null_resource" "generate_zip" {
  provisioner "local-exec" {
    command = "sh ../generar-zip.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_s3_bucket_object" "backend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "backend.zip"
  source = "../backend.zip"
  depends_on = [null_resource.generate_zip]
}

resource "aws_s3_bucket_object" "frontend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "frontend.zip"
  source = "../frontend.zip"
  depends_on = [null_resource.generate_zip]
}

```


- **Backend Dockerfile**:
  
```1:26:backend/Dockerfile
# Usar una imagen base de Node.js
FROM node:18

# Establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos de package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto del código de la aplicación
COPY . .

# Construir la aplicación
RUN npm run build

RUN npm run prisma:generate

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["npm", "run", "start:prod"]

```


- **Backend User Data Script**:
  
```1:21:tf/scripts/backend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Iniciar el servicio de Docker
service docker start

# Descargar y descomprimir el archivo backend.zip desde S3
aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Construir la imagen Docker para el backend
cd /home/ec2-user/backend
docker build -t lti-backend .

# Ejecutar el contenedor Docker
docker run -d -p 8080:8080 lti-backend

# Timestamp to force update
echo "Timestamp: ${timestamp}"

```


- **Frontend User Data Script**:
  
```1:21:tf/scripts/frontend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Iniciar el servicio de Docker
service docker start

# Descargar y descomprimir el archivo frontend.zip desde S3
aws s3 cp s3://lti-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Construir la imagen Docker para el frontend
cd /home/ec2-user/frontend
docker build -t lti-frontend .

# Ejecutar el contenedor Docker
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"

```


- **Main Terraform Configuration**:
  
```1:21:errores_intencionales/main.tf
resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed50" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = file("scripts/backend_user_data.sh")
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "lti-project-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed50" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = file("scripts/frontend_user_data.sh")
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "lti-project-frontend"
  }
}
```


By following these steps, you should be able to set up and run the project successfully.

---

## Prompt 3: 

What's the purpose of the terraform integration in this project?

--


The purpose of the Terraform integration in this project is to automate the provisioning and management of the infrastructure required to run the backend and frontend applications. Specifically, Terraform is used to:

1. **Provision AWS Resources**:
   - Create S3 buckets to store the code for the backend and frontend applications.
   - Launch EC2 instances to host the backend and frontend applications.
   - Set up IAM roles and policies to grant necessary permissions to the EC2 instances.
   - Configure security groups to control access to the EC2 instances.

2. **Automate Deployment**:
   - Ensure that the EC2 instances can download the application code from S3, build the applications, and run them using Docker.
   - Use user data scripts to automate the setup and deployment process on the EC2 instances.

3. **Maintain Infrastructure as Code**:
   - Define the infrastructure in a declarative manner, making it easy to version control, review, and collaborate on the infrastructure setup.
   - Use modules to organize and reuse infrastructure code.

### Relevant Code References:
- **S3 Bucket Configuration**:

```1:28:tf/s3.tf
resource "aws_s3_bucket" "code_bucket" {
  bucket = "lti-project-code-bucket"
  acl    = "private"
}
}
resource "null_resource" "generate_zip" {
  provisioner "local-exec" {
    command = "sh ../generar-zip.sh"
  }
  }
  triggers = {
    always_run = "${timestamp()}"
  }
  }
}
resource "aws_s3_bucket_object" "backend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "backend.zip"
  source = "../backend.zip"
  depends_on = [null_resource.generate_zip]
}
}
resource "aws_s3_bucket_object" "frontend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "frontend.zip"
  source = "../frontend.zip"
  depends_on = [null_resource.generate_zip]
}
```


- **EC2 Instance Configuration**:

```1:21:tf/ec2.tf
resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("scripts/backend_user_data.sh", { timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "lti-project-backend"
  }
  }
}
resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("scripts/frontend_user_data.sh", { timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "lti-project-frontend"
  }
  }
```


- **Backend User Data Script**:

```1:21:tf/scripts/backend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker
yum install -y docker
# Iniciar el servicio de Docker
service docker start
service docker start
# Descargar y descomprimir el archivo backend.zip desde S3
aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/
unzip /home/ec2-user/backend.zip -d /home/ec2-user/
# Construir la imagen Docker para el backend
cd /home/ec2-user/backend
docker build -t lti-backend .
docker build -t lti-backend .
# Ejecutar el contenedor Docker
docker run -d -p 8080:8080 lti-backend
docker run -d -p 8080:8080 lti-backend
# Timestamp to force update
echo "Timestamp: ${timestamp}"
echo "Timestamp: ${timestamp}"
```


- **Main Terraform Configuration**:

```33:61:guion.html
    <h3>1.1. Crear el archivo <code>main.tf</code></h3>
    <pre><code class="language-hcl">provider "aws" {
  region = var.aws_region
}
}
resource "aws_s3_bucket" "code_bucket" {
  bucket = "${var.project_name}-code-bucket"
  bucket = "${var.project_name}-code-bucket"
}
module "iam" {
  source = "./iam"
  project_name = var.project_name
  code_bucket  = aws_s3_bucket.code_bucket.bucket
}
}
module "backend" {
  source              = "./backend"
  project_name        = var.project_name
  code_bucket         = aws_s3_bucket.code_bucket.bucket
  iam_instance_profile = module.iam.ec2_instance_profile
}
}
module "frontend" {
  source              = "./frontend"
  project_name        = var.project_name
  code_bucket         = aws_s3_bucket.code_bucket.bucket
  iam_instance_profile = module.iam.ec2_instance_profile
}
</code></pre>
```


By using Terraform, the project ensures that the infrastructure is consistent, repeatable, and can be easily modified or scaled as needed.

---

## Prompt 4: 

I need you to extend existing Terraform code to:

- Configure Datadog integration with AWS using Terraform.
- Install the Datadog agent on the EC2 instance.
- Create a dashboard in Datadog to visualize key AWS metrics.

I already have AWS and Datadog configured in local.
Before start, do you have any question?

---

The best practice for storing sensitive information like API keys is to use environment variables or a secrets management service. Here are a few options:

### 1. **Environment Variables**
Store the API key in an environment variable and reference it in your Terraform configuration and user data scripts.

#### Example: Using Environment Variables
- **Set the environment variable**:
  ```sh
  export DATADOG_API_KEY="your_datadog_api_key"
  ```

- **Reference it in Terraform**:
  ```hcl
  variable "datadog_api_key" {
    description = "Datadog API key"
    type        = string
    default     = ""
  }

  provider "datadog" {
    api_key = var.datadog_api_key
    app_key = var.datadog_app_key
  }
  ```

- **Pass it to the user data script**:
  ```hcl
  resource "aws_instance" "backend" {
    ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
    instance_type          = "t2.micro"
    iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
    user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
    vpc_security_group_ids = [aws_security_group.backend_sg.id]
    tags = {
      Name = "lti-project-backend"
    }
  }
  ```

- **Update the user data script**:
  ```shell:tf/scripts/backend_user_data.sh
  #!/bin/bash
  yum update -y
  yum install -y docker

  # Install Datadog Agent
  DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

  # Start Docker service
  service docker start

  # Download and unzip backend code
  aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
  unzip /home/ec2-user/backend.zip -d /home/ec2-user/

  # Build and run Docker container
  cd /home/ec2-user/backend
  docker build -t lti-backend .
  docker run -d -p 8080:8080 lti-backend

  # Timestamp to force update
  echo "Timestamp: ${timestamp}"
  ```

### 2. **AWS Secrets Manager**
Store the API key in AWS Secrets Manager and retrieve it in your Terraform configuration and user data scripts.

#### Example: Using AWS Secrets Manager
- **Store the secret in AWS Secrets Manager**:
  ```sh
  aws secretsmanager create-secret --name datadog_api_key --secret-string "your_datadog_api_key"
  ```

- **Retrieve the secret in Terraform**:
  ```hcl
  data "aws_secretsmanager_secret" "datadog_api_key" {
    name = "datadog_api_key"
  }

  data "aws_secretsmanager_secret_version" "datadog_api_key" {
    secret_id = data.aws_secretsmanager_secret.datadog_api_key.id
  }

  variable "datadog_api_key" {
    description = "Datadog API key"
    type        = string
    default     = data.aws_secretsmanager_secret_version.datadog_api_key.secret_string
  }

  provider "datadog" {
    api_key = var.datadog_api_key
    app_key = var.datadog_app_key
  }
  ```

- **Pass it to the user data script**:
  ```hcl
  resource "aws_instance" "backend" {
    ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
    instance_type          = "t2.micro"
    iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
    user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
    vpc_security_group_ids = [aws_security_group.backend_sg.id]
    tags = {
      Name = "lti-project-backend"
    }
  }
  ```

- **Update the user data script**:
  ```shell:tf/scripts/backend_user_data.sh
  #!/bin/bash
  yum update -y
  yum install -y docker

  # Install Datadog Agent
  DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

  # Start Docker service
  service docker start

  # Download and unzip backend code
  aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
  unzip /home/ec2-user/backend.zip -d /home/ec2-user/

  # Build and run Docker container
  cd /home/ec2-user/backend
  docker build -t lti-backend .
  docker run -d -p 8080:8080 lti-backend

  # Timestamp to force update
  echo "Timestamp: ${timestamp}"
  ```

### 3. **Terraform Cloud/Enterprise**
If you are using Terraform Cloud or Enterprise, you can store sensitive variables securely in the workspace.

#### Example: Using Terraform Cloud/Enterprise
- **Set the sensitive variable in Terraform Cloud/Enterprise**:
  - Go to your workspace in Terraform Cloud/Enterprise.
  - Navigate to "Variables".
  - Add a new variable `DATADOG_API_KEY` and mark it as sensitive.

- **Reference it in Terraform**:
  ```hcl
  variable "datadog_api_key" {
    description = "Datadog API key"
    type        = string
    default     = ""
  }

  provider "datadog" {
    api_key = var.datadog_api_key
    app_key = var.datadog_app_key
  }
  ```

- **Pass it to the user data script**:
  ```hcl
  resource "aws_instance" "backend" {
    ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
    instance_type          = "t2.micro"
    iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
    user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
    vpc_security_group_ids = [aws_security_group.backend_sg.id]
    tags = {
      Name = "lti-project-backend"
    }
  }
  ```

- **Update the user data script**:
  ```shell:tf/scripts/backend_user_data.sh
  #!/bin/bash
  yum update -y
  yum install -y docker

  # Install Datadog Agent
  DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

  # Start Docker service
  service docker start

  # Download and unzip backend code
  aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
  unzip /home/ec2-user/backend.zip -d /home/ec2-user/

  # Build and run Docker container
  cd /home/ec2-user/backend
  docker build -t lti-backend .
  docker run -d -p 8080:8080 lti-backend

  # Timestamp to force update
  echo "Timestamp: ${timestamp}"
  ```

By using one of these methods, you can securely manage your Datadog API key without hardcoding it in your scripts or Terraform configuration.

---

## Prompt 5: 

I've configured my datadog_api_key and datadog_app_key on terraform, change the integration to get this keys: DATADOG_API_KEY, DATADOG_APP_KEY

---
 
Great! Let's update the Terraform configuration and user data scripts to use the `datadog_api_key` and `datadog_app_key` variables.

### 1. **Update Terraform Configuration**

#### `datadog_integration.tf`
Ensure the Datadog provider and integration are configured to use the variables.

```hcl
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_integration_aws" "aws_integration" {
  account_id   = var.aws_account_id
  role_name    = "datadog-integration-role"
  filter_tags  = ["env:production"]
  host_tags    = ["env:production"]
  account_specific_namespace_rules = {
    auto_scaling = false
  }
}

resource "aws_iam_role" "datadog_integration_role" {
  name = "datadog-integration-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "datadog.amazonaws.com"
        },
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_policy" "datadog_integration_policy" {
  name        = "datadog-integration-policy"
  description = "Policy for Datadog AWS integration"
  policy      = file("datadog_policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_integration_policy_attachment" {
  role       = aws_iam_role.datadog_integration_role.name
  policy_arn = aws_iam_policy.datadog_integration_policy.arn
}
```

### 2. **Update User Data Scripts**

Update the user data scripts to use the `datadog_api_key` variable.

#### `backend_user_data.sh`
```shell:tf/scripts/backend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip backend code
aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/backend
docker build -t lti-backend .
docker run -d -p 8080:8080 lti-backend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

#### `frontend_user_data.sh`
```shell:tf/scripts/frontend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip frontend code
aws s3 cp s3://lti-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/frontend
docker build -t lti-frontend .
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

### 3. **Update EC2 Instance Configuration**

Ensure the EC2 instances pass the `datadog_api_key` variable to the user data scripts.

#### `ec2.tf`
```hcl
resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "lti-project-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = templatefile("scripts/frontend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "lti-project-frontend"
  }
}
```

### 4. **Apply the Changes**

Run the following commands to apply the changes:

```sh
terraform init
terraform plan
terraform apply -auto-approve
```

This will ensure that the Datadog API key is securely passed to the EC2 instances and used to install the Datadog agent.

---

## Prompt 6: 
great, is everything ready to accomplish our task?

- Configure Datadog integration with AWS using Terraform.
- Install the Datadog agent on the EC2 instance.
- Create a dashboard in Datadog to visualize key AWS metrics.

---

Yes, based on the provided information and the updates we've made, everything should be ready to accomplish the tasks. Here's a summary of what we've done and the final steps to ensure everything is set up correctly:

### Summary of Steps

1. **Configure Datadog Integration with AWS using Terraform**:
   - Created `datadog_integration.tf` to set up the Datadog integration with AWS.
   - Created necessary IAM roles and policies for Datadog to access AWS metrics.

2. **Install the Datadog Agent on the EC2 Instance**:
   - Updated `backend_user_data.sh` and `frontend_user_data.sh` to install the Datadog agent using the `datadog_api_key` variable.

3. **Create a Dashboard in Datadog to Visualize Key AWS Metrics**:
   - Created `datadog_dashboard.tf` to define a Datadog dashboard with widgets to monitor key AWS metrics.

### Final Steps

1. **Ensure All Terraform Files are in Place**:
   - `variables.tf`
   - `datadog_integration.tf`
   - `datadog_dashboard.tf`
   - `ec2.tf`
   - `datadog_policy.json`
   - `scripts/backend_user_data.sh`
   - `scripts/frontend_user_data.sh`

2. **Run Terraform Commands**:
   - Initialize Terraform:
     ```sh
     terraform init
     ```
   - Plan the changes:
     ```sh
     terraform plan
     ```
   - Apply the changes:
     ```sh
     terraform apply -auto-approve
     ```

### Example Directory Structure
Ensure your directory structure looks something like this:

```
.
├── variables.tf
├── datadog_integration.tf
├── datadog_dashboard.tf
├── ec2.tf
├── datadog_policy.json
├── scripts
│   ├── backend_user_data.sh
│   ├── frontend_user_data.sh
```

### Example Terraform Files

#### `variables.tf`
```hcl
variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog application key"
  type        = string
  sensitive   = true
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "code_bucket" {
  description = "The S3 bucket to store code"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for EC2 instances"
  type        = string
}
```

#### `datadog_integration.tf`
```hcl
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_integration_aws" "aws_integration" {
  account_id   = var.aws_account_id
  role_name    = "datadog-integration-role"
  filter_tags  = ["env:production"]
  host_tags    = ["env:production"]
  account_specific_namespace_rules = {
    auto_scaling = false
  }
}

resource "aws_iam_role" "datadog_integration_role" {
  name = "datadog-integration-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "datadog.amazonaws.com"
        },
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_policy" "datadog_integration_policy" {
  name        = "datadog-integration-policy"
  description = "Policy for Datadog AWS integration"
  policy      = file("datadog_policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_integration_policy_attachment" {
  role       = aws_iam_role.datadog_integration_role.name
  policy_arn = aws_iam_policy.datadog_integration_policy.arn
}
```

#### `datadog_dashboard.tf`
```hcl
resource "datadog_dashboard" "aws_dashboard" {
  title       = "AWS Metrics Dashboard"
  description = "Dashboard to monitor key AWS metrics"
  layout_type = "ordered"
  is_read_only = false

  widget {
    title       = "EC2 CPU Utilization"
    definition {
      type = "timeseries"
      requests {
        q = "avg:aws.ec2.cpuutilization{*}"
        display_type = "line"
        style {
          palette = "dog_classic"
          line_type = "solid"
          line_width = "normal"
        }
      }
      yaxis {
        scale = "linear"
        include_zero = true
        label = "CPU Utilization"
        min = "auto"
        max = "auto"
      }
    }
  }

  widget {
    title       = "S3 Bucket Size"
    definition {
      type = "timeseries"
      requests {
        q = "sum:aws.s3.bucket_size_bytes{*}"
        display_type = "line"
        style {
          palette = "dog_classic"
          line_type = "solid"
          line_width = "normal"
        }
      }
      yaxis {
        scale = "linear"
        include_zero = true
        label = "Bucket Size (Bytes)"
        min = "auto"
        max = "auto"
      }
    }
  }
}
```

#### `ec2.tf`
```hcl
resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = var.iam_instance_profile
  user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "${var.project_name}-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = var.iam_instance_profile
  user_data              = templatefile("scripts/frontend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "${var.project_name}-frontend"
  }
}
```

#### `datadog_policy.json`
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "logs:FilterLogEvents",
        "tag:GetResources",
        "tag:GetTagKeys",
        "tag:GetTagValues"
      ],
      "Resource": "*"
    }
  ]
}
```

#### `scripts/backend_user_data.sh`
```shell:tf/scripts/backend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip backend code
aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/backend
docker build -t lti-backend .
docker run -d -p 8080:8080 lti-backend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

#### `scripts/frontend_user_data.sh`
```shell:tf/scripts/frontend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip frontend code
aws s3 cp s3://lti-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/frontend
docker build -t lti-frontend .
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

By following these steps and ensuring all files are correctly configured, you should be able to accomplish the tasks of configuring Datadog integration with AWS, installing the Datadog agent on the EC2 instances, and creating a Datadog dashboard to visualize key AWS metrics.

---

## Prompt 7: 

I've get this error on "terraform init" command, what's the problem?

The error indicates that Terraform is trying to find the `datadog` provider under the `hashicorp` namespace, but it should be under the `datadog` namespace. You need to specify the correct source address for the `datadog` provider.

### Solution

Update the provider block in your Terraform configuration to specify the correct source for the `datadog` provider.

#### Example: `providers.tf`
```hcl
terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.0"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

provider "aws" {
  region = var.aws_region
}
```

### Steps to Fix

1. **Create or Update `providers.tf`**:
   Ensure you have a `providers.tf` file (or update your existing provider block) with the correct source for the `datadog` provider.

2. **Run Terraform Commands**:
   - Initialize Terraform:
     ```sh
     terraform init
     ```
   - Plan the changes:
     ```sh
     terraform plan
     ```
   - Apply the changes:
     ```sh
     terraform apply -auto-approve
     ```

### Full Example

#### `providers.tf`
```hcl
terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.0"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

provider "aws" {
  region = var.aws_region
}
```

#### `variables.tf`
```hcl
variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog application key"
  type        = string
  sensitive   = true
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "code_bucket" {
  description = "The S3 bucket to store code"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for EC2 instances"
  type        = string
}
```

#### `datadog_integration.tf`
```hcl
resource "datadog_integration_aws" "aws_integration" {
  account_id   = var.aws_account_id
  role_name    = "datadog-integration-role"
  filter_tags  = ["env:production"]
  host_tags    = ["env:production"]
  account_specific_namespace_rules = {
    auto_scaling = false
  }
}

resource "aws_iam_role" "datadog_integration_role" {
  name = "datadog-integration-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "datadog.amazonaws.com"
        },
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_policy" "datadog_integration_policy" {
  name        = "datadog-integration-policy"
  description = "Policy for Datadog AWS integration"
  policy      = file("datadog_policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_integration_policy_attachment" {
  role       = aws_iam_role.datadog_integration_role.name
  policy_arn = aws_iam_policy.datadog_integration_policy.arn
}
```

#### `datadog_dashboard.tf`
```hcl
resource "datadog_dashboard" "aws_dashboard" {
  title       = "AWS Metrics Dashboard"
  description = "Dashboard to monitor key AWS metrics"
  layout_type = "ordered"
  is_read_only = false

  widget {
    title       = "EC2 CPU Utilization"
    definition {
      type = "timeseries"
      requests {
        q = "avg:aws.ec2.cpuutilization{*}"
        display_type = "line"
        style {
          palette = "dog_classic"
          line_type = "solid"
          line_width = "normal"
        }
      }
      yaxis {
        scale = "linear"
        include_zero = true
        label = "CPU Utilization"
        min = "auto"
        max = "auto"
      }
    }
  }

  widget {
    title       = "S3 Bucket Size"
    definition {
      type = "timeseries"
      requests {
        q = "sum:aws.s3.bucket_size_bytes{*}"
        display_type = "line"
        style {
          palette = "dog_classic"
          line_type = "solid"
          line_width = "normal"
        }
      }
      yaxis {
        scale = "linear"
        include_zero = true
        label = "Bucket Size (Bytes)"
        min = "auto"
        max = "auto"
      }
    }
  }
}
```

#### `ec2.tf`
```hcl
resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = var.iam_instance_profile
  user_data              = templatefile("scripts/backend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "${var.project_name}-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = var.iam_instance_profile
  user_data              = templatefile("scripts/frontend_user_data.sh", { datadog_api_key = var.datadog_api_key, timestamp = timestamp() })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "${var.project_name}-frontend"
  }
}
```

#### `datadog_policy.json`
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "logs:FilterLogEvents",
        "tag:GetResources",
        "tag:GetTagKeys",
        "tag:GetTagValues"
      ],
      "Resource": "*"
    }
  ]
}
```

#### `scripts/backend_user_data.sh`
```shell:tf/scripts/backend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip backend code
aws s3 cp s3://lti-project-code-bucket/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/backend
docker build -t lti-backend .
docker run -d -p 8080:8080 lti-backend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

#### `scripts/frontend_user_data.sh`
```shell:tf/scripts/frontend_user_data.sh
#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip frontend code
aws s3 cp s3://lti-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/frontend
docker build -t lti-frontend .
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
```

By following these steps and ensuring the correct provider source is specified, you should be able to successfully initialize and apply your Terraform configuration.

---

## Otros errores

A continuación tuve varios errores con los tipados y definición del dashboard así que cambié a Claude (que no me sirvió de mucho) y abrí un nuevo chat con GPT en web, que sí me solucionó el problema: https://chatgpt.com/share/3024ec47-4284-47f1-91e6-6d07e927de65

En este mismo chat estuve trabajando otros erroes, la mayoria de ellos asociados a permisos de IAM y Datadog, pero **llegó un punto en el que no pude avanzar más por desconocimiento y falta de tiempo.**