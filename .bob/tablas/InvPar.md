# InvPar — Parámetros de inventario

**Biblioteca:** DATOS02  
**Tipo:** Tabla física  
**Módulo:** (completar)  
**Descripción:** (completar)

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PARCVE         1      1      1        A   CLAVE PARAMETRO GENERAL                   CLAVE_PARAMETRO_GENERAL
 PARDE1         2     21     20        A   DESCRIPCION DE IMPUESTO 1                 DESCRIPCION_DE_IMPUESTO_1
 PARIM1        22     24      3   2    P   IMPUESTO DE VENTA NO. 1                   IMPUESTO_DE_VENTA_NO_1
 CTAIM1        25     42     18        A   CUENTA CONTABLE IMPUESTO 1                CUENTA_IMPUESTO_1
 AUXIM1        43     46      4   0    P   AUXILIAR IMPUESTO 1                       AUXILIAR_IMPUESTO_1
 PARDE2        47     66     20        A   DESCRIPCION DE IMPUESTO 2                 DESCRIPCION_DE_IMPUESTO_2
 PARIM2        67     69      3   2    P   IMPUESTO DE VENTA NO. 2                   IMPUESTO_DE_VENTA_NO_2
 CTAIM2        70     87     18        A   CUENTA CONTABLE IMPUESTO 2                CUENTS_IMPUESTO_2
 AUXIM2        88     91      4   0    P   AUXILIAR IMPUESTO 2                       AUXILIAR_IMPUESTO_2
 PARPIM        92     92      1        A   PRECIO CON IMPUESTO INCLUIDO S/N          PRECIO_CON_IMPUES_INCLUIDO
 PARTME        93     94      2        A   COD. TIPO MOV. AJUSTE INV. E              CODIGO_TIPO_MOV_AJUSTE_INV_EN
 PARTMS        95     96      2        A   COD. TIPO MOV. AJUSTE INV. S              CODIGO_TIPO_MOV_AJUSTE_INV_SA
 ANOUPC        97     99      3   0    P   ULTIMO ANO CERRADO INVENT.                ANO_ULTIMO_PERIODO_CERRADO
 NUMUPC       100    101      2   0    P   ULTIMO MES CERRADO INVENT.                NUMERO_ULTIMO_PERIODO_CER
 CONCVE       102    104      3   0    P   CODIGO CONCEPTO DEL MOV.                  CODIGO_CONCEPTO_DEL_MOV
 TDICVE       105    106      2        A   CLAVE DE TIPO DIARIO                      CLAVE_DE_TIPO_DIARIO
 ANOCPC       107    109      3   0    P   ANO ULT. PERIODO CERRADO                  ANO_ULT_PERIODO_CONTA_CERRADO
 NUMCPC       110    111      2   0    P   NUM ULT. PERIODO CERRADO                  NUM_ULT_PERIODO_CONTA_CERRADO
 PARTCO       112    112      1        A   TIPO DE COSTIFICACION P/U                 TOPO_DE_COSTIFICACION
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK   | PARCVE |CLAVE PARAMETRO GENERAL |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| (completar) | | | |

---

## Observaciones

(Completar con comportamientos especiales, reglas de negocio o advertencias.)

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
