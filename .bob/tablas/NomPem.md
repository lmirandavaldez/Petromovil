# NomPem — Planilla de Empleados

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Planilla de empleados activos. Registra el detalle de la planilla de personal activo con sus salarios y condiciones laborales vigentes para el período de nómina en proceso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 NOMAPE         3     44     42        A   NOMBRES Y APELLIDOS EMPLEADO              NOMBRE_APELLIDOS_EMPLEADO
 EMPCED        45     50      6   0    P   CEDULA IDENTIDAD Y ELECTORAL              CEDULA_IDENTIDAD_ECLECT
 EMPRSS        51     65     15        A   REGISTRO SEG. SOCIAL                      REG_SEG_SOCIAL
 NACDMA        66     75     10        A   FECHA DE NACIMIENTO DMA                   FECHA_DE_NACIMIENTO
 EMPSEX        76     76      1        A   SEXO                                      SEXO_EMPLEADO
 NACDES        77    101     25        A   DESCRIPCION                               DESCR_NACIONALIDAD
 INGDMA       102    111     10        A   FECHA DE INGRESO DMA                      FECHA_DE_INGRESO
 CARDES       112    136     25        A   DESCRIPCION                               DESCR_CARGO
 EMPSBA       137    143      7   2    P   SALARIO MENSUAL                           SALARIO_MENSUAL
 TURCVE       144    145      2   0    P   CODIGO DE TURNO                           CODIGO_TURNO
 IVADMA       146    155     10        A   FECHA INICIO VACACIONES DMA               FECHA_INICIO_VACACIONES
 FVADMA       156    165     10        A   FECHA FINAL VACACIONES DMA                FECHA_FINALIZA_VACACIONES

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

- Planilla de empleados activos para el ciclo de nómina en proceso.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
