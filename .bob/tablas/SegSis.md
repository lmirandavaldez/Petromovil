# SegSis — Tabla de Sistema (Módulo)

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo de sistemas o módulos del sistema. Define cada módulo funcional instalado (NOM, COG, INV, SEG, etc.) con sus parámetros de configuración.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SISCVE         1      2      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA
 SISDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_DEL_SISTEMA
 SISINS        43     43      1        A   INSTALACION                               SISTEMA_INSTALADO
 SISCIE        44     44      1        A   REQUIERE CIERRE PERIODOS                  REQUIERE_CIERRE_PERIODOS
 SISLIB        45     54     10        A   NOMBRE LIBRERIA DEL SISTEMA               NOMBRE_LIBRERIA_DEL_SISTEMA
 SISMIE        55     64     10        A   NOMBRE DEL MIEMBRO                        NOMBRE_DEL_MIEMBRO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de sistema/módulo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCsi | — | Compañías que usan este sistema |
| — | SegSim | — | Menús del sistema |
| — | SegPgm | — | Programas del sistema |

---

## Observaciones

- Tabla central de módulos; referenciada por prácticamente todas las tablas de seguridad.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
