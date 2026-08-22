# NomTssh — Cabecera TSS

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera del archivo TSS. Registra los datos generales del reporte mensual de cotizaciones a la TSS: empresa, período, total de empleados y montos totales.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TSSTIH         1      1      1        A   TIPO DE REGISTRO
 TSSPRC         2      3      2        A   PROCESO QUE PERTENECE
 TSSRNC         4     14     11        A   RNC O CEDULA EMPLEADOR
 TSSPER        15     20      6   0    S   PERIODO MMAAAA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTssd | — | Detalle TSS |
| — | NomTssr | — | Resumen TSS |

---

## Observaciones

- Cabecera del reporte TSS mensual; su detalle es `NomTssd` y su resumen `NomTssr`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
