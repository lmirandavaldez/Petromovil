# CogRmc — Relación Moneda, Cuenta y Sistema

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre moneda, cuenta contable y sistema (módulo). Define la cuenta contable que cada módulo debe usar para registrar transacciones en cada moneda.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 MONCVE         1      2      2   0    P   CODIGO TIPO DE MONEDAS                    CODIGO_DE_MONEDA
 SISCVE         3      4      2        A   CLAVE DE SISTEMA                          CLAVE_DEL_SISTEMA
 CTACV1         5     22     18        A   CUENTA MONEDA EXTRANJERA                  CUENTA_MONEDA_EXTRANJERA
 AUXCV1        23     26      4   0    P   AUXILIAR MONEDA EXTRANJERA                AUXILIAR_MONEDA_EXTRANJERA
 CTACV2        27     44     18        A   CUENTA PRIMA                              CUENTA_PRIMA
 AUXCV2        45     48      4   0    P   AUXILIAR PRIMA                            AUXILIAR_PRIMA
 CTACV3        49     66     18        A   CUENTA DIFERENCIA EN PRIMA                CUENTA_DIFERENCIA_EN_PRIMA
 AUXCV3        67     70      4   0    P   AUXILIAR DIFERENCIA EN PRIMA              AUXILIAR_DIFERENCIA_EN_PRIMA
 CTACV4        71     88     18        A   CUENTA PERDIDA CAMBIARIA                  CUENTA_PERDIDA_CAMBIARIA
 AUXCV4        89     92      4   0    P   AUXILIAR PERDIDA CAMBIARIA                AUXILIAR_PERDIDA_CAMBIARIA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta moneda + cuenta + sistema |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegMon | — | Moneda |
| — | CogCta | — | Cuenta contable |
| — | SegSis | — | Sistema (módulo) |

---

## Observaciones

- Integración multimodular para el manejo contable multimoneda.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
