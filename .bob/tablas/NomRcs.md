# NomRcs — Razón Cambios de Sueldo

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de razones de cambios de sueldo. Define los motivos válidos por los que se puede modificar el salario de un empleado (ajuste por mérito, promoción, cambio de categoría, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RCSCVE         1      2      2   0    P   CODIGO DE RAZON CAMBIO                    CODIGO_RAZON_CAMBIO_SUELDO
 RCSDES         3     32     30        A   DESCRIPCION                               DESCR_RAZON_CAMBIO_SUELDO
 RCSDCO        33     42     10        A   DESCRIPCION CORTA                         DESCR_CORTA_CAMBIO_SUELDO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de razón |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCse | — | Registro de cambios de sueldo |

---

## Observaciones

- Catálogo de causales de cambio salarial para auditoría de modificaciones.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
