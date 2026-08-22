# CogEfth — Cabecera de Totales por Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de totales por estado financiero. Registra los datos generales del período de cálculo de totales de cada estado financiero generado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EFICVE         1      2      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 EFTCVE         3      4      2   0    P   NRO. DEL TOTAL                            NUMERO_DEL_TOTAL_ESTADO
 EFTDES         5     54     50        A   DESCRIPCION                               DESCRIPCION_DEL_TOTAL_ESTADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — estado financiero + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEftd | — | Detalles de totales |
| — | CogEfi | — | Estado financiero |
| — | CogPer | — | Período contable |

---

## Observaciones

- Cabecera de los totales generados por período para cada estado financiero.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
