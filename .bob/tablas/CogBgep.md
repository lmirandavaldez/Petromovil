# CogBgep — Balance General del Período Fiscal

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Balance general acumulado del período fiscal completo. Consolida los saldos de todos los períodos dentro del año fiscal para el balance general anual.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CUENTA         1     35     35        A   CUENTA CONTABLE EDITADA                   CUENTA_CONTABLE_EDITADA
 CTACVE        36     53     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        54     55      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        56     59      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 BGEIDE        60     60      1        A   IDENTIFICACION TIPO CUENTA                IDENTIFICACION_TIPO_CUENTA
 CTADES        61    105     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 BGEP01       106    114      9   2    P   BALANCE PERIODO 01                        BALANCE_PERIODO_01
 BGEP02       115    123      9   2    P   BALANCE PERIODO 02                        BALANCE_PERIODO_02
 BGEP03       124    132      9   2    P   BALANCE PERIODO 03                        BALANCE_PERIODO_03
 BGEP04       133    141      9   2    P   BALANCE PERIODO 04                        BALANCE_PERIODO_04
 BGEP05       142    150      9   2    P   BALANCE PERIODO 05                        BALANCE_PERIODO_05
 BGEP06       151    159      9   2    P   BALANCE PERIODO 06                        BALANCE_PERIODO_06
 BGEP07       160    168      9   2    P   BALANCE PERIODO 07                        BALANCE_PERIODO_07
 BGEP08       169    177      9   2    P   BALANCE PERIODO 08                        BALANCE_PERIODO_08
 BGEP09       178    186      9   2    P   BALANCE PERIODO 09                        BALANCE_PERIODO_09
 BGEP10       187    195      9   2    P   BALANCE PERIODO 10                        BALANCE_PERIODO_10
 BGEP11       196    204      9   2    P   BALANCE PERIODO 11                        BALANCE_PERIODO_11
 BGEP12       205    213      9   2    P   BALANCE PERIODO 12                        BALANCE_PERIODO_12

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta año fiscal + cuenta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBge | — | Balance general por período |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Balance general a nivel del período fiscal anual; ver `CogBge` para balance mensual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
