# NomDged — Distribución Contable Detalle

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de la distribución contable de nómina. Contiene el desglose por cuenta contable y centro de costo de cada asiento generado en el proceso de nómina.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIPANO         1      3      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         4      5      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 EMPCVE         6      9      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 AUXLIS        10     11      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CTACVE        12     29     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 AUXCVE        30     33      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        34     43     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_DE_CENTRO_COSTOS
 DGEVAL        44     50      7   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO
 DGEORI        51     51      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_DEBITO_CREDITO
 DGEDE1        52     91     40        A   DESCRIPCION                               DESCRIPCION_DEL_MOVIMIENTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta ciclo + cuenta + centro de costo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomDge | — | Distribución contable cabecera |
| — | NomRcc | — | Relación concepto-cuenta-costo |

---

## Observaciones

- Detalle contable de la nómina por cuenta y centro de costo; ver `NomDge` para la cabecera.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
