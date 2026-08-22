# CogPcth — Cabecera Cuentas de Presupuesto

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de las cuentas de presupuesto. Registra los datos generales de cada versión de presupuesto: período, descripción y estado de aprobación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PERANO         1      3      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PRECVE         4      5      2   0    P   NRO. DE PRESUPUESTO                       NUMERO_DEL_PRESUPUESTO
 PRGCVE         6      7      2   0    P   GRUPO DE PRESUPUESTO                      GRUPO_DEL_PRESUPUESTO
 CTACVE         8     25     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CCOCVE        26     35     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 AUXCVE        36     39      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 PCTVAL        40     47      8   2    P   MONTO PRESUPUESTO                         MONTO_DEL_PRESUPUESTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de presupuesto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPctd | — | Detalles del presupuesto |
| — | CogPre | — | Títulos de presupuestos |
| — | CogPer | — | Período contable |

---

## Observaciones

- Cabecera del presupuesto contable; su detalle es `CogPctd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
