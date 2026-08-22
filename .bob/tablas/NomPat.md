# NomPat — Pago Póliza Accidentes de Trabajo

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Pago de póliza de accidentes de trabajo. Registra los datos para el cálculo y pago de la prima de seguro de accidentes laborales (ARS/ART) descontada en nómina.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPRSS         1     15     15        A   REGISTRO SEG. SOCIAL                      REG_SEG_SOCIAL
 EMPCED        16     21      6   0    P   CEDULA IDENTIDAD Y ELECTORAL              CEDULA_IDENTIDAD_ECLECT
 EMPCAN        22     25      4   0    P   CEDULA ANTERIOR                           CEDULA_ANTERIOR
 EMPSER        26     27      2   0    P   SERIE CEDULA ANTERIOR                     SERIE_CEDULA_ANTERIOR
 PATNOM        28     69     42        A   NOMBRES Y APELLIDOS                       NOMBRE_Y_APELLIDO
 PATBRU        70     76      7   2    P   SALARIO BRUTO                             SALARIO_BRUTO
 PATOIN        77     83      7   2    P   OTROS INGRESOS                            INGRESOS_OTROS
 PATSSC        84     90      7   2    P   SALARIO SUJETO A CONTRIBUC.               SALARIO_SUJETO_A_CONTRIBUCION
 PATCLA        91     91      1        A   CLASE DE EMPLEADO                         CLASE_DE_EMPLEADO

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
| — | NomPsm | — | Plan de seguro médico |

---

## Observaciones

- Control del pago de pólizas de accidentes laborales en nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
