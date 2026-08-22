# CogDcc — Distribución Contable de Conciliación

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Distribución contable generada desde la conciliación bancaria. Almacena los asientos contables resultantes del proceso de conciliación bancaria.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 DGESEC         4      6      3   0    P   SECUENCIA                                 SECUENCIA
 CTACVE         7     24     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        25     26      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        27     30      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        31     40     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 DGEDE1        41     80     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 DGEVAL        81     88      8   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO
 DGEORI        89     89      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 DGERE1        90     99     10        A   REFERENCIA 1                              REFERENCIA_1
 DGERE2       100    109     10        A   REFERENCIA 2                              REFERENCIA_2
 DGEDMO       110    111      2   0    P   DIA DEL MOVIMIENTO                        DIA_DEL_MOVIMIENTO
 DGEMMO       112    113      2   0    P   MES DEL MOVIMIENTO                        MES_DEL_MOVIMIENTO
 DGEAMO       114    116      3   0    P   A#O DEL MOVIMIENTO                        ANO_DEL_MOVIMIENTO
 DGEDTO       117    118      2   0    P   DIA DE VENCIMIENTO                        DIA_DE_VENCIMIENTO
 DGEMTO       119    120      2   0    P   MES DE VENCIMIENTO                        MES_DE_VENCIMIENTO
 DGEATO       121    123      3   0    P   A#O DE VENCIMIENTO                        ANO_DE_VENCIMIENTO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta conciliación + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCbah | — | Cabecera conciliación bancaria |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Asientos contables generados automáticamente por la conciliación bancaria.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
