/*markdown
## Introducción al Lenguaje de Definición de Datos (DDL)

#### Criterios de definición de datos:

* Las tablas deben comenzar con una letra.
* Las tablas no deben tener más de 30 caracteres.
* Solo se permiten utilizar letras del alfabeto (inglés), números o el signo de subrayado (también los signos $ y #, pero esos se utilizan de manera especial, por lo que no son recomendados).
* No puede haber dos tablas con el mismo nombre dentro del mismo esquema (pueden coincidir los nombres si están en distintos esquemas).
* No puede coincidir el nombre de las tablas con el nombre de una palabra reservada SQL (por ejemplo no se puede llamar SELECT a una tabla).


#### **Sentencias DDL:**

A continuación se explica con detalle las sentencias DDL:

* Crear una tabla: CREATE TABLE nombre (atributo restricción, atributo restricción);
* Borrar tabla: DROP TABLE nombre;
* Borrar los datos de la tabla pero no la estructura: TRUNCATE TABLE nombre;
* Añade una comentario en la tabla: COMMENT ON TABLE nombre IS comentario;
* Renombra una tabla: ALTER TABLE name RENAME nuevo_nombre;  
*/

/*markdown
##### **Crear tabla:**

La estructura de la sentencia de creación de tablas es (entre [ ] los elementos opcionales):

CREATE TABLE nombre (  
       atributo1 tipo_datos [restricción],  
       atributo2 tipo_datos [restricción],  
       atributo3 tipo_datos [restricción],  
       [CONSTRAINT nombre_constraint PRIMARY KEY (atributo1, ..., atributoN)],  
       [CONSTRAINT nombre_constraint FOREIGN KEY (atributo_FK) REFERENCES nombre_tabla(atributo_PK)],  
       [Opciones adicionales]  
);  

* **tipo_datos** = indica qué tipos de valores puede tomar la columna. Hace referencia al dominio. Los más comunes serían:

    * **carácter o texto:**
        * char(N): texto de longitud fija N.
        * varchar(N): texto de longitud variable N.
    * **numérico:**
        * integer o integer(N): números enteros con o sin límite de tamaño
        * decimal(N,D): número decimal con N valores en total y D valores decimales. Por ejemplo, el decimal(7,2) tendría una parte entera de 5 posiciones y decimal de 2 por lo que el total sería de 7.
    * **fecha y hora:**
        * Date: fecha 'dia/mes/año' en función de la configuración regional de la base de datos
        * DATETIME o TIMESTAMP: fecha con el tiempo 'dia/mes/año horas:minutos:segundos' en función de la configuración regional y del entorno en el que esté la base de datos.
        * TIME: Tiempo 'horas:minutos:segundos' en función del entorno en el que esté la base de datos.
        * YEAR: devuelve el año actual.
        

  Más información en [la documentación de mysql](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)

* **restricción** = indica qué condiciones no pueden darse en la tabla y pueden variar para cada columna de la misma. Se pueden combinar dentro de una misma tabla:
    * PRIMARY KEY = definición de clave primaria. Impide que se repitan dos valores iguales en la columna o que hayan valores nulos.
    * UNIQUE = impide que haya valores duplicados en la columna. No se pueden repetir valores ya existentes.
    * NOT NULL = impide insertar valores nulos o vacíos o dejar la columna sin informar.
    * DEFAULT = si no se informa en la inserción, pondrá un valor por defecto.
    * CHECK (condición) = restringe los datos que se pueden informar. Comprueba el dato que se va a insertar y revisa que cumpla la condición dada en la definición
    * FOREIGN KEY = Restricción de clave foránea. Permite definir cómo se uniran dos tablas. No permite la unión de dos tablas por campos que tengan diferente tipo de datos.

A continuación podrás probar diferentes ejemplos de sentencias de creación de tablas. Iremos de las más sencillas a las más complejas, añadiendo poco a poco elementos opcionales:
*/

-- Comenzamos con la creación de una base de datos independiente para poder trabajar:

CREATE DATABASE instituto;

USE instituto;

-- Creación de tablas sin restricciones, solo atributos y su tipo de datos correspondiente

CREATE TABLE estudiantes (
    Nombre char(25),
    Apellido char(255),
    Fecha_nacimiento date
);

/* Creación de tabla con restricciones: 
    * PRIMARY KEY = Clave primaria de la tabla, solo habrá una
    * auto_increment = Genera números auto incrementales cada vez que se inserta una fila
    * NOT NULL = No permite la inserción de valores nulos
*/

CREATE TABLE clase (
    ID integer PRIMARY KEY auto_increment,
    Edificio char(50) DEFAULT 'Edificio principal',
    Planta integer NOT NULL
);

/* Creación de una tabla con restricciones:
    * UNIQUE = no pueden repetire los valores de la columna
    * CHECK = comprueba si se cumple la condición y si se cumple, inserta los datos
    * CONSTRAINT nombre_constraint FOREIGN KEY (atributo_fk) REFERENCES nombre_tabla(atributo_PK)
*/

CREATE TABLE grupo (
    ID_grupo integer PRIMARY KEY auto_increment,
    Nombre char(25),
    Siglas integer(9) UNIQUE,
    num_alumnos decimal(8,2) check(num_alumnos >= 0),
    ID_clase integer,
    CONSTRAINT fk_grupo FOREIGN KEY (ID_clase) REFERENCES clase(ID)
);

/*markdown
##### **Modificar la tabla:**

La estructura de la sentencia de modificación de tablas es (entre [] los elementos opcionales):

ALTER TABLE nombre ADD|MODIFY|RENAME|DROP (sentencia);

* ADD = Permite añadir columnas/elementos nuevas/os a la tabla
* MODIFY = Permite modificar la definición de una columna
* RENAME o RENAME COLUMN  TO = permite renombrar una tabla o columna
* DROP COLUMN o DROP CONSTRAINT = Permite borrar una columna o una restricción

A continuación podrás probar diferentes ejemplos de sentencias de modificación de tablas. Iremos de las más sencillas a las más complejas, añadiendo poco a poco elementos opcionales:
*/

-- Añade una columna a la tabla estudiantes

ALTER TABLE estudiantes ADD (ID_grupo integer);

-- Añade una restricción de clave foránea a la tabla estudiantes para relacionar la tabla estudiantes con la tabla grupo

ALTER TABLE estudiantes
ADD CONSTRAINT fk_grupo_estudiante
FOREIGN KEY (ID_grupo)
REFERENCES grupo(ID_grupo);


-- Añde una columna con restricción de clave primaria

ALTER TABLE estudiantes ADD (num_estudiante integer PRIMARY KEY);

-- Modifica una columna

ALTER TABLE grupo MODIFY COLUMN Siglas varchar(5) UNIQUE;

-- Renombrar una tabla

RENAME TABLE clase TO  aula;

-- Renombra la columna de una tabla

ALTER TABLE aula RENAME COLUMN Planta TO Piso;

-- Borra una columna

ALTER TABLE grupo DROP num_alumnos;

/*markdown
##### **Borra una tabla:**

La estructura de la sentencia de borrado de tablas o datos es (entre [ ] los elementos opcionales):

* DROP TABLE = permite borrar tablas completas
* TRUNCATE TABLE = borra todos los datos que contiene una tabla
*/

-- Borra una tabla

DROP TABLE grupo;

-- Borra todos los datos de una tabala

TRUNCATE TABLE estudiantes;

/*markdown
##### **Creación de tablas con opciones adicionales** 

A continuación se explica la siguiente configuración posible durante la creación o modificación de una tabla:

* ENGINE = Por defecto es InnoDB y, entre otras características, garantiza la optimización e indexación de la primary key mejorando la eficiencia en las búsquedas. [Más información sobre InnoDB](https://dev.mysql.com/doc/refman/8.0/en/innodb-storage-engine.html). Se puede informar cualquier otro como el MyISAM. [Más información sobre otros motores](https://dev.mysql.com/doc/refman/8.0/en/storage-engines.html)
* CHARACTER SET = se puede indicar el juego de caracteres que se usará para la tabla. Actualmente se utiliza comunmente 'utf8mb4'. [Más información](https://dev.mysql.com/doc/refman/8.0/en/charset-unicode-sets.html) 
* COLLATE = indica la regla de ordenación o colación que se usará para la tabla. En el caso del español, podemos usar utf8mb4_spanish_ci como guía de ordenación y comparación de cadenas para el idioma español. [Ejemplo de cómo afecta la selección de uno u otro al alemán](https://dev.mysql.com/doc/refman/8.0/en/charset-collation-effect.html)
* COMMENT = Añade comentarios a la tabla. Será muy últil cuando tenemos muchas tablas y necestiamos documentarlas
* INDEX = se puede mejorar la velocidad y eficiencia de las consultas que involucren la columna a la que se le asigne el index. [Más información](https://dev.mysql.com/doc/refman/8.0/en/create-index.html)
*/

-- Ejemplo de cómo se añade la configuración de una tabla durante su creación

CREATE TABLE profesor (
    DNI char(9) primary KEY,
    Nombre varchar(15) NOT NULL
)
ENGINE = InnoDB
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci
COMMENT = 'Tabla de profesores';

-- Podemos modificar las tablas y añadir índices. Recuerda que la primary key ya está indexada:

ALTER TABLE profesor ADD INDEX (Nombre);



-- Nos devuelve la información de la tabla y sus características:

DESCRIBE profesor;

-- Para obtener más información sobre los motores y sus características:

SELECT * FROM INFORMATION_SCHEMA.ENGINES;



/*markdown
> Para obtener [más información](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.7/en/information-schema-general-table-reference.html) sobre la tabla INFORMATION_SCHEMA.
*/