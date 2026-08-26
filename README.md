let
  Origen = Excel.Workbook(File.Contents("C:\Users\Usuario\Desktop\ANALISIS DE DATOS\Clase 6\dataset_original.xlsx"), null, true),
  #"Navegación 1" = Origen{[Item = "dataset_original", Kind = "Sheet"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Navegación 1", {{"Column1", type text}}, "es"),
  #"Dividir columna por delimitador" = Table.SplitColumn(#"Tipo de columna cambiado", "Column1", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), {"Column1.1", "Column1.2", "Column1.3", "Column1.4", "Column1.5", "Column1.6", "Column1.7", "Column1.8", "Column1.9", "Column1.10", "Column1.11", "Column1.12", "Column1.13", "Column1.14", "Column1.15", "Column1.16", "Column1.17", "Column1.18", "Column1.19", "Column1.20", "Column1.21", "Column1.22", "Column1.23", "Column1.24"}),
  #"Tipo cambiado" = Table.TransformColumnTypes(#"Dividir columna por delimitador",{{"Column1.1", type text}, {"Column1.2", type text}, {"Column1.3", type text}, {"Column1.4", type text}, {"Column1.5", type text}, {"Column1.6", type text}, {"Column1.7", type text}, {"Column1.8", type text}, {"Column1.9", type text}, {"Column1.10", type text}, {"Column1.11", type text}, {"Column1.12", type text}, {"Column1.13", type text}, {"Column1.14", type text}, {"Column1.15", type text}, {"Column1.16", type text}, {"Column1.17", type text}, {"Column1.18", type text}, {"Column1.19", type text}, {"Column1.20", type text}, {"Column1.21", type text}, {"Column1.22", type text}, {"Column1.23", type text}, {"Column1.24", type text}}),
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Tipo cambiado", [PromoteAllScalars=true]),
  // Este paso ajusta los tipos de datos de todas las columnas principales
  #"MiTransformacionManual" = Table.TransformColumnTypes(#"Encabezados promovidos",{{"ID_Venta", Int64.Type}, {"Fecha", type date}, {"Dia", type text}, {"Mes", type text}, {"Año", type text}, {"Trimestre", type text}, {"Nombre_Producto", type text}, {"Categoria", type text}, {"Subcategoria", type text}, {"Marca", type text}, {"Precio_Unitario", Currency.Type}, {"Nombre_Cliente", type text}, {"Sexo", type text}, {"Edad", Int64.Type}, {"Ciudad_Cliente", type text}, {"Estado_Cliente", type text}, {"Nombre_Sucursal", type text}, {"Ciudad_Sucursal", type text}, {"Estado_Sucursal", type text}, {"Región", type text}, {"Cantidad_Vendida", Int64.Type}, {"Ingreso_Total", Int64.Type}, {"Costo_Total", Currency.Type}, {"Ganancia", type text}}),
  #"Duplicados quitados" = Table.Distinct(#"MiTransformacionManual", {"ID_Venta"}),
  #"Errores quitados" = Table.RemoveRowsWithErrors(#"Duplicados quitados", {"Fecha"}),
  #"Errores quitados1" = Table.RemoveRowsWithErrors(#"Errores quitados", {"Precio_Unitario"}),
  #"Errores quitados2" = Table.RemoveRowsWithErrors(#"Errores quitados1", {"Costo_Total"}),
  #"Columnas quitadas" = Table.RemoveColumns(#"Errores quitados2",{"Ganancia", "Dia", "Mes", "Año", "Trimestre"}),
  #"Valor reemplazado" = Table.ReplaceValue(#"Columnas quitadas",null,0,Replacer.ReplaceValue,{"Ingreso_Total"}),
  #"Columnas quitadas1" = Table.RemoveColumns(#"Valor reemplazado",{"Nombre_Cliente", "Sexo", "Edad", "Ciudad_Cliente", "Estado_Cliente"})
in
  #"Columnas quitadas1"


  Estructura let … in  
Entender esta estructura es fundamental porque organiza el flujo de transformaciones en pasos encadenados. Cada línea dentro del let representa una operación intermedia, y el in define cuál es el resultado final que se devuelve. Para un analista de datos, esto permite:

Depurar errores paso a paso.

Reutilizar lógica en otros proyectos.

Documentar el proceso ETL de manera transparente y reproducible.

Case Sensitive en M  
El lenguaje M distingue entre mayúsculas y minúsculas. Esto significa que Table.SelectRows es válido, pero table.selectrows genera error. La consecuencia práctica de ignorarlo es que la consulta se rompe y Power Query no puede ejecutar la transformación. Por eso, respetar la sintaxis exacta es crítico para evitar fallos.

Criterios de selección del dataset  
Se eligió un dataset público en formato CSV/Excel que cumple con las condiciones mínimas:

Más de 5 columnas con tipos variados (texto, número, fecha).

Presencia de valores nulos, duplicados y nombres técnicos.

Acceso confiable desde una fuente abierta.
Estos criterios aseguran que las transformaciones tengan sentido real y que el ejercicio sea útil para practicar limpieza y depuración de datos en un contexto realista.
