create DATABASE clase;
use clase;
-- TABLA: clientes
create table clientes(
IDcliente INT,
-- INTEGER: Número entero para identificar de forma única a cada cliente
nombre VARCHAR (100),
-- VARCHAR(100): Texto de longitud variable de hasta 100 caracteres
perfil_bio TEXT,
-- TEXT: Permite almacenar textos largos sin un límite rígido previo
fecha_registro DATE
-- DATE: Guarda exclusivamente año, mes y día (YYYY-MM-DD),
);

-- TABLA: productos
create table productos(
id_producto INT,
-- INT: Identificador único del producto en formato entero
descripcion VARCHAR (255),
-- VARCHAR(255): Texto variable de hasta 255 caracteres para descripciones detalladas
precio DECIMAL (10,2),
-- DECIMAL(10,2): Exactitud numérica requerida para dinero. 
-- Soporta hasta 10 dígitos en total, de los cuales 2 son decimales
esta_activo BIT
-- BIT=BOOLEAN: Representa estados binarios (TRUE/1 = Activo, FALSE/0 = Inactivo)
); 