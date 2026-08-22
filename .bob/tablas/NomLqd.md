# NomLqd — Liquidación Detalle

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de liquidación de empleados. Contiene el cálculo detallado de cada concepto de la liquidación: auxilio de cesantía, preaviso, vacaciones, bonificación, etc.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 LQDSEC         8      9      2   0    P   SECUENCIA CONCEPTO                        SECUENCIA_CONCEPTO
 LQDTIE        10     12      3   2    P   TIEMPO                                    TIEMPO
 LQDTTI        13     13      1        A   TIPO DE TIEMPO                            TIPO_TIEMPO
 LQDPRO        14     14      1        A   PAGO PROPORCION                           PAOG_PROPORCION
 LQDVAL        15     21      7   2    P   VALOR                                     VALOR_CONCEPTO
 LQDVEX        22     28      7   2    P   VALOR EXENTO ISR                          VALOR_EXENTO_ISR_LIQUIDACION
 CMCCTC        29     46     18        A   CUENTA CONTABLE CONCEPTO                  CUENTA_CONTABLE_CONCEPTO
 CMCAXC        47     50      4   0    P   CLAVE AUXILIAR CONCEPTO                   CLAVE_AUXILIAR_CONCEPTO
 LQDORI        51     51      1        A   ORIGEN OPERACION                          ORIGEN_OPERACION
 RCFCVE        52     53      2   0    P   CODIGO LIQUIDACION                        CODIGO_LIQUIDACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomLqc | — | Cabecera de liquidación |
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Detalle del cálculo de liquidación por concepto; su cabecera es `NomLqc`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
