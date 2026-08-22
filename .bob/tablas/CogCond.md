# CogCond — Concepto Distribución Contable

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Distribución contable predefinida por concepto. Define el reparto automático de débitos y créditos en las cuentas contables al registrar un concepto.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CONCVE         1      3      3   0    P   CODIGO CONCEPTO                           CODIGO_CONCEPTO_DEL_MOVIMIENT
 CONSEC         4      6      3   0    P   SECUENCIA DETALLE CONCEPTO                SECUENCIA_DETALLE_CONCEPTO
 CTACVE         7     24     18        A   NUMERO DE CUENTA CONTABLE                 NUMERO_DE_CUENTA_CONTABLE
 AUXCVE        25     28      4   0    P   NUMERO DE AUXILIAR                        CLAVE_AUXILIAR
 CCOCVE        29     38     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 GMEORI        39     39      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_TRANSACCION_D_C
 MOVAXV        40     40      1        A   ES AUXILIAR VARIABLE                      ES_AUXILIAR_VARIABLE

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCon | — | Concepto contable |
| — | CogCta | — | Cuenta contable destino |

---

## Observaciones

- Define la distribución automática de cuentas por concepto al generar asientos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
