CREATE DATABASE IF NOT EXISTS dw_hospital; USE dw_hospital;

CREATE TABLE dim_paciente ( id_paciente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL, edad INT, genero ENUM(‘M’,‘F’,‘Otro’),
ciudad VARCHAR(100) );

INSERT INTO dim_paciente (nombre, edad, genero, ciudad) VALUES (‘Ana
Martínez’, 34, ‘F’, ‘Madrid’), (‘Carlos Pérez’, 52, ‘M’, ‘Barcelona’),
(‘Lucía Gómez’, 41, ‘F’, ‘Valencia’), (‘Javier Morales’, 29, ‘M’,
‘Sevilla’), (‘Sofía Herrera’, 47, ‘F’, ‘Bilbao’), (‘Miguel Angel Ramos’,
63, ‘M’, ‘Zaragoza’), (‘Paula Sánchez’, 22, ‘F’, ‘Murcia’), (‘Tomás
Delgado’, 38, ‘M’, ‘Granada’), (‘Daniel Ríos’, 55, ‘M’, ‘Toledo’),
(‘Valeria Navarro’, 31, ‘F’, ‘Pamplona’), (‘Hugo Salinas’, 44, ‘M’,
‘Alicante’), (‘Clara Méndez’, 27, ‘F’, ‘Santander’), (‘Rubén Ortiz’, 60,
‘M’, ‘Córdoba’), (‘Isabel Cano’, 36, ‘F’, ‘Valladolid’), (‘Adrián
Núñez’, 48, ‘M’, ‘Almería’), (‘Patricia Medina’, 50, ‘F’, ‘Málaga’),
(‘Gonzalo Serrano’, 39, ‘M’, ‘Gijón’), (‘Laura Pardo’, 24, ‘F’,
‘Logroño’);

CREATE TABLE dim_medico ( id_medico INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL, especialidad VARCHAR(100), hospital
VARCHAR(100) );

INSERT INTO dim_medico (nombre, especialidad, hospital) VALUES
(‘Dr. Juan López’, ‘Cardiología’, ‘Hospital Central’), (‘Dra. Marta
Ruiz’, ‘Dermatología’, ‘Hospital del Norte’), (‘Dr. Óscar Torres’,
‘Pediatría’, ‘Hospital Universitario’), (‘Dra. Elena Prieto’,
‘Neurología’, ‘Hospital Central’), (‘Dr. Alberto Castillo’,
‘Traumatología’, ‘Hospital del Norte’), (‘Dra. Laura Fuentes’,
‘Endocrinología’, ‘Hospital Universitario’), (‘Dr. Sergio Vega’,
‘Oftalmología’, ‘Clínica San José’), (‘Dra. Carmen Duarte’,
‘Ginecología’, ‘Hospital Central’), (‘Dr. Felipe Andrade’,
‘Psiquiatría’, ‘Clínica San José’), (‘Dra. Inés Bravo’, ‘Reumatología’,
‘Hospital Universitario’), (‘Dr. Marcos Calle’, ‘Otorrinolaringología’,
‘Hospital Central’), (‘Dra. Nuria Escobar’, ‘Medicina General’, ‘Centro
de Salud Norte’), (‘Dr. Raúl Vives’, ‘Nefrología’, ‘Hospital del
Norte’), (‘Dra. Susana León’, ‘Oncología’, ‘Hospital Central’),
(‘Dr. Pablo Vargas’, ‘Urología’, ‘Clínica Salud Vida’), (‘Dra. Teresa
Molina’, ‘Alergología’, ‘Hospital Universitario’), (‘Dr. Andrés Blanco’,
‘Hematología’, ‘Hospital del Norte’), (‘Dra. Lorena Gil’, ‘Geriatría’,
‘Clínica San José’);

CREATE TABLE dim_tiempo ( id_tiempo INT AUTO_INCREMENT PRIMARY KEY,
fecha DATE NOT NULL, anio INT NOT NULL, mes INT NOT NULL, dia INT NOT
NULL, trimestre INT NOT NULL );

INSERT INTO dim_tiempo (fecha, anio, mes, dia, trimestre) VALUES
(‘2024-01-10’, 2024, 1, 10, 1), (‘2024-02-15’, 2024, 2, 15, 1),
(‘2024-03-08’, 2024, 3, 8, 1), (‘2024-04-12’, 2024, 4, 12, 2),
(‘2024-05-20’, 2024, 5, 20, 2), (‘2024-06-03’, 2024, 6, 3, 2),
(‘2024-07-18’, 2024, 7, 18, 3), (‘2024-08-22’, 2024, 8, 22, 3),
(‘2024-09-14’, 2024, 9, 14, 3), (‘2024-10-05’, 2024, 10, 5, 4),
(‘2024-11-16’, 2024, 11, 16, 4), (‘2024-12-29’, 2024, 12, 29, 4),
(‘2025-01-12’, 2025, 1, 12, 1), (‘2025-02-03’, 2025, 2, 3, 1),
(‘2025-03-27’, 2025, 3, 27, 1), (‘2025-04-14’, 2025, 4, 14, 2),
(‘2025-05-19’, 2025, 5, 19, 2), (‘2025-06-21’, 2025, 6, 21, 2),
(‘2025-07-30’, 2025, 7, 30, 3), (‘2025-08-11’, 2025, 8, 11, 3),
(‘2025-09-25’, 2025, 9, 25, 3), (‘2025-10-07’, 2025, 10, 7, 4),
(‘2025-11-29’, 2025, 11, 29, 4), (‘2025-12-15’, 2025, 12, 15, 4);

CREATE TABLE fact_consultas ( id_consulta INT AUTO_INCREMENT PRIMARY
KEY, id_paciente INT, id_medico INT, id_tiempo INT, costo DECIMAL(10,2),
duracion_min INT, FOREIGN KEY (id_paciente) REFERENCES
dim_paciente(id_paciente), FOREIGN KEY (id_medico) REFERENCES
dim_medico(id_medico), FOREIGN KEY (id_tiempo) REFERENCES
dim_tiempo(id_tiempo) );

INSERT INTO fact_consultas (id_paciente, id_medico, id_tiempo, costo,
duracion_min) VALUES (1, 1, 1, 120.50, 30), (2, 2, 2, 75.00, 20), (3, 3,
3, 60.00, 25), (4, 4, 4, 95.00, 40), (5, 5, 5, 110.00, 35), (6, 6, 6,
150.00, 50), (7, 7, 7, 70.00, 25), (8, 8, 8, 130.00, 45), (9, 9, 9,
90.00, 30), (10, 10, 10, 85.00, 20), (11, 11, 18, 160.00, 45), (12, 12,
19, 145.00, 35), (13, 13, 20, 90.00, 25), (14, 14, 21, 120.00, 40), (15,
15, 22, 130.00, 55), (16, 16, 23, 80.00, 20), (17, 17, 24, 190.00, 60),
(18, 18, 25, 210.00, 70), (19, 19, 26, 95.00, 30), (20, 20, 27, 75.00,
18);
