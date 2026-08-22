# NomAech — Acumulado Empleado Concepto Anual

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Acumulado anual por empleado y concepto de nómina. Almacena el total acumulado de cada concepto por empleado en el año, base para el cálculo del ISR anual y la IR-4.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 AECANO         8     10      3   0    P   ANO ACUM. EMPLADO CONC.                   ANO_ACUM_ANUAL_EMPL_CONC
 AECCAN        11     17      7   2    P   CANT. ACUM. ANUAL EMPL.CONC               CANT_ACUM_ANUAL_EMPL_CONC
 AECIMP        18     24      7   2    P   IMPORTE ACUM ANUAL EMPL CONC              IMPORTE_ACUM_ANUAL_EMPL_CONC
 AECAPA        25     31      7   2    P   APORTE PATRONO ACUM EMPL CON              APORTE_PATRONO_ACUM_EMPL_CONC
 AECISR        32     38      7   2    P   SALDO A FAVOR/EN CONTRA EMPL              SALDO_FAVOR_CONTRA_EMPL
 AECVEX        39     45      7   2    P   VALOR EXONERADO ISR                       VALOR_EXONERADO_ISR_EMPL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + concepto + año |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Acumulado anual empleado-concepto; base para la declaración IR-4 ante la DGII.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
