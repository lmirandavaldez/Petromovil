# NomAac — Aportes Acumulados

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Aportes acumulados de empleados. Almacena los acumulados de aportes patronales y laborales (seguridad social, AFP, etc.) por empleado y período.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 CMCCVE         5      7      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 AACVAL         8     14      7   2    P   VALOR ACUMULADO                           VALOR_APORTE_ACUMULADO
 AACVRE        15     21      7   2    P   VALOR RETIRADO                            VALOR_APORTE_RETIRADO
 AACIGE        22     28      7   2    P   INTERESES GENERADOS                       INTERESES_APORTE_GENERADO
 AACBCE        29     35      7   2    P   BALANCE ACUMULADO                         BALANCE_APORTE_ACUMULADO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Acumula los aportes por tipo (patronal/laboral) para reportes de seguridad social.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
