# CogCbahh — Cabecera Conciliación Bancaria (Histórico)

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera histórica de la conciliación bancaria. Registra los datos de encabezado de las conciliaciones bancarias de períodos ya cerrados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 CBADCO         4      5      2   0    P   DIA DE CORTE                              DIA_DEL_CORTE_ESTADO_CUENTA
 CBAMCO         6      7      2   0    P   MES DE CORTE                              MES_DEL_CORTE_ESTADO_CUENTA
 CBAACO         8     10      3   0    P   ANO DE CORTE                              ANO_DEL_CORTE_ESTADO_CUENTA
 CBABBA        11     18      8   2    P   BALANCE SEGUN BANCO                       BALANCE_SEGUN_BANCO
 UBCBCE        19     26      8   2    P   ULTIMO BALANCE CONCILIADO                 ULTIMO_BALANCE_CONCILIADO
 CBACHE        27     34      8   2    P   CHEQUES PAGADOS                           CHEQUES_PAGADOS
 CBADEP        35     42      8   2    P   DEPOSITOS Y OTROS CREDITOS                DEPOSITOD_Y_OTROS_CREDITOS
 CBAOCL        43     50      8   2    P   OTROS CREDITOS
 CBACDE        51     58      8   2    P   VALOR DOCUMENTO CREDITO                   VALOR_DOCUMENTO_CREDITO
 CBAOCE        59     66      8   2    P   OTROS CARGOS EMITIDOS
 CBABSL        67     74      8   2    P   BALANCE SEGUN LIBRO                       BALANCE_SEGUN_LIBRO
 CBABCL        75     82      8   2    P   BALANCE CONCILIADO LIBRO                  BALANCE_CONCILIADO_LIBRO
 CBABCB        83     90      8   2    P   BALANCE CONCILIADO BANCO                  BALANCE_CONCILIADO_BANCO
 CBACBA        91     98      8   2    P   BCE. ESTADO BANCARIO                      BALANCE_ESTADO_BANCARIO
 CBACTR        99    106      8   2    P   CHEQUES VIGENTES EN TRANSITO              CHEQUES_VIEGENTES_EN_TRANSITO
 CBAOCR       107    114      8   2    P   OTROS CARGOS EN TRANSITO
 CBADTR       115    122      8   2    P   DEPOSITOS EN TRANSITO                     DEPOSITOS_EN_TRANSITO
 CBAOCT       123    130      8   2    P   OTROS CREDITOS EN TRANSITO
 CBABLI       131    138      8   2    P   BALANCE SEGUN LIBRO                       BALANCE_SEGUN_LIBRO_BCH
 CBANDT       139    146      8   2    P   NOTAS DE DEBITO EN TRANSITO               NOTA_DEBITO_EN_TRANSITO
 CBANCT       147    154      8   2    P   NOTAS DE CREDITO EN TRANSITO              NOTA_CREDITO_EN_TRANSITO
 CBACLI       155    162      8   2    P   BCE. CONCILIADO SEGUN LIBRO               BALANCE_CONCILIADO_SEGUN_LIBR
 CBATDE       163    170      8   2    P   TOTAL DEPOSITOS EMITIDOS                  TOTAL_DEPOSITOS_EMITIDOS
 CBATOC       171    178      8   2    P   TOTAL OTROS CREDITOS EMIT.                TOTAL_DEPOSITOS_EMITIDOS_MES
 CBAVDI       179    186      8   2    P   VALOR DE LA DIFERENCIA                    VALOR_DIFERENCIA_SEGUN_BANCO
 CBAVDL       187    194      8   2    P   VALOR DE LA DIFERENCIA LIBRO              VALOR_DIFERENCIA_SEGUN_LIBRO
 SITCVE       195    195      1        A   CLAVE DE SITUACION                        CLAVE_DE_SITUACION
 APLUSR       196    205     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       206    215     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR       216    219      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA       220    221      2   0    P   DIA QUE SE APLICO                         DIA_QUE_APLICO
 APLMES       222    223      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO       224    226      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO
 CBAFAS       227    231      5   0    P   FECHA ASIENTO CONTABLE AMD                FECHA_ASIENTO_CONCILIACION
 CBATDI       232    233      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 CBAPEA       234    236      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERPEN       237    238      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 CBADOC       239    242      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — banco + período histórico |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCbahd | — | Detalles históricos de conciliación |
| — | CogBan | — | Banco |

---

## Observaciones

- Cabecera histórica de conciliación bancaria; ver `CogCbah` para la versión activa.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
