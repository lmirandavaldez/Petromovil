# CogPctd — Detalle Cuentas de Presupuesto

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de las cuentas de presupuesto. Contiene los montos presupuestados por cuenta contable y período, para comparación con los valores reales del mayor general.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PERANO         1      3      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         4      5      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 PRECVE         6      7      2   0    P   NRO. DE PRESUPUESTO                       NUMERO_DEL_PRESUPUESTO
 PRGCVE         8      9      2   0    P   GRUPO DE PRESUPUESTO                      GRUPO_DEL_PRESUPUESTO
 CTACVE        10     27     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CCOCVE        28     37     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 AUXCVE        38     41      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 PCTVPR        42     49      8   2    P   MONTO PRESUPUESTO PERIODO                 MONTO_PRESUPUESTO_PERIODO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + cuenta |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPcth | — | Cabecera cuentas de presupuesto |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de montos presupuestados por cuenta; su cabecera es `CogPcth`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
