# NomBpdo — Detalle Anexo Pago Empleados BPD

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle anexo del pago a empleados BPD. Contiene información complementaria o adicional de cada empleado en la transferencia de nómina al Banco Popular Dominicano.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SROTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO_ANEXO
 SROIDC         2     16     15        A   ID COMPANIA RNC                           ID_DE_COMPANIA_RNC
 SROSHD        17     23      7        A   SECUENCIA_OPC                             SECUENCIA_OPC
 SROSEC        24     30      7        A   SECUENCIA DETALLE                         SECUENCIA_DETALLE_OPC
 SRONCT        31     50     20        A   CUENTA DESTINO                            CUENTA_DESTINO_ANEXO
 SRONDO        51     65     15        A   NUMERO DE DOCUMENTO                       NUMERO_DE_DOCUMENTO
 SROTDC        66     67      2        A   TIPO DE DOCUMENTO                         TIPO_DE_DOCUMENTO
 SROFDO        68     75      8   0    S   FECHA DE DOCUMENTO                        FECHA_DE_DOCUMENTO
 SROMDO        76     88     13   2    S   MONTO DEL DOCUMENTO                       MONTO_DEL_DOCUMENTO
 SROMDE        89     99     11   2    S   MONTO DEL DESCUENTO                       MONTO_DEL_DESCUENTO
 SROIMP       100    110     11   2    S   MONTO DEL IMPUESTO                        MONTO_DEL_IMPUESTO
 SROMND       111    123     13   2    S   MONTO NETO DOCUMENTO                      MONTO_NETO_DOCUMENTO
 SRODDO       124    173     50        A   DESCRIPCION DOCUMENTO                     DESCRIPCION_DOCUMENTO
 SROFIL       174    319    146        A   ESPACIOS EN BLANCO                        ESPACIOS_EN_BLANCO_ANEXO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta encabezado + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBpdh | — | Encabezado BPD |
| — | NomBpdd | — | Detalle BPD |

---

## Observaciones

- Información adicional de pago BPD por empleado; complementa `NomBpdd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
