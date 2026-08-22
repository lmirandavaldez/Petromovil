# NomAfps — Sumario Sistema de Seguridad Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Sumario del archivo del Sistema de Seguridad Social. Presenta los totales consolidados de cotizaciones del período para el cierre del reporte mensual a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AFPTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO
 AFPNRE         2      7      6   0    S   NUMERO DE REGISTROS                       NUMERO_DE_REGISTROS


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomAfpc | — | Cabecera archivo AFP |

---

## Observaciones

- Totales consolidados del reporte TSS; ver `NomAfpd` para el detalle por empleado.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
