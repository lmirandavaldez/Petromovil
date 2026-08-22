# SegPgm — Tabla de Programas

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de programas del sistema. Registra todos los programas (objetos ejecutables) disponibles para el control de acceso por usuario.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PGMCVE         1     10     10        A   CLAVE DE PROGRAMA                         CODIGO_DEL_PROGRAMA
 PGMDES        11     60     50        A   DESCRIPCION                               DESCRIPCION_DEL_PROGRAMA
 PGMTLL        61     61      1        A   TIPO DE LLAMADA                           TIPO_DE_LLAMADA
 PGMLLA        62     71     10        A   PROGRAMA A SER LLAMADO                    PROGRAMA_A_SER_LLAMADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — nombre del programa |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUpg | — | Relación usuario-programa |
| — | SegSis | — | Sistema al que pertenece |

---

## Observaciones

- Catálogo de programas usado para asignar permisos de acceso a usuarios (ver `SegUpg`).
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
