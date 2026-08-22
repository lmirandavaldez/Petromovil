# NomDgt3h — Cabecera DGT3

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera del reporte DGT-3. Registra los datos generales del reporte de nómina para el Ministerio de Trabajo: empresa, período, total de empleados y monto total de nómina.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DGTTIH         1      1      1        A   TIPO DE REGISTRO
 DGTPRC         2      3      2        A   PROCESO QUE PERTENECE
 DGTRNC         4     14     11        A   RNC O CEDULA EMPLEADOR
 DGTPER        15     20      6   0    S   PERIODO MMAAAA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomDgt3d | — | Detalle DGT3 |
| — | NomDgt3r | — | Resumen DGT3 |

---

## Observaciones

- Cabecera del DGT-3; su detalle es `NomDgt3d` y su resumen `NomDgt3r`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
