# SegNcf — Numeración correlativa fiscal

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
 MCFCVE         1      2      2   0    P   MODULO COMPROBANTE FISCAL                 MODULO_COMPROBANTE_FISCAL
 DISCVE         3      4      2   0    P   NUMERO DE DISTRITO                        CODIGO_DE_DISTRITO
 MONCVE         5      6      2   0    P   CODIGO MONEDA                             CODIGO_DE_MONEDA
 TCFCVE         7      8      2   0    P   TIPO COMPROBANTE FISCAL                   TIPO_COMPROBANTE_FISCAL
 NCFORD         9     12      4   2    P   ORDEN DE EJECUCION                        ORDEN_DE_EJECUCION
 NCFSER        13     13      1        A   SERIE NCF                                 SERIE_RELACIONADA
 NCFDIV        14     15      2   0    S   DIVISION O NEGOCIO                        DIVISION_NEGOCIO
 NCFZON        16     18      3   0    S   ZONA SUCURSAL                             ZONA_SUCURSAL
 NCFCAJ        19     21      3   0    S   CAJA HAND HELD                            CAJA_HAND_HELD
 NCFTIP        22     23      2   0    S   TIPO DE NCF                               TIPO_DE_COMPROBANTE
 NCFINI        24     33     10   0    S   SECUENCIA INICIAL                         SECUENCIA_INICIAL
 NCFFIN        34     43     10   0    S   SECUENCIA FINAL                           SECUENCIA_FINAL
 NCFSEC        44     53     10   0    S   SECUENCIA DEL NCF                         SECUENCIA_DEL_COMPROBANTE
 NCFREO        54     63     10   0    S   NUMERO SECUENCIA REORDEN NCF              NUMERO_SEC_REORDEN_COMPROBANT
 NCFFIP        64     73     10   0    L   FECHA INICIO PERIODO NCF                  FECHA_INICIO_PERIODO_NCF
 NCFFFP        74     83     10   0    L   FECHA FINAL PERIODO NCF                   FECHA_FINAL_PERIODO_NCF
 NCFSTA        84     84      1        A   STATUS                                    STATUS_NCF

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | (campo) | Clave principal |

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
