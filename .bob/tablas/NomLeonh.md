# NomLeonh — Cabecera Transferencia Nómina LEON

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Cabecera de la transferencia de nómina al Banco LEON. Registra los datos del lote de pago: empresa, período, fecha valor y monto total a transferir.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 LEOTRE         1      4      4        A   CUENTA BANCARIA A DEBITAR
 LEOBNR         5     10      6   0    S   CANTIDAD EMPLEADOS
 LEOCAN        11     14      4   0    S   FECHA DE PAGO
 LEOMCR        15     24     10   2    S   MONTO TOTAL
 LEOMDB        25     34     10   2    S   DESCRIPCION DEL PAGO
 LEOF01        35     63     29        A   FILLER
 LEOTIT        64     64      1        A   TIPO DE TRANSMISION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — número de lote |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomLeond | — | Detalle LEON |

---

## Observaciones

- Cabecera del lote de pago LEON; su detalle es `NomLeond`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
