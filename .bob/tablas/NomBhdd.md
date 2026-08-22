# NomBhdd — Detalle Transferencia Nómina BHD

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de la transferencia de nómina al Banco BHD León. Contiene el registro individual de cada empleado con su número de cuenta y monto a acreditar.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BHDCTA         1     11     11        A   CUENTA BANCARIA ACREDITAR                 CUENTA_ACREDITAR
 BHDCEM        12     17      6        A   CODIGO EMPLEADO                           CODIGO_EMPLEADOS
 BHDFPG        18     25      8        A   FECHA DE PAGO                             FECHA_DE_PAGO
 BHDMPG        26     36     11        A   MONTO DEL PAGO                            MONTO_DEL_PAGO
 BHDNOM        37     71     35        A   NOMBRE DEL EMPLEADO                       NOMBRE_DEL_EMPLEADO_BHP

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBhdh | — | Cabecera transferencia BHD |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle de nómina BHD por empleado; su cabecera es `NomBhdh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
