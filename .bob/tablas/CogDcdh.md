# CogDcdh — Cabecera Distribución Contable Pre-Definida

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de las distribuciones contables pre-definidas. Define las plantillas de asientos contables reutilizables para agilizar el registro de operaciones recurrentes.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DCDCVE         1      3      3   0    P   CODIGO DISTRIBUCION CONTABLE              CODIGO_DISTRIBUCION_CONTABLE
 DGEDES         4     43     40        A   DESCRIPCION                               DESCRIPCION_DE_LA_TRANSACCION
 SITCVE        44     44      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de distribución |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDcdd | — | Detalles de la distribución |

---

## Observaciones

- Cabecera de plantillas de distribución contable; su detalle es `CogDcdd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
