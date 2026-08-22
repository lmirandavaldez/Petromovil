# NomMpb — Monto Prorrateo Bonificación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Monto de prorrateo de bonificación. Registra el cálculo del prorrateo de la bonificación anual (regalía pascual) para empleados que no completaron el año.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BONANO         1      3      3   0    P   ANO PERTENECE BONIFICACION                ANO_PERTENECE_BONOS
 MPBVAL         4     10      7   2    P   MONTO PRORRATEO BONIFICACION              MONTO_PRORRATEO_BONIFICACION
 APLUSR        11     20     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        21     30     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLTST        31     56     26   0    Z   FECHA QUE SE APLICO                       FECHA_QUE_SE_APLICO_TST

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período bonificación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomBon | — | Corte de bonificación |

---

## Observaciones

- Cálculo proporcional de bonificación para empleados con tiempo parcial en el año.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
