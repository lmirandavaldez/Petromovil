# CogCcom — Centro Costos Módulos Externos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación de centros de costos con módulos externos al sistema contable. Permite integrar los centros de costo de otros módulos (NOM, INV, etc.) con el catálogo de COG.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CCOCVE         1     10     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CCECCO        11     20     10   0    S   CENTRO COSTO EXTERNOS                     CENTRO_COSTOS_MODULO_EXTERNO
 CCEDES        21     65     45        A   DESCRIPCION CENTRO DE COSTO               DESCRIPCION_CENTRO_COSTO_EXTE
 CCEARE        66     75     10   0    S   AREA CENTRO COSTO EXTERNO                 AREA_CENTRO_MODULO_EXTERNO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta módulo + centro de costo externo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCco | — | Centro de costos COG |
| — | SegSis | — | Módulo externo |

---

## Observaciones

- Tabla de integración entre centros de costo de módulos externos y el catálogo de COG.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
