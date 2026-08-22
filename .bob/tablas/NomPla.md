# NomPla — Plantas de Producción

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de plantas de producción. Define las plantas o centros de trabajo donde laboran los empleados, utilizadas para la distribución de costos de nómina por área productiva.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PLACVE         1      2      2   0    P   PLANTA EMPLEADO                           PLANTA_EMPLEADO
 PLADES         3     32     30        A   DESCRIPCION LARGO                         DESCRIPCION_LARGA_PLANTA
 PLADCO        33     42     10        A   DESCRIPCION CORTA                         DESCRIPCION_CORTA_PLANTA
 PLAUNE        43     45      3   0    P   ULTIMO NUMERO EMPLEADO                    ULTIMO_NRO_EMPLEADO_PLANTA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de planta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleados de la planta |
| — | NomUbi | — | Ubicación geográfica |

---

## Observaciones

- Catálogo de plantas/centros de trabajo para distribución de costos de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
