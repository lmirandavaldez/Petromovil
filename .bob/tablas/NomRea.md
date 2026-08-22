# NomRea — Relación Empleado / Aporte

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Relación entre empleados y sus aportes. Registra los aportes específicos de cada empleado a fondos de pensión, seguros u otras entidades, con sus porcentajes y montos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CODIGO CONCEPTO                           CODIGO_CONCEPTO_CM
 REAVEM         8     11      4   2    P   VALOR APORTE EMPLEADO                     VALOR_APORTE_EMPLEADO
 REAPEM        12     14      3   2    P   PORC. APORTE EMPLEADO                     PORCIENTO_APORTE_EMPLEADO
 REAVPA        15     18      4   2    P   VALOR APORTE PATRONO                      VALOR_APORTE_PATRONO
 REAPPA        19     21      3   2    P   PORCIENTO APORTE PATRONO                  PORCIENTO_APORTE_PATRONO
 PMFPER        22     22      1   0    P   PERIODICIDAD                              PERIODICIDAD_DEDUCCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + tipo de aporte |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCmc | — | Concepto de aporte |

---

## Observaciones

- Relación empleado-aporte para el cálculo de cotizaciones individuales.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
