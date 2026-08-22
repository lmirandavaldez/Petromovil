# NomTra — Transacciones de Nómina

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Transacciones de nómina. Almacena todas las novedades y transacciones individuales de nómina (ausencias, bonos extras, ajustes, descuentos) para el ciclo en proceso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 EMPCVE        10     13      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE        14     16      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 TRASEC        17     18      2   0    P   SECUENCIA TRANSACCION                     SECUENCIA_TRANSACCION
 TRAVAL        19     25      7   2    P   VALOR DE LA TRANSACCION                   VALOR_TRANSACCION
 TRACAN        26     32      7   2    P   CANTIDAD DE LA TRANSACION                 CANTIDAD_TRANSACCION
 TRAIMP        33     39      7   2    P   IMPORTE TOTAL TRANSACCION                 IMPORTE_TRANSACCION
 TRACCO        40     49     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_DE_CENTRO_COSTOS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta ciclo + empleado + concepto + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de nómina |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Tabla principal de novedades de nómina; base del cálculo del ciclo activo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
