# NomBpdh — Encabezado Pago Empleados BPD

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Encabezado del pago a empleados a través del BPD. Registra los datos generales del lote de transferencia: empresa, período, fecha valor y total a transferir.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SRHTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO
 SRHIDC         2     16     15        A   ID COMPANIA RNC                           ID_DE_COMPANIA_RNC
 SRHNCO        17     51     35        A   NOMBRE COMPANIA                           NOMBRE_DE_COMPANIA
 SRHSEC        52     58      7        A   SECUENCIA                                 SECUENCIA
 SRHTSE        59     60      2   0    S   TIPO DE SERVICIO                          TIPO_DE_SERVICIO
 SRHFEF        61     68      8   0    S   FECHA EFECTIVA AMD                        FECHA_EFECTIVA_AMD
 SRHCDB        69     79     11        A   CANTIDAD DEBITOS                          CANTIDAD_DEBITOS
 SRHMDB        80     92     13        A   MONTO TOTAL DEBITOS                       MONTO_TOTAL_DEBITOS
 SRHCCR        93    103     11   0    S   CANTIDAD DE CREDITOS                      CANTIDAD_DE_CREDITOS
 SRHMTC       104    116     13   0    S   MONTO TOTAL CREDITOS                      MONTO_TOTAL_CREDITOS
 SRHNAF       117    131     15        A   NUMERO DE AFILIACION                      NUMERO_DE_AFILIACION
 SRHFEA       132    139      8   0    S   FECHA DE ENVIO ARCHIVO                    FECHA_DE_ENVIO_ARCHIVO
 SRHHEA       140    143      4   0    S   HORA DE ENVIO ARCHIVO                     HORA_DE_ENVIO_ARCHIVO
 SRHEMA       144    183     40        A   EMAIL RECIBIR NOTIFICACIONES              EMAIL_RECIBIR_NOTIFICACIONES
 SRHSTA       184    184      1        A   STATUS                                    STATUS
 SRHFIL       185    320    136        A   ESPACIOS EN BLANCO                        ESPACIOS_EN_BLANCO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de lote |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBpdd | — | Detalle BPD |

---

## Observaciones

- Encabezado del lote de pago BPD; su detalle es `NomBpdd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
