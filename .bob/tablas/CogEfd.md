# CogEfd — Detalle de Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de definición de estados financieros. Especifica las líneas y cuentas que componen cada estado financiero configurado en el sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EFICVE         1      2      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 EFGCVE         3      4      2   0    P   GRUPO DE ESTADO                           GRUPO_DE_ESTADO
 EFDCVE         5      7      3   0    P   NRO. DETALLE                              NUMERO_SEC_DETALLE_ESTADO
 EFDDES         8     47     40        A   DESCRIPCION                               DESCRIPCION_DETALLE_ESTADO
 CTACVE        48     65     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CCOCVE        66     75     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 AUXCVE        76     79      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 EFDCSA        80     80      1        A   CONVERSION DE SALDOS                      CONVERSION_DE_SALDOS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta estado + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEfi | — | Títulos del estado financiero |
| — | CogEfg | — | Grupos del estado financiero |

---

## Observaciones

- Detalle de la estructura del estado financiero; ver `CogCefd` para la versión con cuentas.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
