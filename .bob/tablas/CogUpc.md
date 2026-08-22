# CogUpc — Último Período Cerrado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Registro del último período contable cerrado. Almacena el período más reciente que fue formalmente cerrado, usado como referencia para validaciones y controles de período activo.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 UPCCVE         1      1      1        A   CLAVE ULT. PERIODO                        CLAVE_ULTIMO_PERIODO
 PERANO         2      4      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM         5      6      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 APLUSR         7     16     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        17     26     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR        27     30      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA        31     32      2   0    P   DIA QUE SE APLICO                         DIA_QUE_APLICO
 APLMES        33     34      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO        35     37      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogPer | — | Período contable |
| — | SegCia | — | Compañía |

---

## Observaciones

- Referencia del último período cerrado; usada en validaciones de registros en período activo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
