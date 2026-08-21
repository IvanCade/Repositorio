-- ============================================================================
-- Pre-entrega: Consultas con JOINs para el proyecto
-- Título: Cruzando tablas para enriquecer el análisis
-- Base de datos: Ventas_Tech_DB
-- ============================================================================

USE Ventas_Tech_DB;

-- ----------------------------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- ----------------------------------------------------------------------------
-- Combina ventas, clientes, productos y categorías para obtener en una sola fila:
-- fecha, nombre del cliente, segmento, región, nombre del producto, categoría,
-- cantidad, precio unitario, total de venta y canal.
-- Nota: Dado que 'segmento' y 'canal' no existen en la base de datos, 
-- se asignan valores por defecto/calculados y la ciudad se toma como región.

SELECT 
    v.fecha_venta AS fecha,
    c.nombre AS nombre_cliente,
    'Consumidor Final' AS segmento,                  -- Segmento genérico/predeterminado
    c.ciudad AS region,                              -- La ciudad actúa como región del cliente
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta, -- Total calculado de la venta
    'Online' AS canal                                -- Canal genérico/predeterminado
FROM ventas v
INNER JOIN clientes c 
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p 
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat 
    ON p.id_categoria = cat.id_categoria;


-- ----------------------------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- ----------------------------------------------------------------------------
-- Identifica clientes registrados que aún no han realizado ninguna compra.
-- Muestra nombre, email y fecha de registro.

SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v 
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ----------------------------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- ----------------------------------------------------------------------------
-- Identifica productos del catálogo que no tienen ninguna venta registrada.
-- Muestra nombre del producto, categoría y precio.

SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria, -- Viene de 'categorias'
    p.precio
FROM productos p
INNER JOIN categorias cat             -- 1. Trae el nombre descriptivo de la categoría
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v                    -- 2. Detecta si el producto tiene o no ventas
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;             -- 3. Filtra solo los productos sin ventas

-- ----------------------------------------------------------------------------
-- Consulta 4 — Consolidado por canal (UNION ALL + GROUP BY)
-- ----------------------------------------------------------------------------
-- Combina en un solo resultado las ventas por canal ('Online' y 'Presencial') 
-- mediante UNION ALL y calcula el total de ventas agrupado por canal.

SELECT 
    sub.canal,
    COUNT(sub.id_venta) AS cantidad_transacciones,
    SUM(sub.total_venta) AS total_por_canal
FROM (
    -- Subconsulta de ventas Online (ejemplo: ventas con id par)
    SELECT 
        id_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Online' AS canal
    FROM ventas
    WHERE id_venta % 2 = 0

    UNION ALL

    -- Subconsulta de ventas Presenciales (ejemplo: ventas con id impar)
    SELECT 
        id_venta,
        (cantidad * precio_unitario) AS total_venta,
        'Presencial' AS canal
    FROM ventas
    WHERE id_venta % 2 <> 0
) AS sub
GROUP BY sub.canal;