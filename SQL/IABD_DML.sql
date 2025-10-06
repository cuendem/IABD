/*markdown
## Introducción al Lenguaje de Manipulación de Datos (DML)

#### **Definición y catacterísticas:**

El lenguaje de manipulación de datos (DML) se utiliza para trabajar con los datos que se almacenan en las tablas. Se ejecutan por transacciones como el resto de sentencias SQL pero los cambios se realizan a nivel de celdas o filas.


#### **Sentencias DML:**

A continuación se explica con detalle las sentencias DML:

* Inserción de datos en una tabla: INSERT INTO nombre (atributo1... atributoN) VALUES (valor1, ... valorN);
* Borrado de datos en una tabla: DELETE FROM nombre [WHERE (condición)];
* Modifica valores de una tabla: UPDATE nombre SET atributo = valor [WHERE (condición)];
* Selección de datos: SELECT atributo1,... atributoN FROM tabla [JOIN|WHERE|ORDER BY|HAVING];


*/

/*markdown
> Todos los ejemplos que hagamos se harán sobre la tablas COCHE:

    CREATE TABLE coche(
        Matricula char(7) primary key,
        Modelo varchar(255) NOT NULL,
        Marca varchar(255)
    );
*/

CREATE DATABASE IF NOT EXISTS IABD_DML;
USE IABD_DML;

CREATE TABLE coche(
    Matricula char(7),
    Modelo varchar(255),
    Marca varchar(255)
);

/*markdown
##### **Inserción de datos en una tabla:**

La estructura de la sentencia de inserción de datos en tablas es (entre [ ] los elementos opcionales):

    INSERT INTO nombre [( atributo1,... atributoN)] 
    VALUES (valor1,.... valorN),(valor1,.... valorN);  

A la hora de insertar datos tenemos dos opciones:
* Insertar datos para todas las columnas: no será necesario indicar las columnas donde se insertarán los datos porque serán todas.
* Insertar datos para algunas de las columnas: será necesario informar las columnas en las que se insertarán los datos porque solo serán algunas.

Además, se puede insertar en una misma sentencia / transacción más de una fila al mismo tiempo.
*/

-- Inserción de 1 fila de datos para todas las oolumnas de la tabla coche:

INSERT INTO coche VALUES ('9823PRM', 'Honda Civic', 'Honda');

-- Inserción de 3 filas de datos para dos de las columnas que no pueden ser nunca nulas:

INSERT INTO coche (Matricula, Modelo) VALUES ('1324JSW', 'Ford Focus'), 
('4356PKW', 'Toyota Corolla'), 
('2301FRK', 'Volkswagen Golf'),
('2568PLL', 'A3'),
('8965QRM', 'MULSANNE'),
('5001KLR', 'Dolphin'),
('9960LLT', 'MULSANNE'),
('0133FHJ', 'C3'),
('5566PPY', 'TERRAMAR'),
('9689QSS', '500'),
('2323MNM', 'PUROSANGUE')
;

-- Si queréis comprobar si los datos se han insertado o no, podéis ejecutar:

SELECT * FROM coche;

-- Fíjate que para aquellas columnas que no se han informado nos almacena un 'null'

/*markdown
##### **Borrar datos de la tabla:**

La estructura de la sentencia de borrar datos de la tablas es (entre [] los elementos opcionales):

    DELETE FROM nombre [WHERE (condición)];

WHERE borrará solo los datos que coincidan con la condición. Los operadores pueden ser:
    * < o > - Menor o mayor que un valor
    * <= o >= - Menor o igual o mayor o igual que un valor
    * = - Igual que un valor
    * != - Diferente que
    * like - Parecido a un valor. Se puede utilizar con expresiones regulares como 'A%' o '%A'
    * in( valor1, ..., valorN) - Que coincida con uno de los valores de la lista
    * between valor1 and valor 2 - Que coincida y esté entre dos valores

Información adicional:  
  * Cualquiera de los operadores se puede negar usando NOT.
  * Cualquiera de las condiciones puede combinarse con otras usando AND u OR.
  * Es muy importante, si se combinan condiciones, utilizar paréntesis agrupándolas.

A continuación podrás probar diferentes ejemplos de sentencias de borrado de datos:
*/

-- Borra los datos que coincidan con la condición: La matrícula contiene una W

DELETE FROM coche WHERE Matricula like '%W%';

-- Borra los datos que coincidan con la condición: La matrícula contiene una W

DELETE FROM coche WHERE Modelo in ('MULSANNE', 'A3') OR Matricula = '5001KLR';

-- Borra todos los datos te una tabla igual que la sentencia anterior

DELETE FROM coche;

/*markdown
##### **Modifica los datos de la tabla:**

La estructura de la sentencia de modificar o actualizar datos de la tablas es (entre [] los elementos opcionales):

    UPDATE nombre SET atributo1 = valor1, ..., atributoN = valorN [WHERE (condición)];

El WHERE se escribe igual que la sentencia de DELETE explicada anteriormente.

A continuación podrás probar diferentes ejemplos de sentencias de actualización de datos:


*/

-- Se pueden actualizar masivamente los datos:

UPDATE coche SET Marca = 'No asignado';

-- Actualiza los datos de la marca cuando el modelo sea TERRAMAR:

UPDATE coche SET Marca = 'Cupra' WHERE Modelo = 'TERRAMAR';

-- Actualiza varias celdas con una misma condición

UPDATE coche SET Marca = 'Sin informar' WHERE Modelo = 'No asignado';

-- Revisa las acutalizaciones

SELECT * FROM coche;

/*markdown
> Para comprender qué hace las sentencias que estás ejecutando, puedes utilizar EXPLAIN . [Más información aquí](https://dev.mysql.com/doc/refman/8.0/en/explain.html)
*/

EXPLAIN SELECT * FROM coche;