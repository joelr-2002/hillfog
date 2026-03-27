# Cómo compilar y ejecutar hillfog

## Requisitos
- Java 11 o superior  
- Maven 3.x

## Base de datos
- **Motor**: H2 Database (embebida)
- **Ubicación**: `C:\Users\<usuario>\hillfog_0_4.mv.db` (Windows)
- **Modo**: Archivo (persistente)
- **Inicialización**: Automática al primer arranque (usa el script `doc/hillfog_h2.sql`)

### Usuarios por defecto
Después de la inicialización, están disponibles estos usuarios:
- **admin** / password: `password` (contraseña por defecto, ver en el script SQL)
- **bill** / password: Ver en `doc/hillfog_h2.sql`
- **frank** / password: Ver en `doc/hillfog_h2.sql`

**Nota**: Las contraseñas están hasheadas con BCrypt en el script SQL.

## Compilación

### Opción 1: Usando el script de compilación (recomendado)
```bash
build-hillfog.bat
```

### Opción 2: Compilación manual
```bash
# 1. Compilar core-hillfog
cd core-hillfog
mvn clean install -DskipTests
cd ..

# 2. Compilar core-app
cd core-app
mvn clean package -DskipTests
cd ..
```

## Ejecución

### Opción 1: Usando el script de ejecución (recomendado)
```bash
run-hillfog.bat
```

### Opción 2: Ejecución manual
```bash
java -Xmx512M -jar core-app\target\hillfog-core-app-0.0.1-SNAPSHOT.jar
```

## Acceso a la aplicación
Una vez iniciada la aplicación, abre tu navegador (Chrome o Firefox) y accede a:
```
http://127.0.0.1:8088
```

## Reiniciar la base de datos
Si necesitas reiniciar la base de datos desde cero:

1. Detener la aplicación (Ctrl+C)
2. Eliminar el archivo de base de datos:
   ```bash
   del %USERPROFILE%\hillfog_0_4.mv.db
   ```
3. Iniciar la aplicación nuevamente (se inicializará automáticamente)

## Notas importantes
- El archivo JAR ejecutable se encuentra en: `core-app\target\hillfog-core-app-0.0.1-SNAPSHOT.jar`
- La aplicación usa una base de datos H2 embebida que se inicializa automáticamente en el primer arranque
- La base de datos se persiste en el disco, por lo que los datos se mantienen entre reinicios
- Para detener la aplicación, presiona `Ctrl+C` en la terminal
- Si ves advertencias de NullPointerException sobre LoadResources en los logs, son no críticas y no afectan la funcionalidad

## Solución de problemas

### Error: "Cannot invoke DefaultResult.getMessage() because result is null"
**Causa**: La base de datos no se inicializó correctamente.  
**Solución**: Elimina el archivo de base de datos (`%USERPROFILE%\hillfog_0_4.mv.db`) y reinicia la aplicación.

### Error: "No message found under code 'page.login.signin'"
**Causa**: Los archivos de internacionalización (i18n) no están en el classpath.  
**Solución**: Recompila el proyecto con `build-hillfog.bat` - los archivos i18n se incluirán automáticamente.

## Cambios realizados en la configuración
Los siguientes archivos POM fueron modificados para corregir la estructura de directorios:
- `core-hillfog/pom.xml` - Agregado `<sourceDirectory>src</sourceDirectory>` y recursos (incluye i18n)
- `core-app/pom.xml` - Agregado `<sourceDirectory>src</sourceDirectory>`, recursos (incluye JSON para init DB) y habilitado Spring Boot plugin
