# CogDgd — Diario General Detallado por Cuentas

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Diario general detallado organizado por cuentas contables. Presenta el movimiento del diario general agrupado y ordenado por cuenta para análisis contable.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 DGBARC         4     13     10        A   NOMBRE DEL ARCHIVO IMPRESION              ARCHIVO_DE_IMPRESION
 DGBLPI        14     16      3        A   LINEA POR PULGADA                         LINEA_POR_PULGADA
 DGBCPI        17     20      4        A   CARACTERES POR PULGADA                    CARACTERES_POR_PULGADA
 DGBFOR        21     30     10        A   TIPO DE FORMAULARO                        TIPO_DE_FORMULARIO
 DGBHLD        31     40     10        A   RETENER                                   RETENER
 DGBDUS        41     50     10        A   DATOS DEL USUARIO                         DATOS_DEL_USUARIO
 DGBLPG        51     58      8        A   LONGITUD DE PAGINA                        LONGITUD_DE_PAGINA
 DGBWPG        59     66      8        A   ANCHO DE PAGINA                           ANCHO_DE_PAGINA
 DGBOFL        67     72      6        A   LINEA OVERFLOW                            LINEA_OVERFLOW
 DGBQLT        73     82     10        A   CALIDAD DE IMPRESION                      CALIDA_DE_IMPRESION
 DGBPGM        83     92     10        A   NOMBRE PROGRAMA IMPRIME                   NOMBRE_PROGRAMA_IMPRIME
 DGBPRT        93    102     10        A   NOMBRE IMPRESORA                          NOMBRE_IMPRISORA
 DGBTDI       103    104      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 DGBTDC       105    106      2        A   Tipo diario CK vigentes                   TIPO_DIARIO_CK_VIGENTES
 DGBNCA       107    107      1        A   NUMERAR CKS. AUTOMATICAMENTE              NUMERAR_CKS_AUTOMATICO
 DGBRIM       108    108      1        A   PERMITIR REIMPRESION CHQUES               PERMITE_REIMPRESION_CKS
 DGBTDT       109    110      2        A   T/D Transferencias                        TIPO_DIARIO_CK_CANCELADO
 DGBTDR       111    112      2        A   T/D Cancelacion Transf                    TIPO_DIARIO_TRANSFERENCIA
 DGBNTA       113    113      1        A   NUMERAR TRANSFERENCIA AUTOM.              NUMERAR_TRANSF_AUTOMATIC
 DGBCOT       114    117      4   0    P   CONTADOR DE TRANSFERENCIAS                CONTADOR_DE_TRANSFERENCIAS
 DGBEMA       118    167     50        A   EMAIL PARA RECIBIR RESPUESTA              MAIL_RECIBIR_RESPUESTA
 DGBERT       168    172      5   0    P   ENTIDAD EMITE TRANSACCION                 ENTIDAD_EMITE_TRANSACCION
 DGBPET       173    182     10        A   PGM EMITE TRANSFERENCIA                   PROGRMA_EMITE_TRANSFERENCIA
 DGBIDE       183    185      3   0    P   IDENTIFICACION DE LA EMPRESA              IDENTIFICACION_DE_LA_EMPRESA
 DGBLOT       186    191      6   0    P   NUMERO LOTE TRANSFERENCIA                 NUMERO_LOTE_TRANSFERENCIA
 DGBPIL       192    201     10        A   PGM IMPRIME CHEQUES X LOTE                DGB_PGM_IMPRIME_CK_LOTE
 DGBAIL       202    211     10        A   NOMBRE ARC. IMPRESION LOTE                DGB_ARCHIVO_IMPRESION_LOTE
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
| — | CogDged | — | Detalle del diario de transacciones |

---

## Observaciones

- Vista del diario general organizada por cuenta; ver `CogDged` para el detalle cronológico.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
