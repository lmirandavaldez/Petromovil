# NomLeond — Detalle Transferencia Nómina LEON

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de la transferencia de nómina al Banco LEON. Contiene el registro individual de cada empleado con su cuenta y monto para el pago a través del Banco LEON.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 LEOTRE         1      4      4        A   CUENTA BANCARIA A DEBITAR
 LEOBNR         5     10      6   0    S   CANTIDAD EMPLEADOS
 LEOCTR        11     14      4   0    S   CODIGO TRANSACCION
 LEOCTA        15     24     10   0    S   NUMERO CUENTA
 LEOFEC        25     32      8   0    S   FECHA MDA
 LEOMON        33     42     10   2    S   MONTO DE LA TRANSACCION
 LEOCOD        43     52     10   0    S   CODIGO DE EMPLEADO
 LEOSTA        53     53      1   0    S   STATUS DE EMPLEADO
 LEOF02        54     66     13        A   FILLER

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomLeonh | — | Cabecera LEON |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle de nómina LEON por empleado; su cabecera es `NomLeonh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
