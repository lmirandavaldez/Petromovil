# NomDgt3d — Detalle DGT3

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del reporte DGT-3. Contiene el detalle por empleado del reporte de nómina requerido por el Ministerio de Trabajo en el formato DGT-3.

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
 DGTOCU       194    199      6        A   CODIGO DE OCUPACION
 DGTDOC       200    349    150        A   DESCRIPCION DE LA OCUPACION
 DGTFIV       350    357      8        A   FECHA INICIO VACACIONES
 DGTFFV       358    365      8        A   FECHA FINAL VACACIONES
 DGTTUR       366    371      6        A   TURNO DE TRABAJO
 DGTUBI       372    377      6        A   UBICACION O LOCALIDAD
 DGTOBS       378    527    150        A   OBSERVACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomDgt3h | — | Cabecera DGT3 |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle por empleado del DGT-3; su cabecera es `NomDgt3h`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
