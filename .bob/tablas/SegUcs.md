# SegUcs — Relación Usuario, Cía, Sistema

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Relación entre usuarios, compañías y sistemas. Controla el acceso de cada usuario a los módulos del sistema dentro de cada compañía.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 USRCVE         1     10     10        A   USUARIO                                   CODIGO_DEL_USUARIO
 CIACVE        11     12      2        A   COMPANIA                                  NUMERO_COMPANIA
 SISCVE        13     14      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta usuario + compañía + sistema |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUsr | — | Usuario |
| — | SegCia | — | Compañía |
| — | SegSis | — | Sistema (módulo) |

---

## Observaciones

- Nivel intermedio de acceso: usuario → compañía → sistema. Ver `SegSme` para nivel menú.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
