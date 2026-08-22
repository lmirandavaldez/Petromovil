# NomAcad — Acumulado Concepto Mensual

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Acumulado mensual por concepto de nómina. Detalla los montos acumulados de cada concepto de nómina (salario, bonificación, deducciones, etc.) en el mes en curso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 CMCCVE         3      5      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 ACAANO         6      8      3   0    P   ANO ACUMULADO POR CONCEPTO                ANO_ACUM_POR_CONCEPTO
 ACAMES         9     10      2   0    P   MES CONCEPTO                              MES_CONCEPTO
 ACACAD        11     17      7   2    P   CANTIDAD MENSUAL CONCEPTO                 CANT_MENSUAL_CONCEPTO
 ACAIMD        18     24      7   2    P   IMPORTE MENSUAL CONCEPTO                  IMPORTE_MENSUAL_CONCEPTO
 ACAAPD        25     31      7   2    P   APORTE PATRONO MENSUAL CONC.              APORTE_PATRONO_MENSUAL_CONC
 ACAISD        32     38      7   2    P   SALDO A FAVOR/EN CONTRA EMPL              SALDO_MENS_FAVOR_CONTRA_EMPL
 ACAVED        39     45      7   2    P   VALOR EXONERADO ISR ANUAL                 VALOR_EXONERADO_MENS_ISR_CONC

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto + período mensual |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Acumulado mensual de conceptos; ver `NomAcah` para el acumulado anual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
