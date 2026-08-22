# NomIpe — Impuestos Pendientes

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Impuestos pendientes de pago. Registra las retenciones de ISR y otros impuestos calculados en nómina que están pendientes de ser remitidos a la autoridad fiscal.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 IPEANO         5      7      3   0    P   ANO APLICA EL IMPUESTO                    ANO_APLICA_IMPUESTO
 IPEIAE         8     14      7   2    P   IMPUESTO A FAVOR EMPLEADO                 IMPUESTO_FAVOR_EMPLEADO
 IPEBAE        15     21      7   2    P   BCE. IMPUESTO A FAVOR EMPL.               BCE_IMPUESTO_FAVOR_EMPLEADO
 IPEIAR        22     28      7   2    P   IMPUESTO A FAVOR DE LA RENTA              IMPUESTO_FAVOR_RENTA
 IPEBAR        29     35      7   2    P   BCE. IMPUESTO A FAVOR RENTA               BCE_IMPUESTO_FAVOR_RENTA
 IPECUO        36     42      7   2    P   CUOTA DEL IMPUESTO                        CUOTA_DEL_IMPUESTO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Control de ISR y retenciones pendientes de remisión a la DGII.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
