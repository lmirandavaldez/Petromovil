# NomBpr — Transferencia Nómina Banco Progreso

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Archivo de transferencia de nómina al Banco Progreso. Almacena los datos de pago para empleados que cobran a través del Banco Progreso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BPRRNC         1     11     11        A   RNC DE LA EMPRESA
 BPRTIP        12     12      1        A   TIPO
 BPRCTA        13     22     10        A   CUENTA BANCARIA
 BPRMPG        23     33     11        A   MONTO DEL PAGO
 BPRFPG        34     41      8        A   FECHA DE PAGO
 BPRCEM        42     47      6        A   CODIGO EMPLEADO
 BPRNOM        48     77     30        A   NOMBRE DEL EMPLEADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomBan | — | Banco Progreso |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Archivo de transferencia al Banco Progreso en el formato requerido por dicho banco.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
