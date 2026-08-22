# CogEftd — Detalle de Totales por Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de los totales calculados por estado financiero. Almacena los totales por línea o sección de cada estado financiero para la impresión y presentación de reportes.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EFICVE         1      2      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 EFTCVE         3      4      2   0    P   NRO. DEL TOTAL                            NUMERO_DEL_TOTAL_ESTADO
 EFGCVE         5      6      2   0    P   GRUPO DE ESTADO                           GRUPO_DE_ESTADO
 EFTSIM         7      7      1        A   SIGNO DE OPERACION                        SIGNO_DE_OPERACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEfth | — | Cabecera de totales por estados |
| — | CogEfi | — | Estado financiero |

---

## Observaciones

- Detalle de totales del estado financiero; su cabecera es `CogEfth`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
