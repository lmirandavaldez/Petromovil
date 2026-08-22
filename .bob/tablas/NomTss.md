# NomTss — Archivo a Enviar a la TSS

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Archivo de nómina para la TSS (Tesorería de la Seguridad Social). Contiene los datos de cotizaciones de pensiones y salud en el formato requerido para el envío mensual a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TSSDAT         1    366    366        A   REGISTRO A ENVIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTssh | — | Cabecera TSS |
| — | NomTssd | — | Detalle TSS |

---

## Observaciones

- Reporte TSS mensual de cotizaciones; ver `NomTssb` para la bonificación.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
