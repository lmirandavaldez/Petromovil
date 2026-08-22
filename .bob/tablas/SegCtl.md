# SegCtl — Control de Licencias

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Control general de licencias del sistema. Almacena los parámetros y límites de uso de las licencias adquiridas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CTLSRL         1     10     10        A   NUMERO DE SERIE                           NUMERO_DE_SERIE
 CTLMOD        11     18      8        A   MODELO DEL SERVIDOR                       MODELO_DEL_SERVIDOR
 CTLPTY        19     26      8        A   TIPO DE PROCESADOR                        TIPO_DE_PROCESADOR
 CTLHTN        27     51     25        A   NOMBRE DEL HOST                           NOMBRE_DEL_HOST
 CTLABR        52     76     25        A   ABREVIATURA DEL CLIENTE                   ABREVIATURA_DEL_CLIENTE
 CTLCVE        77     81      5   0    P   CODIGO DEL CLIENTE                        CODIGO_DEL_CLIENTES
 CTLFIC        82     87      6   0    L   FECHA INICIO DEL CONTRATO                 FECHA_INICIO_DEL_CONTRATO
 CTLFTC        88     93      6   0    L   FECHA TERMINO DEL CONTRATO                FECHA_TERMINO_DEL_CONTRATO
 CTLMUS        94     98      5   0    S   CANTIDAD MAXIMO DE USUARIOS               CANTIDAD_MAXIMO_DE_USUARIOS
 CTLFCR        99    124     26   0    Z   FECHA DE CREACION                         FECHA_DE_CREACION
 CTLFUV       125    150     26   0    Z   FECHA ULTIMA VERIFICACION                 FECHA_ULTIMA_VERIFICACION


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegLic | — | Licencia detallada |
| — | SegCia | — | Compañía licenciada |

---

## Observaciones

- Tabla de control global de licencias; ver también `SegLic` para detalle de licencias.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
