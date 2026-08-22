# CogRfh — Cabecera Razones Financieras

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de las razones financieras. Define cada indicador financiero disponible en el sistema (razón corriente, endeudamiento, ROE, etc.) con su nombre y descripción.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RAZCVE         1      2      2   0    P   NRO. DE RAZON                             NUMERO_DE_RAZON
 RAZDES         3     62     60        A   DESCRIPCION O TITULO                      DESCRIPCION_RAZON_FINANCIERA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de razón financiera |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRfd | — | Detalle de la razón financiera |
| — | CogRfv | — | Variables de la razón financiera |

---

## Observaciones

- Catálogo de razones financieras; su detalle es `CogRfd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
