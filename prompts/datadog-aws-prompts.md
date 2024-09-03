**Prompt 1**
Antes de empezar quiero que me indiques cómo puedo configurar las credenciales de AWS en los secretos de mi repositorio de github y que me expliques brevemente qué hace el código de la carpeta @tf

**Prompt 2**
Eres un Senior DevSecOps Engineer y te han pedido que extiendas el código Terraform que ya existe en el proyecto @tf para configurar la integracion de Datadog con AWS usando Terraform.
Te iré indicando paso a paso, preguntame si tienes alguna duda y explicame en cada paso qué haras antes de continuar

**Prompt 3**
Paso 1: Configurar la Integración AWS-Datadog:
Utiliza Terraform para configurar la integración entre AWS y Datadog, siguiendo la guía 
@https://registry.terraform.io/providers/DataDog/datadog/latest/docs 


**Prompt 4**
paso 2: Configurar el Proveedor Datadog:
Añade el proveedor Datadog a tu configuración de Terraform.

**Prompt 5**
paso 3: Instalar el Agente Datadog:
Modifica el script de usuario de la instancia EC2 para instalar y configurar el agente Datadog.

**Prompt 6**
para evitar errores por recursos duplicados, puede ser una buena práctica definir variables en @variables.tf y poder cambiar algun sufijo o prefijo común facilmente?

**Prompt 7**
usando como base esta documentacion @https://docs.datadoghq.com/integrations/guide/aws-terraform-setup/ 
ayudame con la configuracion