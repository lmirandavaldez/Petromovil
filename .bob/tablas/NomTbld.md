# NomTbld — Tablas Detalle

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de tablas de nómina. Contiene los valores de detalle de las tablas paramétricas utilizadas en los cálculos de nómina (ISR, sueldo mínimo, tablas de beneficios, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TBLCVE         1      3      3        A   CODIGO DE TBLLA                           CODIGO_TABLA
 TBLLMI         4     10      7   2    P   LIMITE INFERIOR                           LIMITE_INFERIOR
 TBLLMS        11     17      7   2    P   LIMITE SUPERIOR                           LIMITE_SUPERIOR
 TBLCFI        18     24      7   2    P   VALOR FIJO                                VALOR_FIJO
 TBLAPP        25     31      7   2    P   APORTE PATRONAL                           APORTE_PATRONAL
 TBLPAD        32     36      5   6    P   PORCIENTO ADICIONAL                       PORCIENTO_ADICIONAL
 TBLVA1        37     43      7   2    P   VALOR 1                                   VALOR_TABLA_1
 TBLPO1        44     48      5   6    P   PORCIENTO 1                               PORCIENTO_TABLA_1

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTblh | — | Cabecera de tablas |

---

## Observaciones

- Detalle de tablas paramétricas de nómina; su cabecera es `NomTblh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
