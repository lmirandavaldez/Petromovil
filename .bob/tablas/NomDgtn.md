# NomDgtn — Empleados con Novedades

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Empleados con novedades en nómina. Registra los empleados que tienen transacciones o novedades (ausencias, horas extras, cambios, etc.) en el ciclo de nómina en proceso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 DGTNOV         5      7      3        A   TIPO DE NOVEDAD                           TIPO_DE_NOVEDAD

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta ciclo + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Lista de empleados con novedades para el proceso de cálculo de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
