## validaciones Implementadas:
### 1. Validación de Nombre Completo
- Campo obligatorio : No puede estar vacío
- Longitud mínima : Al menos 2 caracteres
- Caracteres permitidos : Solo letras, espacios y caracteres especiales del español (áéíóúñ)
- Validación en tiempo real : Se valida mientras el usuario escribe
### 2. Validación de Email
- Campo obligatorio : No puede estar vacío
- Formato válido : Utiliza expresión regular para validar formato de email estándar
- Teclado optimizado : Se muestra teclado de email en dispositivos móviles
- Validación en tiempo real : Se valida mientras el usuario escribe
### 3. Validación de Términos y Condiciones
- Aceptación obligatoria : El usuario debe marcar la casilla para continuar
- Mensaje de error visual : Se muestra debajo del checkbox cuando no está marcado
### 4. Validación General del Formulario
- Función centralizada : _validarFormulario() que verifica todos los campos
- Prevención de envío : El botón "Mostrar Datos" solo funciona si todas las validaciones pasan
- Notificación de errores : SnackBar rojo que informa al usuario sobre errores pendientes
## Características Técnicas:
- Validación en tiempo real : Los errores se muestran inmediatamente mientras el usuario escribe
- Mensajes de error contextuales : Cada campo muestra su error específico
- Limpieza de errores : Al limpiar el formulario, también se eliminan todos los mensajes de error
- Expresiones regulares : Utilizadas para validar formato de nombre y email
- Estado reactivo : Utiliza setState() para actualizar la UI inmediatamente
## Flujo de Validación:
1. Validación en tiempo real : Mientras el usuario escribe, se validan los campos
2. Validación al enviar : Al presionar "Mostrar Datos", se ejecuta validación completa
3. Retroalimentación visual : Errores mostrados en rojo debajo de cada campo
4. Prevención de errores : No se permite continuar hasta que todos los campos sean válidos
El formulario ahora es robusto y proporciona una excelente experiencia de usuario con validaciones claras y mensajes de error informativos.
