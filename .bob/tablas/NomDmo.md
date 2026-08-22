# NomDmo — Distribución de Moneda

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Distribución de moneda para el pago de nómina. Define cómo se distribuye el pago de nómina en las diferentes denominaciones de billetes y monedas cuando el pago se realiza en efectivo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DMOCVE         1      2      2   0    P   CLAVE DISTRIBUCION                        CLAVE_DE_DISTRIBUCIO
 DMOVAL         3      6      4   2    P   VALOR DE DISTRIBUCION                     VALOR_DISTRIBUCION
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — denominación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Utilizada para la planificación del efectivo necesario para el pago de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
