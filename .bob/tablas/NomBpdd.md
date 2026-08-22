# NomBpdd — Detalle Pago Empleados BPD

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de pago a empleados a través del BPD. Contiene el registro individual de cada empleado con su cuenta y monto para la transferencia de nómina al Banco Popular Dominicano.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SRDTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO_DETALLE
 SRDIDC         2     16     15        A   ID COMPANIA RNC                           ID_DE_COMPANIA_RNC_DET
 SRDSHD        17     23      7        A   SECUENCIA                                 SECUENCIA_HDG
 SRDSEC        24     30      7        A   SECUENCIA DETALLE                         SECUENCIA_DETALLE
 SRDNCT        31     50     20        A   CUENTA DESTINO                            CUENTA_DESTINO
 SRDTCD        51     51      1        A   TIPO DE CUENTA DESTINO                    TIPO_DE_CUENTA_DESTINO
 SRDMOD        52     54      3   0    S   MONEDA DESTINO                            CODIGO_MONEDA_DESTINO
 SRDCBD        55     62      8   0    S   CODIGO BANCO DESTINO                      CODIGO_BANCO_DESTINO
 SRDDVD        63     63      1   0    S   DIGITO VERIFIC.BANCO DESTINO              DIGITO_VERIF_BANCO_DESTINO
 SRDCOP        64     65      2        A   CODIGO OPERACION                          CODIGO_OPERACION
 SRDMTR        66     78     13   0    S   MONTO TRANSACCION                         MONTO_TRANSACCION
 SRDTID        79     80      2        A   TIPO IDENTIFICACION                       TIPO_IDENTIFICACION
 SRDIDE        81     95     15        A   IDENTIFICACION                            IDENTIFICACION
 SRDNOM        96    130     35        A   NOMBRE                                    NOMBRE
 SRDNRE       131    142     12        A   NUMERO REFERENCIA                         NUMERO_REFERENCIA
 SRDDES       143    182     40        A   DESCRIPCION                               DESCRIPCION_DETALLE
 SRDFVE       183    186      4        A   FECHA VENCIMIENTO                         FECHA_VENCIMIENTO
 SRDFCN       187    187      1        A   FORMA DE CONTACTO                         FORMA_DE_CONTACTO
 SRDEMA       188    227     40        A   EMAIL DEL BENEFICIARIO                    EMAIL_DEL_BENEFICIARIO
 SRDFXB       228    239     12   0    S   FAX DEL BENEFICIARIO                      FAX_DEL_BENEFICIARIO
 SRDFL1       240    241      2   0    S   FILLER 01                                 FILLER_01
 SRDNAU       242    256     15        A   NUMERO DE AUTORIZACION                    NUMERO_DE_AUTORIZACION
 SRDRRE       257    259      3        A   CODIGO DE RETORNO REMOTO                  CODIGO_DE_RETORNO_REMOTO
 SRDCRR       260    262      3        A   CODIGO DE RAZON REMOTO                    CODIGO_DE_RAZON_REMOTO
 SRDCRI       263    265      3        A   CODIGO DE RAZON INTERNO                   CODIGO_DE_RAZON_INTERNO
 SRDPRC       266    266      1        A   PROCESADOR TRANSACCION                    PROCESADOR_TRANSACCION
 SRDSTA       267    268      2        A   STATUS                                    STATUS_DETALLE
 SRDRVA       269    270      2        A   RESPUESTA VALIDACION                      RESPUESTA_VALIDACION
 SRDFL2       271    320     50        A   FILLER 02                                 FILLER_02
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta encabezado + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBpdh | — | Encabezado BPD |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle de nómina BPD por empleado; su encabezado es `NomBpdh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
