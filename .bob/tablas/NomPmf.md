# NomPmf — Préstamos y Deducciones Fijas

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Préstamos y deducciones fijas de empleados. Registra los préstamos otorgados y deducciones periódicas (préstamos, seguros, asociaciones, etc.) que se descuentan automáticamente en cada ciclo de nómina.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 PMFSEC         8      9      2   0    P   SECUENCIA TRANSACCION                     SECUENCIA_TRANS_PREST
 PMFANO        10     12      3   0    P   ANO CREACION DEDUCCION                    ANO_CREACION_DEDUCCION
 PMFMES        13     14      2   0    P   MES CREACION DEDUCCION                    MES_CREACION_DEDUCCION
 PMFDIA        15     16      2   0    P   DIA CREACION DEDUCCION                    DIA_CREACION_DEDUCCION
 PMFVAL        17     23      7   2    P   VALOR DE LA DEDUCCION                     VALOR_DEDUCCION
 PMFCUO        24     30      7   2    P   CUOTA DE LA DEDUCCION                     CUOTA_DEDUCCION
 PMFBCE        31     37      7   2    P   BALANCE DE LA DEDUCCION                   BALANCE_DEDUCCION
 PMFPER        38     38      1   0    P   PERIODICIDAD                              PERIODICIDAD_DEDUCCION
 PMFDRE        39     48     10        A   DOCUMENTO REFERENCIA                      DOCTO_REFER_DEDUCCION
 PMFAIN        49     51      3   0    P   ANO INICIO DEDUCCION                      ANO_INICIO_DEDUCCION
 PMFMIN        52     53      2   0    P   MES INICIO DEDUCCION                      MES_INICIO_DEDUCCION
 PMFDIN        54     55      2   0    P   DIA INICIO DEDUCCION                      DIA_INICIO_DEDUCCION
 PMFAFI        56     58      3   0    P   ANO FINAL DEDUCCION                       ANO_FINAL_DEDUCCION
 PMFMFI        59     60      2   0    P   MES FINAL DEDUCCION                       MES_FINAL_DEDUCCION
 PMFDFI        61     62      2   0    P   DIA FINAL DEDUCCION                       DIA_FINAL_DEDUCCION
 PMFSTA        63     63      1        A   STATUS DE LA DEDUCCION                    STATUS_DEDUCCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de deducción |

---

## Observaciones

- Deducciones fijas recurrentes en nómina; se procesan automáticamente en cada ciclo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
