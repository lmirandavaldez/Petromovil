# NomAfpc — Cabecera Sistema de Seguridad Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera del archivo del Sistema de Seguridad Social. Registra los datos de encabezado del reporte mensual de cotizaciones enviado a la TSS (empresa, período, totales).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AFPTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO
 AFPPRO         2      3      2        A   TIPO DE PROCESO                           TIPO_DE_PROCESO
 AFPRNC         4     14     11        A   NUMERO IDENTIFICACION                     NUMERO_DE_IDENTIFICACION
 AFPPER        15     20      6   0    S   PERIODO DE AUTODETERMINACION              PERIODO_DE_AUTODETERMINACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomAfpd | — | Detalle del archivo AFP |
| — | NomAfps | — | Sumario del archivo AFP |

---

## Observaciones

- Cabecera del reporte TSS; su detalle es `NomAfpd` y su sumario `NomAfps`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
