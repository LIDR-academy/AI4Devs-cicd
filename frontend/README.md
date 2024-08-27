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

## Configuración de EC2 y GitHub Actions

Para ejecutar este proyecto en una instancia EC2 y asegurarte de que GitHub Actions funcione correctamente, sigue estos pasos:

### Configuración de EC2

1. **Crear una Instancia EC2**:
    - Inicia sesión en la consola de AWS y navega a EC2.
    - Lanza una nueva instancia utilizando una AMI de Amazon Linux 2 o Ubuntu.
    - Asegúrate de seleccionar un tipo de instancia adecuado (por ejemplo, `t2.micro` para pruebas).

2. **Configurar el Grupo de Seguridad**:
    - Asegúrate de que el grupo de seguridad asociado a tu instancia permita el tráfico en los siguientes puertos:
        - **22**: Para SSH (acceso remoto).
        - **80**: Para HTTP (si estás usando Nginx o un servidor web).
        - **8080**: Para el backend (puerto donde se ejecuta tu aplicación).
    - Puedes agregar reglas de entrada en el grupo de seguridad para permitir el acceso desde cualquier IP (0.0.0.0/0) para propósitos de desarrollo, pero considera restringirlo en producción.

3. **Instalar Dependencias en EC2**:
    - Conéctate a tu instancia EC2 a través de SSH:
      ```
      ssh -i your-key.pem ec2-user@your-ec2-public-ip
      ```
    - Instala Node.js y npm:
      ```
      curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
      sudo yum install -y nodejs
      ```
    - Instala PM2 para gestionar tu aplicación:
      ```
      sudo npm install -g pm2
      ```
    - Instala Nginx si lo necesitas:
      ```
      sudo yum install -y nginx
      ```

4. **Configurar Variables de Entorno**:
    - Crea un archivo `.env` en el directorio raíz del backend con las siguientes variables:
      ```
      DATABASE_URL=postgresql://user:password@localhost:5432/mydatabase
      ```
    - Asegúrate de reemplazar `user`, `password` y `mydatabase` con los valores correctos.

### Variables en GitHub Actions

Para que el flujo de trabajo de GitHub Actions funcione correctamente, debes configurar las siguientes variables en los secretos de tu repositorio:

1. **AWS_ACCESS_ID**: Tu ID de clave de acceso de AWS.
2. **AWS_ACCESS_KEY**: Tu clave de acceso secreta de AWS.
3. **EC2_INSTANCE**: La dirección IP pública o el nombre DNS de tu instancia EC2.