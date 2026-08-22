# CogMge — Mayor General de Cuentas

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Mayor general de cuentas contables. Almacena los saldos acumulados por cuenta y período: saldo inicial, movimientos débito/crédito y saldo final.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AUXLIS         1      2      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CTACVE         3     20     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXCVE        21     24      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 PERANO        25     27      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        28     29      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 MGEBIP        30     38      9   2    P   SALDO INICIO DEL PERIODO                  SALDO_INICIO_PERIODO_MGE
 MGEDEB        39     47      9   2    P   DEBITOS DEL PERIODO                       TOTAL_DEBITO_MGE
 MGECRE        48     56      9   2    P   CREDITOS DEL PERIODO                      TOTAL_CREDITO_MGE
 MGEBAL        57     65      9   2    P   SALDO FINAL DEL PERIODO                   SALDO_FINAL_PERIODO_MGE
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable |
| — | CogPer | — | Período contable |

---

## Observaciones

- Tabla de saldos del mayor general; ver `CogBgd` para el detalle transaccional.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
