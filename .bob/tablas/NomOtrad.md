# NomOtrad — Detalle Otras Transacciones Externas

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de otras transacciones externas de nómina. Contiene el desglose de cada transacción importada de sistemas externos por empleado y concepto.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 EMPCVE        10     13      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE        14     16      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 TRACAN        17     23      7   2    P   CANTIDAD DE LA TRANSACION                 CANTIDAD_TRANSACCION
 TRAVAL        24     30      7   2    P   VALOR DE LA TRANSACCION                   VALOR_TRANSACCION
 TRAIMP        31     37      7   2    P   IMPORTE TOTAL TRANSACCION                 IMPORTE_TRANSACCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta control + empleado + concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomOtrac | — | Control otras transacciones externas |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle de transacciones externas importadas; su control es `NomOtrac`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
