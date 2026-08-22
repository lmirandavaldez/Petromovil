# CogBcc — Balance por Centro de Costos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Balance contable desglosado por centro de costos. Almacena los saldos de cada cuenta agrupados por centro de costo para análisis de rentabilidad por área.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CCOCVE         1     10     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CTACVE        11     28     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        29     30      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        31     34      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 PERANO        35     37      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        38     39      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 BCCBIP        40     48      9   2    P   SALDO INICIO DEL PERIODO                  SALDO_INICIO_PERIODO_BCC
 BCCDEB        49     57      9   2    P   DEBITO                                    TOTAL_DEBITO_BCC
 BCCCRE        58     66      9   2    P   CREDITO                                   TOTAL_CREDITO_BCC
 BCCBAL        67     75      9   2    P   SALDO FINAL DEL PERIODO                   SALDO_FINAL_PERIODO_BCC
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta + centro de costo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCco | — | Centro de costos |
| — | CogCta | — | Cuenta contable |
| — | CogPer | — | Período contable |

---

## Observaciones

- Tabla de balance por dimensión de centro de costo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
