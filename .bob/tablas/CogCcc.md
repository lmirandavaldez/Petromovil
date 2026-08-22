# CogCcc — Control Conversión Cuenta Contable

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control de conversión de cuentas contables. Registra la relación entre cuentas del catálogo anterior y el nuevo, facilitando los procesos de migración o conversión de plan de cuentas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CCCVIE         1     18     18        A   CTA. CONTABLE ANTERIOR                    CTA_CONTABLE_ANTERIOR
 CCCNUE        19     36     18        A   CTA. CONTABLE ACTUAL                      CTA_CONTABLE_ACTUAL
 APLUSR        37     46     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        47     56     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLFEC        57     61      5   0    P   FECHA QUE APLICO AMD                      FECHA_QUE_APLICO_AMD
 APLHOR        62     65      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — cuenta origen |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable destino |
| — | CogRel | — | Relación catálogo viejo |

---

## Observaciones

- Utilizada en procesos de conversión o migración del plan de cuentas.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
