# NomCss — Categoría Seguro Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Categorías de seguro social. Define las categorías de afiliación al sistema de seguridad social (SFS y SPF) con sus tasas y parámetros de cálculo de cotizaciones.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CSSCVE         1      2      2   0    P   CATEGORIA SEGURO SOCIAL                   CATEGORIA_ISS
 CCSSEM         3      3      1   0    P   NUMERO SEMANA DEL MES                     NUMERO_SEMANA_MES
 CCSAEM         4     10      7   2    P   APORTE EMPLEADO                           APORTE_EMPLEADO_ISS
 CCSAPA        11     17      7   2    P   APORTE PATRONAL                           APORTE_PATRONAL_ISS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de categoría |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCcs | — | Cuadro de cotizaciones |
| — | NomEmp | — | Empleados de esta categoría |

---

## Observaciones

- Define las categorías de cotización a la TSS según la Ley 87-01.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
