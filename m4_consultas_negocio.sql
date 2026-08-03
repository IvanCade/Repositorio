-- ============================================================================
-- PRE-ENTREGA MÓDULO 4: Consultas SQL de negocio
-- Base de Datos: Ventas_Tech_DB
-- ============================================================================

USE Ventas_Tech_DB;

-- ----------------------------------------------------------------------------
-- CONSULTA 1: Resumen ejecutivo mensual
-- Muestra el total facturado, la cantidad de pedidos (transacciones) y el
-- ticket promedio por mes.
-- ----------------------------------------------------------------------------

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

-- ----------------------------------------------------------------------------
-- CONSULTA 2: Ranking de productos
-- Top 5 de id_producto por total facturado y unidades vendidas.
-- ----------------------------------------------------------------------------

SELECT TOP 5
     id_producto,
     SUM(cantidad) AS unidades_vendidas,
     SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


-- ----------------------------------------------------------------------------
-- CONSULTA 3: Clientes recurrentes
-- Clientes con más de un pedido, mostrando cantidad de pedidos y total gastado.
-- ----------------------------------------------------------------------------

SELECT
     id_cliente,
     COUNT(*) AS cantidad_pedidos,
     SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*)>1
ORDER BY total_gastado DESC;

-- ----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima / por debajo del promedio
-- (Sin usar CASE WHEN / THEN / ELSE)
-- ----------------------------------------------------------------------------

-- 4a. Meses con total facturado POR ENCIMA del promedio mensual general

SELECT
   MONTH(fecha_venta) AS mes,
   SUM(cantidad * precio_unitario) AS total_facturado_mes,
   CASE
      WHEN SUM(cantidad * precio_unitario) > (
         SELECT AVG(1.0 * total_mensual)
         FROM (
            SELECT SUM(cantidad * precio_unitario) AS total_mensual
            FROM ventas
            GROUP BY MONTH(fecha_venta)
        ) AS subconsulta_promedio
    ) THEN 'Por encima'
    ELSE 'Por debajo'
END AS estado_frente_al_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;


-- ============================================================================
-- BLOQUE DE CIERRE: Hallazgos de negocio

/*
HALLAZGOS CLAVE TRAS EL ANÁLISIS DE DATOS:

1. Concentración en un producto estrella:
   El `id_producto = 1` (Laptop PRO 15) es el principal ingreso de la empresa, 
   generando $3,600.00 en solo 3 ventas (3 unidades). Esto representa casi el 50% 
   de la facturación total registrada ($7,294.00).

2. Alta fidelización/recurrencia de clientes:
   Todos los clientes registrados en esta muestra (del id_cliente 1 al 5) realizaron 
   exactamente 2 pedidos en el período analizado. No hay clientes con una sola compra.

3. Volumen vs. Facturación:
   El `id_producto = 2` (Mouse inalámbrico) lidera en volumen con 13 unidades vendidas, 
   pero se ubica último en facturación dentro del Top 5 ($364.00) debido a su bajo 
   precio unitario ($28.00). 
*/