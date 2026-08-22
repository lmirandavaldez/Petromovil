# NomCec — Control Emisión de Cheques

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Control de emisión de cheques de nómina. Registra el estado del proceso de emisión de cheques para el pago de nómina a empleados que cobran en efectivo o cheque.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 BANCVE        10     12      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 CECFEC        13     17      5   0    P   FECHA DE EMISION AMD                      FECHA_EMISION_CHEQUE
 APLUSR        18     27     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        28     37     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR        38     41      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — ciclo de pago |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCip | — | Ciclo de pago |
| — | NomTec | — | Temporal emisión de cheques |

---

## Observaciones

- Controla el proceso de emisión de cheques de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
