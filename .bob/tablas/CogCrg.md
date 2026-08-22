# CogCrg — Control Reverso Gasto Menor

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Control de reversiones de gastos menores. Registra los asientos de reverso generados para anular gastos menores registrados incorrectamente.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 GMETDC         1      3      3        A   TIPO DE DOCUMENTO                         TIPO_DOCUMENTO_GME
 GMENUM         4      9      6   0    P   NUMERO DESEMBOLSO                         NUMERO_GASTO_MENOR_DEFINITIVO
 APLUSR        10     19     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        20     29     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLTST        30     55     26   0    Z   FECHA QUE SE APLICO                       FECHA_QUE_SE_APLICO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogGmhh | — | Cabecera gastos menores histórico |
| — | CogDgeh | — | Cabecera diario de reverso |

---

## Observaciones

- Controla los reversales de gastos menores para auditoría.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
