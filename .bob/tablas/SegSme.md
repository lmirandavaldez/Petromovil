# SegSme — Tabla de Usuarios, Cía, Sistema, Menú

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre usuarios, compañías, sistemas y menús. Controla el acceso granular de cada usuario a los menús de cada sistema dentro de cada compañía.

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

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta usuario + compañía + sistema + menú |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUsr | — | Usuario |
| — | SegCia | — | Compañía |
| — | SegSis | — | Sistema (módulo) |
| — | SegMen | — | Menú |

---

## Observaciones

- Tabla de control de acceso de máxima granularidad: usuario → compañía → sistema → menú.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
