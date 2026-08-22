# NomAfp — Archivo Sistema de Seguridad Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Archivo para el Sistema de Seguridad Social (TSS/AFP). Almacena los datos de cotizaciones de pensiones y seguro de salud para el envío mensual a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AFPDAT         1    292    292        A   AUTODETERMINACION MENSUAL                 AUTODETERMINACION_MENSUAL


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomAfpc | — | Cabecera del archivo AFP |

---

## Observaciones

- Archivo de remisión a la TSS; ver `NomAfpc/d/s` para cabecera, detalle y sumario.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
