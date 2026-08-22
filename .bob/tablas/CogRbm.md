# CogRbm — Relación Banco Moneda Cuenta Prima

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre banco, moneda y cuenta prima. Define la cuenta contable principal asociada a cada combinación de banco y moneda para el manejo multimoneda.

---

## Campos
------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 CTAPRI         4     21     18        A   CUENTA PRIMA BANCO                        NUMERO_DE_CUENTA_CONTABLE
 AUXPRI        22     25      4   0    P   AUXILIAR PRIMA BANCO                      CLAVE_AUXILIAR
 MONPRI        26     27      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta banco + moneda |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco |
| — | SegMon | — | Moneda |
| — | CogCta | — | Cuenta prima |

---

## Observaciones

- Define la cuenta contable principal por banco y moneda para transacciones multimoneda.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
