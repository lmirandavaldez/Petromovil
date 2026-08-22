# NomIr13 — Detalle Retención Anual Empleado

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de la retención anual de ISR por empleado (IR-13). Almacena el cálculo anual del ISR retenido a cada empleado para la generación del certificado de retención IR-13.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 IR1CON         1      3      3   0    P   NUMERO CONSECUTIVO                        NUMERO_CONSECUTIVO
 EMPCVE         4      7      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 EMPNOM         8     27     20        A   NOMBRE EMPLEADO                           NOMBRE_EMPLEADO
 EMPAPE        28     47     20        A   APELLIDO EMPLEADO                         APELLIDOS_EMPLEADO
 IR1LEC        48     54      7   2    P   TOTAL SALARIO                             TOTAL_SALARIO
 IR1LED        55     61      7   2    P   OTROS INGRESOS                            OTROS_INGRESOS
 IR1LEE        62     68      7   2    P   TOTAL PAGADO ANO                          TOTAL_PAGADO_ANO
 IR1LEF        69     75      7   2    P   SUELDO Y OTROS RET.                       OTROS_PAGOS_RETENC
 IR1LEG        76     82      7   2    P   IMPUESTO LIQUIDADO                        IMPUESTO_LIQUIDADO
 IR1LEH        83     89      7   2    P   IMP. RETENIDO Y PAG                       IMP_RETENIDO_PAGADO
 IR1LEI        90     96      7   2    P   SALDO FAVOR EMPLEAD                       SALDO_FAVOR_EMPL
 IR1LEJ        97    103      7   2    P   DIFERENCIA A PAGAR                        DIFERENCIA_A_PAGAR
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + año |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |

---

## Observaciones

- Base para la emisión del certificado IR-13 de retención de ISR ante la DGII.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
