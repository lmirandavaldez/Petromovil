# CogBge — Balance General de un Período

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Balance general de un período contable. Almacena los saldos de activos, pasivos y patrimonio para la generación del balance general de un período específico.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CUENTA         1     35     35        A   CUENTA CONTABLE EDITADA                   CUENTA_CONTABLE_EDITADA
 AUXCVE        36     39      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 BGEIDE        40     40      1        A   IDENTIFICACION TIPO CUENTA                IDENTIFICACION_TIPO_CUENTA
 CTADES        41     85     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 BGEANT        86     94      9   2    P   BALANCE PERIODO ANTERIOR                  BALANCE_PERIODO_ANTERIOR
 BGEDEB        95    103      9   2    P   DEBITOS DEL PERIODO                       DEBITOS_DEL_PERIODO_BGE
 BGECRE       104    112      9   2    P   CREDITOS DEL PERIODO                      CREDITOS_DEL_PERIODO_BGE
 BGEBAL       113    121      9   2    P   SALDO DEL PERIODO                         SALDO_DEL_PERIODO_BGE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPer | — | Período contable |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Balance general por período; ver `CogBgep` para balance del período fiscal completo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
