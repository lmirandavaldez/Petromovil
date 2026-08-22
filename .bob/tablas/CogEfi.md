# CogEfi — Títulos de Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de títulos de estados financieros. Define los estados financieros disponibles en el sistema (balance general, estado de resultados, flujo de caja, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EFICVE         1      2      2   0    P   NRO. DE ESTADO                            NUMERO_DE_ESTADO
 EFIDES         3     52     50        A   DESCRIPCION O TITULO                      DESCRIPCION_O_TITULO_ESTADO
 EFIORI        53     53      1   0    P   ORIGEN DE LOS SALDOS                      ORIGEN_DE_LOS_SALDOS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de estado financiero |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEfd | — | Detalle del estado financiero |
| — | CogEfg | — | Grupos del estado |
| — | CogRue | — | Usuarios con acceso al estado |

---

## Observaciones

- Catálogo maestro de estados financieros configurados en el sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
