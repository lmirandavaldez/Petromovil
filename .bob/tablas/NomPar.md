# NomPar — Parámetros Generales

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Parámetros generales del módulo de nómina. Almacena la configuración operativa del módulo por compañía: cuentas contables, tasas, límites y opciones de procesamiento.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PARCVE         1      1      1        A   CLAVE DE PARMETROS                        CLAVE_DE_PARAMETRO
 PARCIF         2      4      3   0    P   CONCEPTO INFOTEP                          CODIGO_CONCEPTO_INFOTEP
 PARCSS         5      7      3   0    P   CONCEPTO ISS                              CODIGO_CONCEPTO_ISS
 PARCO1         8     10      3   0    P   CONCEPTO 1                                CODIGO_CONCEPTO_1
 PARCO2        11     13      3   0    P   CONCEPTO 2                                CODIGO_CONCEPTO_2
 PARCO3        14     16      3   0    P   CONCEPTO 3                                CODIGO_CONCEPTO_3
 PARCO4        17     19      3   0    P   CONCEPTO 4                                CODIGO_CONCEPTO_4
 PARCO5        20     22      3   0    P   CONCEPTO 5                                CODIGO_CONCEPTO_5
 PARCO6        23     25      3   0    P   CONCEPTO 6                                CODIGO_CONCEPTO_6
 PARVEX        26     32      7   2    P   VALOR EXENTO ISR                          VALOR_EXENTO_ISR
 PARPMD        33     35      3   2    P   PORC. MAXIMO DESCUENTO EMPL.              PORC_MAXIMO_DESCUENTO
 PARVSS        36     42      7   2    P   VALOR ULTIMA CATEGORIA ISS                VALOR_ULTIMA_CATEGORIA_ISS
 PARPES        43     45      3   2    P   PORCIENTO EMPLEADO ISS                    PORC_EMPLEADO_ISS
 PARPPS        46     48      3   2    P   PORCIENTO PATRONO ISS                     PORC_PATRONO_ISS
 PARPIN        49     51      3   2    P   PORCIENTO INFOTEP EN NOMINA               PORC_INFOTEP_NOMINA
 PARCAU        52     52      1        A   CONTABILIZACION AUTOMATICA                CONTABILIZACION_AUTOMATICA
 PARMPL        53     53      1        A   MANEJA PLANTA DE PRODUCCION               MANEJA_PLANTA_PRODUCCION
 PARFAP        54     54      1        A   FOLIADOR POR PLANTA PRODUCC.              FOLIADOR_POR_PLANTA
 PARFAU        55     55      1        A   FOLIADOR AUTOMATICO NORMAL                FOLIADOR_NORMAL
 PARTEL        56     75     20        A   TELEFONO EMPRESA                          TELEFONO_EMPRESA
 PARISP        76     90     15        A   NRO. INSCRIPCION SEG. SOC                 NRO_INSCRIPCION_SEG_SOC
 PARCAT        91     92      2   0    P   CATEGORIA DECRETO 76-99                   CATEGORIA_DECRETO_7699
 PARSMM        93     99      7   2    P   SALARIO MINIMO MENSUAL                    SALARIO_MINIMO_MENSUAL
 PARCSM       100    101      2   0    P   CANT. SALARIO MINIMO TOPE                 CANT_SALARIO_MINIMO_TOPE
 PARPCA       102    104      3   2    P   PORCIENTO APLICA CATEGORIA                PORC_APLICA_CATEGORIA
 PARPOL       105    119     15        A   NRO POLIZA ACCIDENTE TRABAJO              NRO_POLIZA_ACCIDENTE_TRABAJO
 PARCPR       120    122      3   0    P   CONCEPTO PROVISION REGALIA                CONCEPTO_PROVISION_REGALIA
 PARECI       123    123      1        A   LA EMPRESA PAGA ISR REGALIA               EMPRESA_PAGA_REGALIA
 PARPRP       124    124      1        A   HACER PROVISION REGALIA PASC              HACER_PROVISION_REGALIA
 PARPVA       125    125      1        A   HACER PROVISION VACACIONES                HACER_PROVISION_VACACIONES
 PARPBO       126    126      1        A   HACER PROVISION BONOS                     HACER_PROVISION_BONOS
 PARPPR       127    127      1        A   HACER PROVISION PRESTACIONES              HACER_PROVISION_PRESTACIONES
 PARTRE       128    128      1   0    P   TIPO DE REGALIA PASCUAL                   TIPO_DE_REGALIA
 PARCTI       129    131      3        A   CODIGO TABLA IMPUESTO                     CODIGO_TABLA_ISR
 PARTBO       132    132      1   0    P   TIPO DE BONIFICACION                      TIPO_DE_BONIFICACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía |

---

## Observaciones

- Tabla de configuración central del módulo NOM por compañía.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
