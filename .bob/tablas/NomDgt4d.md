# NomDgt4d — Detalle DGT4

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del reporte DGT-4. Contiene el detalle por empleado del reporte de planilla de personal requerido por el Ministerio de Trabajo en el formato DGT-4.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DGTTID         1      1      1        A   TIPO DE REGISTRO
 DGTCLV         2      4      3        A   NOVEDAD INGRESO
 DGTTDC         5      5      1        A   TIPO DE DOCUMENTO
 DGTNDC         6     30     25        A   NUMERO DEL DOCUMENTO
 DGTNOM        31     80     50        A   NOMBRES
 DGTAP1        81    120     40        A   1ER APELLIDO
 DGTAP2       121    160     40        A   2DO APELLIDO
 DGTFNA       161    168      8        A   FECHA DE NACIMIENTO DMA
 DGTSEX       169    169      1        A   SEXO
 DGTPSS       170    185     16        A   SALARIO MENSUAL
 DGTFIN       186    193      8        A   FECHA DE INGRESO DMA
 DGTFSA       194    201      8        A   FECHA DE SALIDA DMA
 DGTOCU       202    207      6        A   CODIGO DE OCUPACION
 DGTDOC       208    357    150        A   DESCRIPCION DE LA OCUPACION
 DGTFIV       358    365      8        A   FECHA INICIO VACACIONES
 DGTFFV       366    373      8        A   FECHA FINAL VACACIONES
 DGTTUR       374    379      6        A   TURNO DE TRABAJO
 DGTUBI       380    385      6        A   UBICACION O LOCALIDAD
 DGTNAC       386    388      3        A   CODIGO DE NACIONALIDAD
 DGTOBS       389    538    150        A   OBSERVACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomDgt4h | — | Cabecera DGT4 |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle por empleado del DGT-4; su cabecera es `NomDgt4h`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
