-- ════════════════════════════════════════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Ivan Cade
-- Fecha: 2026-07-23
-- ════════════════════════════════════════════════════════════════════════════
-- ── SECCIÓN DDL ─────────────────────────────────────────────────────────────

-- Paso 1: Eliminar la tabla si existe para permitir la re-ejecución sin errores
DROP TABLE IF EXISTS inventario;

-- Paso 2: Creación de la estructura de la tabla
CREATE TABLE inventario (
   id_producto INT PRIMARY KEY,
   nombre_Producto VARCHAR (100) NOT NULL,
   categoria VARCHAR (50) NOT NULL,
   precio_unitario DECIMAL (10,2) NOT NULL,
   stock_actual INT NOT NULL,
   stock_minimo INT NOT NULL,
   fecha_ingreso DATE NOT NULL,
   activo TINYINT NOT NULL, 
   );

   -- Justificación de los tipos de datos elegidos:
-- 1. id_producto (INT): Es ideal para identificadores numéricos enteros de clave primaria.
-- 2. precio_unitario (DECIMAL(10,2)): A diferencia de FLOAT o DOUBLE, evita errores de redondeo o imprecisión en operaciones con dinero en USD.
-- 3. activo (TINYINT / BOOLEAN): Un entero pequeño (0 o 1) optimiza espacio en memoria para flags de estado verdadero/falso.

-- ── SECCIÓN DML ─────────────────────────────────────────────────────────────

-- Paso 3: Carga masiva de los 10 productos iniciales
INSERT INTO inventario (
   id_producto,
   nombre_producto,
   categoria,
   precio_unitario,
   stock_actual,
   stock_minimo,
   fecha_ingreso,
   activo
   ) VALUES
   (1, 'Laptop PRO 15', 'Computacion', 1200.00, 15, 3, '2024-01-10', 1),
   (2, 'Mouse Inalambrico', ' Accesorios', 28.00, 80, 10, '2024-01-10', 1),
   (3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
   (4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
   (5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
   (6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
   (7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
   (8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
   (9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
   (10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);

   -- Paso 4: Registro de ventas del día (Descuento de stock)

   -- Venta 1: Laptop Pro 15 (id: 1) -> Se vendieron 3 unidades (15 - 3 = 12)
   UPDATE inventario 
   SET stock_actual = stock_actual - 3
   WHERE id_producto = 1;

   -- Venta 2: Mouse Inalámbrico (id: 2) -> Se vendieron 12 unidades (80 - 12 = 68)
   UPDATE inventario
   SET stock_actual = stock_actual - 12
   WHERE id_producto = 2;

   -- Venta 3: Auriculares BT Pro (id: 6) -> Se vendieron 5 unidades (35 - 5 = 30)
   UPDATE inventario
   SET stock_actual = stock_actual -5
   WHERE id_producto = 6;

   -- Paso 5: Descontinuar producto
   -- Webcam HD 1080p (id: 8) fue descontinuada por el proveedor

   UPDATE inventario
   SET activo = 0
   WHERE  id_producto = 8;

   -- Paso 6: Validar los resultados finales
   SELECT * FROM inventario;



