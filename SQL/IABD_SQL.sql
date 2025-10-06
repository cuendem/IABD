/*markdown
## Introducción al SQL

Este documento contiene toda la información relacionada con la introducción al lenguaje SQL y las bases de datos relacionales. Podrás ejecutar todas las sentencias SQL de las explicaciones o crear tus propias sentencias.

1. ¿Qué es SQL?
2. Estructura de la base de datos
3. Estructura de las sentencias SQL
4. Sentencias SQL agrupadas por tipo
*/

/*markdown
> ¡Recuerda! Las bases de datos relacionales son aquellas que permiten almacenar los datos en tablas relacionadas entre sí.
*/

/*markdown
### 1. ¿Qué es SQL?

Llamamos SQL (Structured Query Language) al lenguaje de consulta estructurado que se utiliza para la gestión de una base de datos: creación de estructura, permisos, inserción y gestión de datos, etc...
*/

/*markdown
### 2. Estructura de la base de datos

Una base de datos relacional permite almacenar la información en repositorios. Cada usuario tendrá un repositorio propio. También podrán existir otros repositorios a los que los usuarios podrán tener o no acceso y diferentes tipos de permisos. En cada repositorio se almacenarán tablas y, a menos que se lo indiquemos, entre un repositorio y otro no se podrán relacionar dichas tablas. 

A continuación ejemplos que podéis ejecutar y ver qué ocurre:
*/

-- Así se crea un repositorio. Quién lo crea es administrador así que tiene todos los permisos

CREATE DATABASE DATOSSQL;

-- Puedes revisar a qué repositorios tienes acceso. Aparecerán los propios del sistema

SHOW DATABASES;

-- Para utilizar un repositorio concreto:

USE DATOSSQL;

/*markdown
> ¡A partir de ahora todas las acciones que hagamos serán dentro de la base de datos DATOS_SQL
*/

/*markdown
### 3. Estructura de las sentencias SQL

El lenguaje SQL nos permite ejecutar sentencias que, por cada ejecución de cada sentencia realiza una acción sobre la base de datos.  A este tipo de acciones individuales las llamamos transacciones.
*/

-- Esta sentencia crea la tabla PRODUCTO con tres campos o atributos: ID, Nombre y Precio

CREATE TABLE PRODUCTOS (
    ID integer PRIMARY KEY,
    Nombre varchar(15),
    Precio decimal(5,2)
);

-- Esta sentencia permite insertar datos en la tabla PRODUCTOS:
INSERT INTO PRODUCTOS 
VALUES (1, 'Raqueta', 23.5),
(2, 'Pelota', 15.7),
(3, 'Patines', 89.89);

-- Esta sentencia borra la tabla

DROP TABLE PRODUCTOS;

/*markdown
> ¡ SQL no permite hacer un único código que ejecute las 3 acciones simultaneamente! Solo podrán ejecutarse individualmente
*/

/*markdown
### 4. Sentencias SQL agrupadas por tipo

Las sentencias SQL se pueden agrupar en función del tipo de acción que se quiere realizar sobre la BBDD:

* Lenguaje de Definición de Datos (DDL): Se utiliza para crear la BD y modificar su estructura.
* Lenguaje de Manipulación de Datos (DML): Permite trabajar con los datos: hacer altas, modificaciones, bajas y consultar los datos existentes.
* Lenguaje de Control (DCL): Permite realizar la gestión de usuarios y permisos, y tareas de seguridad.
* Lenguaje de control de transacciones (TCL): Permite controlar las ejecuciones de las transacciones SQL.
*/

/*markdown
#### Sentencias DDL:

* Crear tabla: CREATE TABLE nombre;
* Modificar la estructura de la tabla: ALTER TABLE nombre ADD|MODIFY|RENAME (sentencia);
* Borrar tabla: DROP TABLE nombre;
* Borrar los datos de la tabla pero no la estructura: TRUNCATE TABLE nombre;
* Añade una comentario en la tabla: COMMENT ON TABLE nombre IS comentario;
* Renombra una tabla: ALTER TABLE name RENAME nuevo_nombre;  

A continuación ejemplos que podéis ejecutar y ver qué ocurre:
*/

-- Crea la tabla estudiantes con los respectivos campos

CREATE TABLE ESTUDIANTE (
    ID integer PRIMARY KEY,
    Nombre varchar(15) NOT NULL,
    Apellido varchar(50) NOT NULL,
    Fecha_nacimiento date
); 

-- Añade un nuevo campo a la tabla estudiantes

ALTER TABLE ESTUDIANTE ADD (Nota_media decimal(4,2));

/* Puedes ir al sistema gestor de baese de datos (SGBD) o al MySQL shell for VS Code 
del lateral y consultar las tablas del repositorio o ejecutar el siguiente código: */

show tables;


/*markdown
#### Sentencias DML:

* Seleccionar datos de una tabla: SELECT atributos FROM nombre;
* Insertar datos en la tabla: INSERT INTO nombre (atributos) VALUES (valores);
* Actualiza los datos: UPDATE nombre SET atributo = valor WHERE (condición);
* Borra datos de la tabla de forma selectiva: DELETE FROM nombre WHERE (condición);

A continuación ejemplos que podéis ejecutar y ver qué ocurre:
*/

-- Inserción de datos

INSERT INTO ESTUDIANTE (ID, Nombre, Apellido) VALUES ('1', 'Ana', 'Valero');

-- Actualizar datos

UPDATE ESTUDIANTE SET Nota_media = 2.5; 

-- Seleccionar los datos de la tabla

SELECT * FROM ESTUDIANTE;

/*markdown
#### Sentencias DCL:

* Crear usuarios: CREATE USER nombre@host IDENTIFIED BY contraseña; 
* Asignar permisos a los usurios: GRANT rol ON base_de_datos TO usuario;
* Quitar permisos a los usuarios: REVOKE rol TO usuario;

A continuación ejemplos que podéis ejecutar y ver qué ocurre:
*/

-- Crear un usuario nuevo

CREATE USER 'estudiante1'@'localhost' IDENTIFIED BY '1234';

-- Asignar permisos

GRANT ALL PRIVILEGES ON *.* TO 'estudiante1'@'localhost'; 
FLUSH PRIVILEGES;

/*markdown
#### Sentencias TCL:

* Persistir los cambios una vez ejecutado el comando: COMMIT; 
* Echar hacia detrás los cambios: ROLLBACK;
* Poner puntos de control para poder asegurar la persistencia: SAVEPOINT;   

Se ejecutan individualmente y devuelven un mensaje. Para ver su efecto en la base de datos hay que revisar si se ha realizado o no la transacción anterior a la ejecución de estas sentencias.
*/