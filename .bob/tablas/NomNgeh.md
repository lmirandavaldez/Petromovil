# NomNgeh — Histórico de movimientos de nómina

**Biblioteca:** DATOS02  
**Tipo:** Tabla física  
**Módulo:** (completar)  
**Descripción:** (completar)

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
 CIPAAC        62     64      3   0    P   ANO QUE ACUMULAR                          ANO_QUE_ACUMULA
 CIPMAC        65     66      2   0    P   MES QUE ACUMULA                           MES_QUE_ACUMULA
 NGECCO        67     76     10        A   CLAVE DE CENTRO COSTOS                    CENTRO_COSTO_TRANSACCION
 NGECTA        77     94     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 NGEAUX        95     98      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | (campo) | Clave principal |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| (completar) | | | |

---

## Observaciones

(Completar con comportamientos especiales, reglas de negocio o advertencias.)

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
