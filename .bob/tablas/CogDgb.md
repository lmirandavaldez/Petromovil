# CogDgb — Datos Generales de Banco

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Datos generales complementarios de bancos. Almacena información adicional de cada banco como dirección, contactos, números de cuenta y parámetros operativos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CUENTA         1     35     35        A   CUENTA CONTABLE EDITADA                   CUENTA_CONTABLE_EDITADA
 AUXLIS        36     37      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        38     41      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 DESCTA        42     86     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 CCOCVE        87     96     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CONCVE        97     99      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOVIMIENT
 PERANO       100    102      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM       103    104      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 DGDNED       105    114     10        A   NUMERO ENTRADA DIARIO                     NUMERO_ENTRADA_DIARIO_DGD
 DGEFTR       115    124     10   0    L   FECHA DE LA TRANSACCION                   FECHA_DE_LA_TRANSACCION_DMA
 DGEDE1       125    164     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 DGDDEB       165    171      7   2    P   DEBITOS                                   DEBITO_DGD
 DGDCRE       172    178      7   2    P   CREDITOS                                  CREDITO_DGD
 DGDBAL       179    185      7   2    P   SALDO                                     SALDO_DGD
 DGERE1       186    195     10        A   REFERENCIA 1                              REFERENCIA_1
 DGERE2       196    205     10        A   REFERENCIA 2                              REFERENCIA_2
 CFACVE       206    208      3   0    P   CODIGO CLASIFICACION                      CODIGO_CLASIFICACION
 DGEIDE       209    223     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL_DGE
 NCFNRO       224    242     19        A   NUMERO DEL NCF                            NUMERO_DE_COMPROBANTE_FISCAL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de banco |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Maestro de bancos |

---

## Observaciones

- Complementa la información del maestro de bancos `CogBan`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
