# NomCcs — Cuadro Cotizaciones Seguro Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cuadro de cotizaciones de seguridad social. Define las tasas y bases de cotización aplicables a pensiones (AFP) y seguro de salud (SFS) para el cálculo de aportes patronales y laborales.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CSSCVE         1      2      2   0    P   CATEGORIA SEGURO SOCIAL                   CATEGORIA_ISS
 CSSLMI         3      9      7   2    P   LIMITE SUPERIOR SEMANAL                   LIMITE_SUPERIOR_SEMANAL_ISS
 CSSLMS        10     16      7   2    P   LIMITE SUPERIOR MENSUAL                   LIMITE_SUPERIOR_MENSUAL_ISS
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — tipo de cotización |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCss | — | Categoría de seguro social |

---

## Observaciones

- Define las tasas de cotización vigentes según la Ley 87-01 de Seguridad Social.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
