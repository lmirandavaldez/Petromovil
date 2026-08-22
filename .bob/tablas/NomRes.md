# NomRes — Relación Empleado Plan de Seguro

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Relación entre empleados y planes de seguro médico. Registra la afiliación de cada empleado (y sus dependientes) al plan de salud corporativo con sus primas y coberturas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 PSMCVE         5      7      3   0    P   CODIGO DE SEGURO                          CODIGO_SEGURO
 PMFPER         8      8      1   0    P   PERIODICIDAD                              PERIODICIDAD_DEDUCCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + plan de seguro |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomPsm | — | Plan de seguro médico |

---

## Observaciones

- Afiliación de empleados a planes de seguro médico para el descuento en nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
