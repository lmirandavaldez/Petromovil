# NomScs — Cantidad de Semanas del Mes ISS

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cantidad de semanas del mes para el ISS. Define la cantidad de semanas laborables de cada mes para el cálculo de cotizaciones del seguro social semanal.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SCSANO         1      3      3   0    P   ANO CANTIDAD SEMANA                       ANO_CANT_SEMANA
 SCSMES         4      5      2   0    P   MES CANTIDAD SEMANA                       MES_CANT_SEMANA
 SCSCAN         6      6      1   0    P   CANTIDAD DE SEMANAS                       CANT_SEMANA_MES
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — mes |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegFec | — | Fechas del período |

---

## Observaciones

- Define las semanas laborables por mes para el cálculo del seguro social semanal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
