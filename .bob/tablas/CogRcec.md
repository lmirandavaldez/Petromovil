# CogRcec — Relación Cuenta Tipo Cliente o Empleado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre cuentas contables y tipos de cliente o empleado. Mapea las cuentas del catálogo contable con los tipos de tercero (cliente, empleado, proveedor) para la generación del archivo 607 DGII.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CTACVE         1     18     18        A   CUENTA CONTABLE                           NUMERO_DE_CUENTA_CONTABLE
 RCETIP        19     19      1        A   TIPO DE DATOS                             TIPO_DE_DATOS_FACA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cuenta + tipo de tercero |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable |
| — | CogRced | — | Definitivo relación cliente/empleado |

---

## Observaciones

- Utilizada para la clasificación de cuentas por tipo de tercero en reportes fiscales.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
