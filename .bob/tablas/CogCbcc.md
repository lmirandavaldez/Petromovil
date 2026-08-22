# CogCbcc — Balance Centro Costos Consolidado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Balance consolidado por centro de costos. Presenta los saldos consolidados de múltiples compañías o períodos agrupados por centro de costo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   NRO. COMPANIA                             CODIGO_DE_COMPANIA
 CCOCVE         3     12     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CTACVE        13     30     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        31     32      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        33     36      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 BCCMPA        37     45      9   2    P   MOVIMIENTOS PERIODO ACTUAL                MOVIMIENTOS_PERIODO_ACTUAL_CC
 BCCBPA        46     54      9   2    P   BALANCE PERIODO ACTUAL                    BALANCE_PERIODO_ACTUAL_CC
 BCCMPN        55     63      9   2    P   MOVIMIENTOS PERIODO ANTERIOR              MOV_PERIODO_ANTERIOR_CC
 BCCBPN        64     72      9   2    P   BALANCE PERIODO ANTERIOR                  BALANCE_PERIODO_ANTERIOR_CC
 BCCMAA        73     81      9   2    P   MOVIMIENTOS ANO ANTERIOR                  MOVIMIENTOS_ANO_ANTERIOR_CC
 BCCBAA        82     90      9   2    P   BALANCE ANO ANTERIOR                      BALANCE_ANO_ANTERIOR_CC
 BCCMAN        91     99      9   2    P   MOVIMIENTOS ANT ANO ANTERIOR              MOV_ANT_ANO_ANTERIOR_CC
 BCCBAN       100    108      9   2    P   BALANCE ANT RANO ANTERIOR                 BALANCE_ANT_ANO_ANTERIOR_CC


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta + centro de costo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBcc | — | Balance por centro de costos |
| — | CogCco | — | Centro de costos |

---

## Observaciones

- Versión consolidada de `CogBcc` para reportes multicompañía.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
