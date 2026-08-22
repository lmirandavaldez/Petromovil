# NomNge — Nómina General

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Nómina general activa. Contiene el resultado del cálculo de nómina de cada empleado por ciclo de pago: ingresos, deducciones y neto a pagar.

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
 NGEIOC        14     14      1   0    P   INGRESO O DESCUENTO                       INGRESO_DESCUENTO
 CMCCVE        15     17      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 NGESEC        18     19      2   0    P   SECUENCIA NOMINA GRAL                     SECUENCIA_NOMINA_GRAL
 NGEVAL        20     26      7   2    P   VALOR DE LA NOMINA GRAL                   VALOR_NOMINA_GRAL
 NGECAN        27     33      7   2    P   CANTIDAD DE LA NOMINA GRAL                CANTIDAD_NOMINA_GRAL
 NGEIMP        34     40      7   2    P   IMPORTE NOMINA GENERAL                    IMPORTE_NOMINA_GRAL
 NGEAPA        41     47      7   2    P   APORTE PATRONAL                           APORTE_PATRONAL_NOMINA_GRAL
 NGEISR        48     54      7   2    P   SALDO A FAVOR ISR O EMPL                  SALDO_FAVOR_ISR_O_EMPL
 NGEVEX        55     61      7   2    P   VALOR EXONERADO ISR                       VALOR_EXONERADO_ISR
 NGECCO        62     71     10        A   CLAVE DE CENTRO COSTOS                    CENTRO_COSTO_TRANSACCION
 NGECTA        72     89     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 NGEAUX        90     93      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta ciclo + empleado + concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de nómina |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Tabla central del resultado de nómina; ver `NomNgeh` para el histórico.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
