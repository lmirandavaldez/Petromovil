# CogBgd — Mayor General Detallado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Mayor general detallado de cuentas. Contiene el movimiento transacción por transacción de cada cuenta contable, con débitos, créditos y saldos acumulados.

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
 CONCVE       122    124      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 PERANO       125    127      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM       128    129      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 DGDNED       130    139     10        A   NUMERO ENTRADA DIARIO                     NUMERO_ENTRADA_DIARIO_DGD
 DGEFTR       140    149     10   0    L   FECHA DE LA TRANSACCION                   FECHA_DE_LA_TRANSACCION_DMA
 DGEDE1       150    189     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 DGDDEB       190    198      9   2    P   DEBITOS                                   DEBITO_DGD
 DGDCRE       199    207      9   2    P   CREDITOS                                  CREDITO_DGD
 DGDBAL       208    216      9   2    P   SALDO                                     SALDO_DGD
 DGERE1       217    226     10        A   REFERENCIA 1                              REFERENCIA_1
 DGERE2       227    236     10        A   REFERENCIA 2                              REFERENCIA_2
 CFACVE       237    239      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 DGEIDE       240    254     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_DGE
 NCFNRO       255    273     19        A   NUMERO DEL NCF                            NUMERO_DE_COMPROBANTE_FISCAL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período + cuenta + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable |
| — | CogPer | — | Período contable |
| — | CogDgeh | — | Cabecera de diario |

---

## Observaciones

- Mayor general a nivel transaccional; ver `CogMge` para el mayor general de saldos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
