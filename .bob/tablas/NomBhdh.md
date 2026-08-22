# NomBhdh — Cabecera Transferencia Nómina BHD

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera de la transferencia de nómina al Banco BHD León. Registra los datos generales del lote de pago: empresa, período, fecha valor y monto total.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BHDCTD         1     11     11        A   CUENTA BANCARIA A DEBITAR                 CUENTA_A_DEBITAR
 BHDCAE        12     17      6        A   CANTIDAD EMPLEADOS                        CANTIDAD_EMPLEADOS
 BHDFPG        18     25      8        A   FECHA DE PAGO                             FECHA_DE_PAGO
 BHDMON        26     36     11        A   MONTO TOTAL                               MONTO_TOTAL_NOMINA
 BHDDES        37     71     35        A   DESCRIPCION DEL PAGO                      DESCRIPCION_DEL_PAGO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de lote |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBhdd | — | Detalle transferencia BHD |

---

## Observaciones

- Cabecera del lote de pago BHD; su detalle es `NomBhdd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
