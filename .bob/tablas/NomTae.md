# NomTae — Temporal Tiempo Acumulado Empleado

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Temporal de tiempo acumulado por empleado. Tabla de trabajo para el cálculo acumulado de tiempo de servicio por empleado durante el proceso de nómina.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 TAEANO         5      6      2   0    P   ANOS DE TRABAJO TOTAL                     ANOS_TRABAJO_TOTAL
 TAEMES         7      8      2   0    P   MESES TRABAJO TOTAL                       MESES_TRABAJO_TOTAL
 TAEDIA         9     10      2   0    P   DIAS TRABAJO TOTAL                        DIAS_TRABAJO_TOTAL
 TAETME        11     14      4   0    P   TOTAL DE MESES TRABAJADO                  TOTAL_MESES_TRABAJADO
 TAETDI        15     20      6   0    P   TOTAL DE DIAS TRABAJADO                   TOTAL_DIAS_TRABAJADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta ciclo + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Tabla temporal de trabajo para el cálculo del tiempo de servicio acumulado.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
