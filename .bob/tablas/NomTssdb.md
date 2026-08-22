# NomTssdb — Detalle TSS Bonificación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle del archivo TSS para bonificación. Contiene el registro individual de cotizaciones sobre la bonificación anual por empleado para el reporte a la TSS.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TSSTID         1      1      1        A   TIPO DE REGISTRO
 TSSTDC         2      2      1        A   TIPO DE DOCUMENTO
 TSSNDC         3     27     25        A   NUMERO DEL DOCUMENTO
 TSSNOM        28     77     50        A   NOMBRES
 TSSAP1        78    117     40        A   1ER APELLIDO
 TSSAP2       118    157     40        A   2DO APELLIDO
 TSSSEX       158    158      1        A   SEXO
 TSSFNA       159    166      8        A   FECHA DE NACIMIENTO DMA
 TSSIBO       167    182     16        A   MONTO BONIFICACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta período bonificación + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTssb | — | Archivo TSS bonificación |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle por empleado del TSS de bonificación; ver `NomTssd` para el regular.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
