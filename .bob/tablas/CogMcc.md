# CogMcc — Relación Moneda, Cuenta de Caja

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre monedas y cuentas de caja. Define qué cuenta contable de caja o banco corresponde a cada moneda para el registro de transacciones en múltiples divisas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 MONCVE         1      2      2   0    P   CODIGO TIPO DE MONEDAS                    CODIGO_DE_MONEDA
 CTACV1         3     20     18        A   CUENTA DE CAJA                            CUENTA_MONEDA_EXTRANJERA
 AUXCV1        21     24      4   0    P   AUXILIAR DE CAJA                          AUXILIAR_MONEDA_EXTRANJERA
 CTACV2        25     42     18        A   CUENTA PRIMA                              CUENTA_PRIMA
 AUXCV2        43     46      4   0    P   AUXILIAR PRIMA                            AUXILIAR_PRIMA
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta moneda + cuenta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegMon | — | Moneda |
| — | CogCta | — | Cuenta contable de caja |

---

## Observaciones

- Mapeo moneda → cuenta de caja para manejo multimoneda.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
