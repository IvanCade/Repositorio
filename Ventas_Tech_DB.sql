--============================================================================
-- PASO 1: Creación e inicialización de la Base de Datos
-- ============================================================================

CREATE DATABASE Ventas_Tech_DB;

-- ============================================================================
-- PASO 2: Script Principal (DROP, CREATE e INSERT)
-- ============================================================================

-------------------------------------------------------------------------------
-- 1. DROP TABLES (En orden inverso a las dependencias para evitar errores de FK)
-------------------------------------------------------------------------------

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-------------------------------------------------------------------------------
-- 2. CREATE TABLES (En orden respetando las dependencias)
-------------------------------------------------------------------------------

-- Tabla: categorias
CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY,
  nombre_categoria VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200)
  );

  -- Tabla: clientes
  CREATE TABLE clientes (
   id_cliente INT PRIMARY KEY,
   nombre VARCHAR (100) NOT NULL,
   email VARCHAR (100) UNIQUE,
   ciudad VARCHAR (50),
   fecha_registro DATE NOT NULL
   );

   -- Tabla: productos

   CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR (100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL (10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo TINYINT DEFAULT 1,
    CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    );

     -- Tabla: ventas
   CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL (10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    CONSTRAINT fk_ventas_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-------------------------------------------------------------------------------
-- 3. INSERT DATA (Primero entidades independientes, luego las transaccionales)
-------------------------------------------------------------------------------

-- Insertar categorías (4 registros)

INSERT INTO categorias (
id_categoria,
nombre_categoria,
descripcion 
)VALUES
(1, 'Computacion', 'Laptops, PCs y monitores'),
(2, 'Accesorios', 'Periféricos y complementos'),
(3, 'Audio', 'Auriculares y parlantes'),
(4, 'Almacenamiento', 'Discos y memorias');

-- Insertar clientes (5 registros)

INSERT INTO clientes (
id_cliente,
nombre,
email,
ciudad,
fecha_registro
)VALUES
(1, 'María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
(2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
(3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01'),
(4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
(5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');

-- Insertar productos (6 registros)

INSERT INTO productos (
id_producto,
nombre_producto, 
id_categoria,
precio,
stock,
activo
)VALUES
(1, 'Laptop PRO 15', 1, 1200.00, 15, 1),
(2, 'Mouse inalambrico', 2, 28.00, 80, 1),
(3, 'Monitor 4K 27"', 1, 450.00, 12, 1),
(4, 'Auriculares BT Pro', 3, 120.00, 35, 1),
(5, 'SSD Externo 1TB', 4, 130.00, 18, 1),
(6, 'Teclado Mecánico', 2, 95.00, 40, 1);

-- Insertar ventas (10 registros)

INSERT INTO ventas (
id_venta,
id_cliente,
id_producto, 
cantidad, 
precio_unitario,
fecha_venta
)VALUES
(1, 1, 1, 2, 1200.00, '2024-03-05'),
(2, 2, 2, 5, 28.00, '2024-03-06'),
(3, 3, 3, 1, 450.00, '2024-03-07'),
(4, 1, 4, 2, 120.00, '2024-03-08'),
(5, 4, 5, 3, 130.00, '2024-03-10'),
(6, 2, 6, 4, 95.00, '2024-03-11'),
(7, 5, 1, 1, 1200.00, '2024-03-12'),
(8, 3, 2, 8, 28.00, '2024-03-13'),
(9, 4, 4, 1, 120.00, '2024-03-14'),
(10, 5, 3, 2, 450.00, '2024-03-15');

-- ============================================================================
-- PASO 3: Consultas de Validación
-- ============================================================================

SELECT * FROM categorias; 
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;