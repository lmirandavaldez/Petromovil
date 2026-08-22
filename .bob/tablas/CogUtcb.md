# CogUtcb — Unificación Tasa de Cambio Bancos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Unificación de tasas de cambio para bancos. Define la tasa de cambio unificada que se aplica a las transacciones bancarias en moneda extranjera para garantizar consistencia en el registro contable.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 MONPRI         4      5      2   0    P   CODIGO DE MONEDA PRIMA                    CODIGO_MONEDA_DE_LA_PRIMA
 CTACVE         6     23     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXCVE        24     27      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CTAPRI        28     45     18        A   CUENTA PRIMA BANCO                        CUENTA_DE_LA_PRIMA
 AUXPRI        46     49      4   0    P   AUXILIAR PRIMA BANCO                      AUXILIAR_DE_LA_PRIMA
 UTCSAC        50     58      9   2    P   SALDO ANTERIOR CUENTA                     SALDO_ANTERIOR_CUENTA
 UTCMOC        59     67      9   2    P   MOVIMIENTO PERIODO CUENTA                 MOVIMIENTO_DEL_PERIODO_CUENTA
 UTCSFC        68     76      9   2    P   SALDO FINAL DE LA CUENTA                  SALDO_FINAL_DE_LA_CUENTA
 UTCSAP        77     85      9   2    P   SALDO ANTERIOR DE LA PRIMA                SALDO_ANTERIOR_DE_LA_PRIMA
 UTCMOP        86     94      9   2    P   MOVIMIENTO PERIODO PRIMA                  MOVIMIENTO_DEL_PERIODO_PRIMA
 UTCSFP        95    103      9   2    P   SALDO FINAL DE LA PRIMA                   SALDO_FINAL_DE_LA_PRIMA
 VALDIF       104    112      9   2    P   VALOR DIFERENCIA                          VALOR_DE_LA_DIFERENCIA
 ORIGEN       113    113      1   0    P   ORIGEN DE LA DIFERENCIA                   ORIGEN_DE_LA_DIFERENCIA_1_2
 UTCTAS       114    119      6   5    P   TASA DE CAMBIO UNIFICADA                  TASA_CAMBIO_UNIFICADA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta banco + moneda + fecha |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco |
| — | SegMon | — | Moneda extranjera |
| — | SegFec | — | Fecha de vigencia de la tasa |

---

## Observaciones

- Centraliza las tasas de cambio bancarias para el módulo de contabilidad multimoneda.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
