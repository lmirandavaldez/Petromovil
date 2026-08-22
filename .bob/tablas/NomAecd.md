# NomAecd — Acumulado Empleado Concepto Mensual

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Acumulado mensual por empleado y concepto de nómina. Almacena el monto acumulado de cada concepto por empleado en el mes, base para reportes de nómina mensual y seguridad social.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 AECANO         8     10      3   0    P   ANO ACUM. EMPLADO CONC.                   ANO_ACUM_ANUAL_EMPL_CONC
 AECMES        11     12      2   0    P   MES ACUMULADO                             MES_ACUMUL_EMPL_CONC
 AECCAD        13     19      7   2    P   CAN. ACUM. MENSUAL EMPL.CONC              CANT_ACUM_MENSUAL_EMPL_CONC
 AECIMD        20     26      7   2    P   IMP. ACUM MENSUAL EMPL CONC               IMP_ACUM_MENSUAL_EMPL_CONC
 AECAPD        27     33      7   2    P   APORTE PATRONO ACUM EMPL CON              APORTE_PATRONO_MENS_EMPL_CONC
 AECISD        34     40      7   2    P   SALDO A FAVOR/EN CONTRA EMPL              SDO_MENSUAL_FAVOR_CONTRA_EMPL
 AECVED        41     47      7   2    P   VALOR EXONERADO ISR                       VALOR_EXONERADO_MENS_ISR_EMPL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + concepto + período mensual |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Acumulado mensual empleado-concepto; ver `NomAech` para el anual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
