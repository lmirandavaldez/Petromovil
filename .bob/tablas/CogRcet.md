# CogRcet — Temporal Relación Cliente Empleado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación temporal entre cuentas contables y clientes/empleados. Tabla de trabajo para la asignación de cuentas a terceros antes de su confirmación definitiva.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 SECSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DEL_REGISTRO_SOLICI
 RCECIA         7      9      3        A   CODIGO DE COMPANIA COP                    CODIGO_DE_COMPANIA_COP
 RCECEM        10     12      3   0    P   CODIGO EMPLEADO                           CODIGO_DE_EMPLEADO_FACA
 RCECCL        13     18      6        A   CODIGO CLIENTE                            CODIGO_DE_CLIENTE_FACA


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRced | — | Definitivo relación cliente/empleado |

---

## Observaciones

- Tabla temporal de trabajo; al confirmar pasa a `CogRced`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
