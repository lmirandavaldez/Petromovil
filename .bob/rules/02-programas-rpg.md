# Reglas para Programas RPG

> **Referencia de tablas:** La documentación del diseño de tablas del proyecto se
> encuentra en `.bob/tablas/`. Consultar esos archivos para conocer campos, tipos,
> claves y relaciones antes de modificar o crear programas RPG.


Estas reglas aplican **siempre** cuando se analicen, modifiquen o creen programas RPG (RPGLE, SQLRPGLE, etc.) en este proyecto.

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

### 2b. Caracteres decorativos en comentarios RPG (Fixed-Format)
Estos caracteres al inicio del texto del comentario (después del `*` en columna 7) otorgan **alta intensidad y/o color** en el SEU / RDi. No deben eliminarse, reemplazarse ni desplazarse de posición:

| Patrón       | Ubicación             | Efecto visual               |
|--------------|-----------------------|-----------------------------|
| `*==...==*`  | Col 7, línea completa | Línea de bloque — alta intensidad |
| `**texto`    | Col 7                 | Título de sección — alta intensidad / color |
| `*-...---*`  | Col 7                 | Línea separadora            |

### 2c. Caracteres decorativos en comentarios RPG (Free-Format)
Estos patrones en comentarios `//' de formato libre también tienen rol decorativo visual:

| Patrón              | Efecto visual                        |
|---------------------|--------------------------------------|
| `//*` + guiones     | Separador decorativo de sección      |
| `//----`            | Línea divisoria horizontal           |
| `//` desplazado a la derecha (inline) | Etiqueta flotante al final de línea |

### 2d. Caracteres decorativos en comentarios CL
En programas CL (`.clle`, `.clp`) los bloques de comentario `/* */` pueden usar prefijos especiales:

| Patrón   | Efecto visual                              |
|----------|--------------------------------------------|
| `/**`    | Comentario de alta intensidad / color      |
| `/*====` | Separador de bloque decorativo             |

> **Regla general:** Si un comentario comienza con un carácter que no sea una letra o espacio (p. ej. `*`, `=`, `-`, `**`, `/**`, `//*`), conservarlo íntegro sin ninguna alteración.

## 3. Mantener lógica original y orden de campos
- No reorganizar, reordenar ni eliminar campos, estructuras de datos, indicadores ni subrutinas existentes a menos que el usuario lo solicite explícitamente.
- La lógica de negocio original debe preservarse íntegramente.
- El orden de las especificaciones (H, F, D, I, C, O/P) debe respetarse.

## 4. Historial de cambios
En la sección de historial de cambios del programa, registrar siempre la fecha del día en formato:
```
dd-mm-yyyy
```
Nunca usar otro formato de fecha (no usar yyyy-mm-dd, mm/dd/yyyy, etc.).

## 5. Estándar DB2: reemplazar IFNULL por COALESCE
En los bloques SQL embebidos dentro del programa RPG, sustituir toda ocurrencia de `IFNULL(expr, valor)` por `COALESCE(expr, valor)` como estándar de DB2 for i.

## 6. Documentar
Todo programa modificado o creado debe incluir:
- Descripción del propósito del programa al inicio.
- Descripción de los parámetros de entrada y salida (si aplica).
- Comentarios en secciones de lógica compleja o poco obvia.
- Registro en el historial de cambios con fecha (regla 4).

## 7. Analizar y sugerir mejoras
Al finalizar cada análisis o modificación, incluir una sección de **sugerencias de mejora** que identifique:
- Operaciones obsoletas o sustituibles por equivalentes modernos en Free-Format RPG.
- SQL embebido que pueda optimizarse.
- Código redundante o simplificable.
- Riesgos de integridad de datos o flujos de error no controlados.
Las sugerencias son informativas; no se aplican sin aprobación explícita del usuario.
