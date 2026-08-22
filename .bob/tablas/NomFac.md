# NomFac — Transferencias de Factura CXC

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Transferencias de factura a cuentas por cobrar. Registra las facturas y descuentos de empleados que se transfieren al módulo de cuentas por cobrar para su gestión.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 FACVAL         5     11      7   2    P   VALOR DE LA FACTURA                       VALOR_FACTURA
 FACDOC        12     21     10        A   DOCUMENTO REFERENCIA                      DOCTO_REFER_DEDUCCION
 FACAFA        22     24      3   0    P   ANO FACTURA                               ANO_FACTURA
 FACMFA        25     26      2   0    P   MES FACTURA                               MES_FACTURA
 FACDFA        27     28      2   0    P   DIA FACTURA                               DIA_FACTURA
 FACDGR        29     30      2   0    P   DIAS DE GRACIA                            DIAS_GRACIA
 FACSTA        31     31      1        A   STATUS FACTURA                            STATUS_DEDUCCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Integración nómina-CXC para descuentos de empleados facturados.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
