# SegUpg — Relación Usuario, Programas

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre usuarios y programas. Define los permisos de acceso de cada usuario a los programas (objetos ejecutables) del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 USRCVE         1     10     10        A   USUARIO                                   CODIGO_DEL_USUARIO
 CIACVE        11     12      2        A   NRO. COMPA#IA                             NUMERO_COMPANIA
 SISCVE        13     14      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA
 MENCVE        15     16      2        A   CLAVE DE MENU                             CODIGO_DEL_MENU
 PGMCVE        17     26     10        A   CLAVE DE PROGRAMA                         CODIGO_DEL_PROGRAMA
 CRETST        27     52     26   0    Z   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 CREUSR        53     70     18        A   USUARIO QUE CREO REGISTRO                 USUARIO_QUE_CREO_REGISTRO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta usuario + programa |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUsr | — | Usuario |
| — | SegPgm | — | Programa |

---

## Observaciones

- Control de acceso a nivel de programa individual por usuario.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
