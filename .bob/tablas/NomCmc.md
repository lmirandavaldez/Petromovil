# NomCmc — Centros de costo de nómina

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
 CMCCVE         1      3      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 CMCDES         4     33     30        A   DESCRIPCION                               DESCRIPCION_CONCEPTO
 CMCDCO        34     43     10        A   DESCR. CORTA                              DESC_CORTA_CONCEPTO
 CMCTIE        44     44      1        A   UNIDAD DE TIEMPO                          UNIDAD_DE_TIEMPO
 CMCTIP        45     45      1   0    P   TIPO DE CONCEPTO                          TIPO_CONCEPTO
 CMCCLA        46     46      1   0    P   CLASIFICACION                             CLASIFICACION_CONCEPTO
 CMCFDC        47     53      7   2    P   FACTOR DE CONVERSION                      FACTOR_CONVERSION
 CMCIMP        54     60      7   2    P   IMPORTE FIJO                              IMPORTE_FIJO
 CMCUND        61     64      4   2    P   TIEMPO DEL CONCEPTO                       TIEMPO_HORA
 CMCMCC        65     65      1        A   MANEJA CANTIDAD DESTAJO                   MANEJA_CANTIDAD_DESTAJO
 CMCCCO        66     66      1        A   MANEJA DETALLE C. COSTOS                  MANEJA_DETALLE_CENTRO_COSTO
 CMCISR        67     67      1        A   APLICA IMPUESTOS                          APLICA_IMPUESTOS
 CMCOTR        68     68      1        A   APLICA OTROS                              APLICA_OTROS
 CMCVOC        69     69      1   0    P   CODIGO PARA DIGITAR TRANSAC.              DIGITAR_TRANSACCION
 CTACVE        70     87     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 AUXCVE        88     91      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CMCCGE        92    101     10        A   C. COSTO GASTO EMPLEADO                   CENTRO_COSTOS_GASTO_EMPLEADO
 CMCCGA       102    119     18        A   CUENTA GASTOS APORTE PATRON               CUENTA_GASTOS_APORTE_PATRON
 CMCAGA       120    123      4   0    P   AUXIL. GASTOS APORTE PATRON               AUXILIAR_GASTOS_APORTE_PATRON
 CMCCGP       124    133     10        A   C. COSTO GASTO PATRONAL                   CENTRO_COSTOS_GASTO_PATRON
 CMCSN1       134    134      1        A   CONCEPTO BASE                             APLICA_SN1
 CMCSN2       135    135      1        A   APLICA OTROS PATRONO                      APLICA_SN2
 CMCSN3       136    136      1        A   APLICA AFP, ARS                           APLICA_SN3
 CMCSN4       137    137      1        A   APLICA S/N LIQUIDACION                    APLICA_SN4
 CMCSN5       138    138      1        A   APLICA S/N 5                              APLICA_SN5
 CMCSN6       139    139      1        A   APLICA S/N 6                              APLICA_SN6
 CMCSN7       140    140      1        A   APLICA S/N 7                              APLICA_SN7
 CMCSN8       141    141      1        A   APLICA S/N 8                              APLICA_SN8
 CMCSTA       142    142      1        A   STATUS                                    STATUS_CONCEPTO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK   | CMCCVE | CODIGO DE CONCEPTO


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
