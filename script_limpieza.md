let
    // Paso 1: Fuente de datos original
    // Power BI genera automáticamente la tabla al cargar datos manuales
    Origen = Table.FromRows({
        {"1"," Laptop Pro 15 ","Computación","1200.00","2024-01-05"},
        {"2","Mouse Inalámbrico","accesorios","28.00","2024-01-08"},
        {"3"," Teclado Mecánico","PRUEBA","95.00","2024-01-12"},
        {"4","Monitor 4K ","computación","450.00","2024-02-03"},
        {"5"," Auriculares BT","Audio","120.00","2024-02-10"},
        {"6","SSD Externo 1TB ","PRUEBA","130.00","2024-03-05"},
        {"7","Webcam HD","Accesorios","85.00","2024-03-12"}
    },
    {"id_venta","nombre_producto","categoria","precio","fecha_venta"}),

    // Paso 2: Eliminar espacios en blanco al inicio y al final
    // Usamos Text.Trim sobre la columna nombre_producto
    LimpiarEspacios = Table.TransformColumns(
        Origen,
        {{"nombre_producto", Text.Trim, type text}}
    ),

    // Paso 3: Estandarizar la columna categoria a Title Case
    // Unificamos mayúsculas/minúsculas con Text.Proper
    EstandarizarCategoria = Table.TransformColumns(
        LimpiarEspacios,
        {{"categoria", Text.Proper, type text}}
    ),

    // Paso 4: Filtrar y eliminar registros de prueba
    // Excluimos filas donde categoria sea exactamente "Prueba"
    EliminarPruebas = Table.SelectRows(
        EstandarizarCategoria,
        each [categoria] <> "Prueba"
    ),

    // Paso 5: Definir tipos de datos correctos
    TiparColumnas = Table.TransformColumnTypes(
        EliminarPruebas,
        {
            {"id_venta", Int64.Type},
            {"nombre_producto", type text},
            {"categoria", type text},
            {"precio", type number},
            {"fecha_venta", type date}
        }
    )
in
    TiparColumnas
