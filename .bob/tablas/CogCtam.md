# CogCtam — Relación Catálogo Cuentas Módulos Externos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre el catálogo de cuentas contables y los módulos externos. Mapea las cuentas contables de COG con las cuentas o códigos utilizados por otros módulos del sistema.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CTACVE         1     18     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CMECTA        19     28     10   0    S   CUENTA CONTABLE EXTERNOS                  CUENTA_CONTABLE_MODULO_EXTERN
 CMEDES        29     73     45        A   DESCRIPCION CUENTA CONTABLE               DESCRIPCION_CUENTA_MODULO_EXT
 CMEMOV        74     83     10        A   TIPO DE MOVIMIENTO CONTABLE               TIPO_MOVIMIENTO_CONTABLE_EXT
 CMEARE        84     93     10   0    S   AREA CONTABLE MODULO EXTERNO              AREA_CONTABLE_MODULO_EXTERNO
 CMEPRO        94    103     10        A   PROFIT CENTER MODULO EXTERNO              PROFIT_CENTER_MODULO_EXTERNO
 CMEPAR       104    113     10   0    S   PARTNER UNIT MODULO EXTERNO               PERTNER_UNIT_MODULO_EXTERNO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta módulo + cuenta externa |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable COG |
| — | SegSis | — | Módulo externo |

---

## Observaciones

- Tabla de integración contable con otros módulos del sistema.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
