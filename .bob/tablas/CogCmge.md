# CogCmge — Mayor General Consolidado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Mayor general consolidado de múltiples compañías. Presenta los saldos del mayor general agrupando los movimientos de todas las compañías del grupo empresarial.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   NRO. COMPANIA                             CODIGO_DE_COMPANIA
 CTACVE         3     20     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        21     22      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        23     26      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 MGEMPA        27     35      9   2    P   MOVIMIENTOS PERIODO ACTUAL                MOVIMIENTOS_PERIODO_ACTUAL
 MGEBPA        36     44      9   2    P   BALANCE PERIODO ACTUAL                    BALANCE_PERIODO_ACTUAL
 MGEMPN        45     53      9   2    P   MOVIMIENTOS PERIODO ANTERIOR              MOVIMIENTOS_PERIODO_ANTERIOR
 MGEBPN        54     62      9   2    P   BALANCE PERIODO ANTERIOR                  BALANCE_PERIODO_ANTERIOR_MGE
 MGEMAA        63     71      9   2    P   MOVIMIENTOS ANO ANTERIOR                  MOVIMIENTOS_A_ANO_ANTERIOR
 MGEBAA        72     80      9   2    P   BALANCE ANO ANTERIOR                      BALANCE_A_ANO_ANTERIOR
 MGEMAN        81     89      9   2    P   MOVIMIENTOS ANT ANO ANTERIOR              MOVIMIENTOS_ANT_ANO_ANTERIOR
 MGEBAN        90     98      9   2    P   BALANCE ANT ANO ANTERIOR                  BALANCE_ANT_ANO_ANTERIOR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta consolidada |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogMge | — | Mayor general individual |
| — | CogCcta | — | Catálogo de cuentas consolidado |

---

## Observaciones

- Mayor general para consolidación multicompañía; ver `CogMge` para el individual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
