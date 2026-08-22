# NomTno — Tipos de nómina

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
 TNOCVE         1      2      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 TNODES         3     27     25        A   DESCRIPCION                               DESCRIPCION_TIPO_NOMINA
 TNOPRO        28     28      1   0    P   PROCESO DE NOMINA                         PROCESO_NOMINA
 CMCCVE        29     31      3   0    P   CODIGO DE MOVIMIENTOS                     CODIGO_CONCEPTO_CM
 TNOVEX        32     38      7   2    P   VALOR EXENTO ISR                          VALOR_EXENTO_IMPUESTO
 TNOPDI        39     42      4   4    P   PORCIENTO INFOTEP                         PORC_DESC_INFOTEP
 CTACVE        43     60     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 AUXCVE        61     64      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 TDICVE        65     66      2        A   CLAVE DE TIPO DIARIO                      CLAVE_DE_TIPO_DIARIO
 CONCVE        67     69      3   0    P   CODIGO CONCEPTO DEL MOV.                  CONCEPTO_CONTABLE
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
