# CogConh — Concepto Gastos Menores Contable

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Conceptos contables para gastos menores. Define los conceptos específicos usados en el proceso de gastos menores (caja chica) con su distribución contable.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CONCVE         1      3      3   0    P   CODIGO DEL CONCEPTO                       CODIGO_DEL_CONCEPTO
 CONDES         4     33     30        A   DESCRIPCION                               DESCRIPCION_DEL_CONCEPTO
 CONDCO        34     43     10        A   DESCRIPCION CORTA                         DESCRIPCION_COSTA_CONCEPTO_MO
 CONVAL        44     50      7   2    P   VALOR MAXIMO TRANSACCION                  VALOR_MAXIMO_TRANSACCION
 CTACVE        51     68     18        A   NUMERO DE CUENTA CONTABLE                 NUMERO_DE_CUENTA_CONTABLE
 AUXCVE        69     72      4   0    P   NUMERO DE AUXILIAR                        CLAVE_AUXILIAR
 CCOCVE        73     82     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CONUCO        83     84      2        A   USO DEL CONCEPTO                          USO_DEL_CONCEPTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — concepto de gasto menor |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCon | — | Concepto general |
| — | CogGmth | — | Cabecera gastos menores temporal |

---

## Observaciones

- Conceptos específicos del proceso de gastos menores / caja chica.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
