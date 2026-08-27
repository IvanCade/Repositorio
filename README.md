1. ¿Qué hace exactamente el bloque let...in en lenguaje M?
El bloque let...in define una secuencia de pasos. Cada paso genera una tabla intermedia que puede ser referenciada por el siguiente. El in indica cuál es el resultado final que se devuelve a Power Query. Esto permite construir transformaciones encadenadas y reutilizar resultados previos sin recalcular todo desde cero.

2. ¿Por qué M es Case Sensitive y qué consecuencia práctica tiene?
M distingue entre mayúsculas y minúsculas en nombres de funciones y variables.
Ejemplo: Table.TransformColumns funciona, pero table.transformcolumns genera error porque la función no existe con esa escritura. La consecuencia práctica es que cualquier error de capitalización rompe el script.

3. Diferencia entre usar Text.Trim y Text.Clean en M
Text.Trim elimina espacios en blanco al inicio y al final de un texto.

Text.Clean elimina caracteres no imprimibles (ej. saltos de línea ocultos, tabulaciones).
En este ejercicio usamos Text.Trim porque el problema eran espacios visibles, no caracteres invisibles.

4. ¿Por qué filtraste los registros "PRUEBA" después de estandarizar la categoría y no antes?
Porque M es Case Sensitive: si filtramos antes, solo eliminaríamos exactamente "PRUEBA". Los valores "prueba" o "Prueba" quedarían sin filtrar. Al estandarizar primero con Text.Proper, todos los registros se convierten en "Prueba", lo que asegura que el filtro sea efectivo y consistente.
