# CogIep — Programas a Ejecutar en Impresión

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de programas de impresión de estados financieros. Define los programas RPG o de reporte que se ejecutan para imprimir cada tipo de estado financiero.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 IEFCVE         1      2      2   0    P   NRO. DE GRUPO
 IEFSEC         3      6      4   2    P   ORDEN DE EJECUCION                        ORDEN_EJECUCION
 IEFTIT         7     46     40        A   TITULO DEL ESTADO                         TITULO_ESTADO
 IEFPGM        47     56     10        A   PROGRAMA EN EJECUCION                     PROGRAMA_EJECUTAR
 EFICVE        57     58      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 CTACVE        59     76     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 IEFANE        77     84      8        A   DESC. ANEXO                               DESC_ANEXO_ESTADO
 IEFEST        85     88      4        A   IDENTIFICACION ESTADO                     IDENTIFICACION_ESTADO
 IEFSTA        89     89      1        A   STATUS DE LA EJECUCION                    STATUS_EJECUCION
 IEFTIP        90     90      1        A   TIPO DE EJECUCION                         TIPO_DE_EJECUCION
 IEFSAP        91     92      2   0    P   SALTO DE PAGINA BEFORE


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de programa de impresión |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogIef | — | Grupo de impresión |
| — | CogIne | — | Índice de impresión de estados |

---

## Observaciones

- Define los programas ejecutables asociados a cada proceso de impresión de estados.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
