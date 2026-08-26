Práctica: Conectividad y Transformación de Datos en Power BI
  Propósito
Preparar un set de ventas exportado desde un sistema legacy, aplicando transformaciones en Power Query para dejarlo en condiciones óptimas de análisis y modelado.

  Carga de datos
Se utilizó el conector de Excel en Power BI para importar el archivo Ventas_export_legacy.xlsx.

Se verificó la vista previa de datos antes de confirmar la carga, asegurando coherencia en las columnas y filas.

   Transformaciones aplicadas en Power Query
   
1. Renombrado de columnas
Se reemplazaron nombres técnicos (COD_CLI_001, FLG_ACT) por etiquetas descriptivas (id_cliente, cliente_activo).

Justificación: mejora la legibilidad y facilita el mantenimiento del modelo.

2. Corrección de tipos de datos
Fechas → formato Date.

Montos → Decimal Number o Currency.

IDs → Whole Number o Text.

Justificación: asegurar compatibilidad con filtros temporales, cálculos numéricos y relaciones entre tablas.

3. Gestión de duplicados y nulos
Se eliminaron duplicados en id_transaccion.

Los valores nulos en total_venta se reemplazaron por 0.

Justificación: evitar distorsiones en métricas agregadas y garantizar consistencia.

4. Normalización de estructura
Se separaron columnas en dos tablas:

Clientes: id_cliente, nombre_cliente, direccion, cliente_activo.

Transacciones: id_transaccion, id_cliente, fecha_transaccion, producto, cantidad, precio_unitario, total_venta.

Justificación: evitar redundancia y habilitar un modelo relacional uno-a-muchos.


Se adjunta un PDF con capturas de pantalla del flujo en Power Query, mostrando cada transformación aplicada en orden.
