# CogGru — Grupos de Cuentas

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de grupos de cuentas contables. Define los grupos de clasificación del plan de cuentas (activo circulante, activo fijo, pasivo corriente, etc.) para reportes y análisis.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 GRUCVE         1      2      2   0    P   CLAVE DE GRUPO                            CLAVE_DE_GRUPO
 GRUDES         3     32     30        A   DESCRIPCION                               DESCRIPCION_DEL_GRUPO
 GRUDCO        33     42     10        A   DESCRIPCION CORTA                         DESCRIPCION_CORTA_DEL_GRUPO
 GRUTIP        43     43      1        A   TIPOS DE CUENTA                           TIPO_DE_CUENTA
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de grupo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuentas del grupo |

---

## Observaciones

- Clasificación jerárquica de cuentas para presentación de estados financieros.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
