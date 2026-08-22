# CogCcr — Relación Cuenta Contable Centro de Costos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre cuentas contables y centros de costos. Define qué centros de costo pueden registrar movimientos en cada cuenta del catálogo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CTACVE         1     18     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CCOCVE        19     28     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 CREUSR        29     38     10        A   USUARIO QUE CREO REGISTRO                 USUARIO_QUE_CREO_REGISTRO
 CREWSI        39     48     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 CRETST        49     74     26   0    Z   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cuenta + centro de costo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable |
| — | CogCco | — | Centro de costos |

---

## Observaciones

- Define la asignación válida cuenta-centro de costo para el registro de transacciones.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
