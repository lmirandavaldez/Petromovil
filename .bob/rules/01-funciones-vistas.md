# Reglas para Funciones y Vistas SQL

> **Referencia de tablas:** La documentación del diseño de tablas del proyecto se
> encuentra en `.bob/tablas/`. Consultar esos archivos para conocer campos, tipos,
> claves y relaciones antes de modificar o crear vistas y funciones.


Estas reglas aplican **siempre** cuando se analicen, modifiquen o creen funciones o vistas SQL en este proyecto.

---

## 1. Control de versiones local
Antes de aplicar cualquier cambio, crear una copia del archivo original en el mismo repositorio local con el nombre:
```
<nombre_archivo>_b1, <nombre_archivo>_b2, ...
```
La secuencia `x` debe ser correlativa según las versiones ya existentes para ese archivo.

## 2. Respetar caracteres especiales en comentarios
No alterar, escapar ni reemplazar ningún carácter especial que exista dentro de los comentarios del código. Deben conservarse exactamente tal como están.

### 2a. Caracteres de idioma (acentos y diacríticos)
Conservar sin modificación: `ñ`, `á`, `é`, `í`, `ó`, `ú`, `Á`, `É`, `Í`, `Ó`, `Ú`, `Ñ`, `ü`, `¿`, `¡`, y cualquier otro carácter acentuado o especial del español u otros idiomas.

### 2b. Caracteres decorativos en comentarios SQL
En funciones y vistas SQL los comentarios comienzan con `--`. Algunos usan prefijos decorativos que otorgan **alta intensidad y/o color** en el editor. No deben eliminarse ni modificarse:

| Patrón          | Ejemplo                         | Efecto visual              |
|-----------------|---------------------------------|----------------------------|
| `-- ==...==`    | `-- ============================` | Separador de bloque        |
| `-- --...--`    | `-- ----------------------------` | Línea divisoria            |
| `--**`          | `--** Sección importante`       | Alta intensidad / color    |
| `--/*`          | `--/** Nota especial`           | Alta intensidad / color    |

### 2c. Caracteres decorativos en comentarios RPG embebido (si aplica)
Si la función o vista convive con código RPG que contiene bloques de comentario decorativo, aplicar también las mismas reglas del archivo `02-programas-rpg.md` (regla 2b y 2c).

> **Regla general:** Si un comentario comienza con un carácter que no sea una letra o espacio (p. ej. `=`, `-`, `**`, `/**`), conservarlo íntegro sin ninguna alteración.

## 3. Mantener lógica original y orden de campos
- No reorganizar, reordenar ni eliminar campos existentes a menos que el usuario lo solicite explícitamente.
- La lógica de negocio original debe preservarse íntegramente.
- Cualquier mejora debe ser additiva o sustitutiva con equivalencia funcional demostrable.

## 4. Historial de cambios
En la sección de historial de cambios del objeto, registrar siempre la fecha del día en formato:
```
dd-mm-yyyy
```
Nunca usar otro formato de fecha (no usar yyyy-mm-dd, mm/dd/yyyy, etc.).

## 5. Estándar DB2: reemplazar IFNULL por COALESCE
Sustituir toda ocurrencia de `IFNULL(expr, valor)` por `COALESCE(expr, valor)` como estándar de DB2 for i.

## 6. Fechas concatenadas → LEFT JOIN a SEGFEC
Si dentro de la función o vista se están concatenando campos (año, mes, día o similares) para formar una fecha, hacer un `LEFT JOIN` a la tabla `SEGFEC` usando esa fecha construida.
- Si la fecha **existe** en `SEGFEC`, usar el valor real.
- Si la fecha **no existe** en `SEGFEC`, colocar por defecto `'1900-01-01'`.

Ejemplo de patrón:
```sql
LEFT JOIN SEGFEC SF
       ON SF.FECHA = (campo_año || campo_mes || campo_dia)
-- Resultado:
COALESCE(SF.FECHA, DATE('1900-01-01'))
```

## 7. Documentar
Todo objeto modificado o creado debe incluir:
- Descripción del propósito del objeto.
- Descripción de cada parámetro (en funciones).
- Comentarios en secciones de lógica compleja.
- Registro en el historial de cambios con fecha (regla 4).

## 8. Analizar y sugerir mejoras
Al finalizar cada análisis o modificación, incluir una sección de **sugerencias de mejora** que identifique:
- Posibles optimizaciones de rendimiento (índices, joins innecesarios, subqueries sustituibles).
- Código redundante o simplificable.
- Riesgos de calidad de datos.
Las sugerencias son informativas; no se aplican sin aprobación explícita del usuario.
