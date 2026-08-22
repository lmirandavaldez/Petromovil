# NomTssd — Detalle TSS

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del archivo TSS. Contiene el registro individual de cotizaciones por empleado para el reporte mensual de seguridad social a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TSSTID         1      1      1        A   TIPO DE REGISTRO
 TSSCLV         2      4      3        A   CLAVE DE NOMINA
 TSSTDC         5      5      1        A   TIPO DE DOCUMENTO
 TSSNDC         6     30     25        A   NUMERO DEL DOCUMENTO
 TSSNOM        31     80     50        A   NOMBRES
 TSSAP1        81    120     40        A   1ER APELLIDO
 TSSAP2       121    160     40        A   2DO APELLIDO
 TSSSEX       161    161      1        A   SEXO
 TSSFNA       162    169      8        A   FECHA DE NACIMIENTO DMA
 TSSPSS       170    185     16        A   SALARIO PERIODO SS
 TSSAOV       186    201     16        A   APORTE ORDINARIO VOLUNTARIO
 TSSSIR       202    217     16        A   SALARIO ISR
 TSSOIR       218    233     16        A   OTROS INGRESOS ISR
 TSSCED       234    244     11        A   CEDULA O RNC DEL EMPLEADOR
 TSSIOP       245    260     16        A   INGRESOS OTROS PATRONOS
 TSSIEX       261    276     16        A   INGRESOS EXENTOS DE ISR
 TSSSAF       277    292     16        A   SALDO A FAVOR DEL PERIODO
 TSSSCI       293    308     16        A   SALDO COTIZABLE INFOTEP
 TSSING       309    312      4        A   TIPO DE REMUNERACION
 TSSSRP       313    330     18        A   SALDO REGALIA PASCUAL
 TSSSPL       331    348     18        A   PREAVISO CESANTIA VIATICOS INDEMNIZACION
 TSSRPA       349    366     18        A   RETENCION PENSION ALMENTARIA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTssh | — | Cabecera TSS |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle por empleado del reporte TSS; su cabecera es `NomTssh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
