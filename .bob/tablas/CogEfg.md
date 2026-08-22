# CogEfg — Grupos de Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Grupos de estados financieros. Define los grupos o secciones que componen la estructura de presentación de los estados financieros (activos, pasivos, ingresos, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EFICVE         1      2      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 EFGCVE         3      4      2   0    P   GRUPO DE ESTADO                           GRUPO_DE_ESTADO
 EFGDES         5     44     40        A   DESCRIPCION                               DESCRIPCION_DEL_GRUPO_ESTADO
 EFTCVE        45     46      2   0    P   NRO. DEL TOTAL                            NUMERO_DEL_TOTAL_ESTADO
 EFTNUM        47     48      2   0    P   NRO. DEL SEGUNDO TOTAL                    NUMERO_SEGUNDO_TOTAL_ESTADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de grupo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEfi | — | Títulos del estado financiero |
| — | CogEfd | — | Detalle del estado financiero |

---

## Observaciones

- Define la estructura de agrupación de los estados financieros.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
