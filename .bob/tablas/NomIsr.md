# NomIsr — Detalle ISR desde TSS IR4

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del ISR reportado desde la TSS para la IR-4. Almacena los datos de retención de ISR de empleados provenientes del informe de la TSS, utilizados para la declaración IR-4 anual.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIPAAC         1      3      3   0    P   ANO QUE ACUMULAR                          ANO_QUE_ACUMULA
 CIPMAC         4      5      2   0    P   MES QUE ACUMULA                           MES_QUE_ACUMULA
 EMPCVE         6      9      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 EMPCED        10     15      6   0    P   CEDULA IDENTIDAD Y ELECTORAL              CEDULA_IDENTIDAD_ECLECT
 ISRSPA        16     22      7   2    P   SALARIO PAGADO AGENTE RETENCION           SALARIO_PAGADO_AGENTE_RET
 ISRORP        23     29      7   2    P   OTRAS REMUNERACIONES PAGADA               OTRAS_REMUNERACIONES_PAGADA
 ISRRPO        30     36      7   2    P   REMUNERACIONES PAGADA OTRO PATRONO        REMUNERACIONES_PAGADA_OTRO_PA
 ISRTPM        37     44      8   2    P   TOTAL PAGADO EN EL MES                    TOTAL_PAGADO_EN_EL_MES
 ISRRSS        45     51      7   2    P   RETENCION  SEGURIDAD SOCIAL               RETENCION_SEGURIDAD_SOCIAL
 ISRMTS        52     58      7   2    P   MONTO RETENIDO TSS SISTEMA                MONTO_RETENIDO_TSS_SISTEMA
 DIFMTS        59     65      7   2    P   DIFERENCIA MONTO RETENIDO TSS SISTEMA     DIFERENCIA_MONTO_RETENIDO_TSS
 ISRIRP        66     72      7   2    P   INGRESO  REGALIA PASCUAL                  INGRESO_REGALIA_PASCUAL
 ISRIPC        73     79      7   2    P   INGRESO  PREAVISO Y CESANTIA              INGRESO_PREAVISO_CESANTIA
 ISRRPA        80     86      7   2    P   RETENCION PENSION ALIMENTARIA             RETENCION_PENSION_ALIMENTARIA
 ISRTIE        87     94      8   2    P   TOTAL INGRESOS EXENTOS                    TOTAL_INGRESOS_EXENTOS
 ISRSSR        95    102      8   2    P   SUELDOS SUJETOS A RETENCION               SUELDOS_SUJETOS_RETENCION
 ISRLPE       103    109      7   2    P   LIQUIDACION DEL PERIODO                   LIQUIDACION_DEL_PERIODO
 ISRMIS       110    116      7   2    P   MONTO RETENIDO ISR SISTEMA                MONTO_RETENIDO_ISR_SISTEMA
 DIFMIS       117    123      7   2    P   DIFERENCIA MONTO RETENIDO ISR SISTEMA     DIFERENCIA_MONTO_RETENIDO_ISR
 ISRSAS       124    130      7   2    P   SALDO A FAVOR DEL ASALARIADO              SALDO_A_FAVOR_ASALARIADO
 ISRSCP       131    137      7   2    P   SALDO COMPENSADO                          SALDO_COMPENSADO
 ISRMCP       138    144      7   2    P   MONTO SALDO COMPENSADO                    MONTO_SALDO_COMPENSADO
 ISRNSA       145    151      7   2    P   NUEVO SALDO A FAVOR ASALARIADO            NUEVO_SALDO_FAVOR_ASALARIADO
 ISRDAP       152    158      7   2    P   DIFERENCIA A PAGAR                        DIFERENCIA_A_PAGAR
 ISRMDA       159    165      7   2    P   MONTO DIFERENCIA A PAGAR                  MONTO_DIFERENCIA_A_PAGAR
 DIFMDA       166    172      7   2    P   MONTO DIFERENCIA PAGADO                   MONTO_DIFERENCIA_PAGADO

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

- Datos de ISR desde TSS para la declaración IR-4 anual ante la DGII.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
