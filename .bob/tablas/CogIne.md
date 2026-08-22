# CogIne — Índice Impresión Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Índice de impresión de estados financieros. Controla el orden y los parámetros de ejecución de los distintos reportes de estados financieros disponibles.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 IEFCVE         1      2      2   0    P   NRO. DE GRUPO
 INEPAG         3      5      3   0    P   NUMERO DE PAGINA
 IEFTIT         6     45     40        A   TITULO DEL ESTADO                         TITULO_ESTADO
 IEFANE        46     53      8        A   DESC. ANEXO                               DESC_ANEXO_ESTADO
 IEFEST        54     57      4        A   IDENTIFICACION ESTADO                     IDENTIFICACION_ESTADO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — índice de impresión |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogIef | — | Grupo de impresión |
| — | CogIep | — | Programas de impresión |

---

## Observaciones

- Índice de control para la secuencia de impresión de estados financieros.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
