# NomDgt4h — Cabecera DGT4

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera del reporte DGT-4. Registra los datos generales de la planilla de personal para el Ministerio de Trabajo: empresa, período y totales.

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
| — | NomDgt4d | — | Detalle DGT4 |
| — | NomDgt4r | — | Resumen DGT4 |

---

## Observaciones

- Cabecera del DGT-4; su detalle es `NomDgt4d` y su resumen `NomDgt4r`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
