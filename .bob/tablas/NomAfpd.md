# NomAfpd — Detalle Sistema de Seguridad Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del archivo del Sistema de Seguridad Social. Contiene el desglose por empleado de las cotizaciones de pensiones y salud para el reporte mensual a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AFPTRE         1      1      1        A   TIPO DE REGISTRO                          TIPO_DE_REGISTRO
 CNOCVE         2      3      2   0    S   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TIPDOC         4      4      1        A   TIPO DE DOCUMENTO                         TIPO_DE_DOCUMENTO
 NUMIDE         5     29     25        A   NUMERO DE IDENTIFICACION                  NUMERO_DE_IDENTIFICACION
 EMPNOM        30     79     50        A   NOMBRES EMPLEADO                          NOMBRE_EMPLEADO
 EMPAP1        80    119     40        A   1ER. APELLIDO DEL EMPLEADO                PRIMER_APELLIDO_DEL_EMPLEADO
 EMPAP2       120    159     40        A   2DO. APELLIDO DEL EMPLEADO                SEGUNDO_APELLIDO_DEL_EMPLEADO
 EMPSEX       160    160      1        A   SEXO                                      SEXO_EMPLEADO
 FECNAC       161    168      8   0    S   FECHA DE NACIMIENTO                       FECHA_NACIMIENTO
 AFPSUE       169    184     16   2    S   SALARIO DEL PERIODO SS                    SALARIO_SEGURIDAD_SOCIAL
 AFPAOV       185    200     16   2    S   APORTE ORDINARIO VOLUNTARIO               APORTE_ORDINARIO_VOLUNTARIO
 AFPSIR       201    216     16   2    S   SALARIO APLICABLE ISR                     SALARIO_APLICABLE_ISR
 AFPORA       217    232     16   2    S   OTRAS REMUNERACIONES ISR                  OTRAS_REMUNERACIONES_ISR
 CIARNC       233    243     11        A   REGISTRO FISCAL                           REGISTRO_FISCAL
 AFPROP       244    259     16   2    S   REMUNERACIONES OTRO PATRONO               REMUNERACIONES_OTROS_PATRONOS
 AFPIER       260    275     16   2    S   INGRESOS EXENTOS DE ISR                   INGRESOS_EXENTOS_DE_ISR
 AFPSFP       276    291     16   2    S   SALDO A FAVOR DEL PERIODO                 SALDO_A_FAVOR_DEL_PERIODO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomAfpc | — | Cabecera archivo AFP |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle por empleado del reporte TSS; su cabecera es `NomAfpc`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
