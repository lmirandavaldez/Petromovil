# CogBgc — Mayor General Condensado Centro de Costos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Mayor general condensado por centro de costos. Presenta los saldos resumidos del mayor general agrupados por centro de costo para reportes gerenciales.

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
 CCOAFE       122    131     10        A   CENTRO DE COSTO QUE AFECTA                CENTRO_DE_COSTO_QUE_AFECTA
 CCOCVE       132    141     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CCODES       142    181     40        A   DESCRIPCION                               DESCRIPCION_DEL_CENTRO_COSTO
 BGCANT       182    190      9   2    P   BALANCE PERIODO ANTERIOR                  BALANCE_PERIODO_ANTERIOR_BGC
 BGCDEB       191    199      9   2    P   DEBITOS DEL PERIODO                       DEBITOS_DEL_PERIODO_BGC
 BGCCRE       200    208      9   2    P   CREDITOS DEL PERIODO                      CREDITOS_DEL_PERIODO_BGC
 BGCBAL       209    217      9   2    P   SALDO DEL PERIODO                         SALDO_DEL_PERIODO_BGC

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

---

## Observaciones

- Versión condensada del mayor general por centro de costo; ver `CogBgd` para detalle.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
