# CogPlr — Planificación Entradas Recurrentes

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Planificación de entradas contables recurrentes. Define el calendario de generación de los asientos recurrentes: frecuencia, próxima fecha de ejecución y estado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 TDIERE         3      6      4   0    P   NUMERO SECUENCIAL RECURRENTE              NUMERO_SECUENCIAL_RECURRENTE
 PLRDIA         7      8      2   0    P   DIA PLANIFICACION                         DIA_DE_PLANIFICACION
 PLRMES         9     10      2   0    P   MES PLANIFICACION                         MES_DE_PLANIFICACION
 PLRANO        11     13      3   0    P   ANO PLANIFICACION                         ANO_DE_PLANIFICACION
 PLRDSE        14     22      9        A   DIA DE LA SEMANA                          DIA_DE_LA_SEMANA
 PERANO        23     25      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        26     27      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 PLRSIT        28     28      1        A   SITUACION                                 STATUS_DE_LA_PLANIFICACION
 PLRDEJ        29     30      2   0    P   DIA QUE SE EJECUTO                        DIA_QUE_SE_EJECUTO
 PLRMEJ        31     32      2   0    P   MES QUE SE EJECUTO                        MES_QUE_SE_EJECUTO
 PLRAEJ        33     35      3   0    P   ANO QUE SE EJECUTO                        ANO_QUE_SE_EJECUTO
 DGEDOC        36     39      4   0    P   NUMERO DE DOCUMENTO                       NUMERO_DEL_DOCUMENTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de planificación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEreh | — | Cabecera entrada recurrente |
| — | CogPer | — | Período contable |

---

## Observaciones

- Define el calendario de ejecución de asientos recurrentes.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
