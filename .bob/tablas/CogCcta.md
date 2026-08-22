# CogCcta — Catálogo de Cuentas Consolidado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo de cuentas contables consolidado para múltiples compañías. Unifica los planes de cuentas de distintas compañías para la generación de estados financieros consolidados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   NRO. COMPANIA                             CODIGO_DE_COMPANIA
 CTACVE         3     20     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CTADES        21     65     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 CTADCO        66     80     15        A   NOMBRE CORTO                              NOMBRE_CORTO_CUENTA_CONTABLE
 CTATIP        81     81      1   0    P   TIPO DE CUENTA                            TIPO_DE_CUENTA_CONTABLE
 CTAMAU        82     82      1        A   MANEJA AUXILIAR                           MANEJA_LISTA_AUXILIAR
 CTAMCC        83     83      1        A   MANEJA CENTRO DE COSTOS                   MANEJA_CENTRO_DE_COSTO
 CTAAFE        84    101     18        A   CUENTA QUE AFECTA                         NUMERO_CUENTA_AFECTA
 GRUCVE       102    103      2   0    P   CLAVE DE GRUPO                            CLAVE_DE_GRUPO
 AUXLIS       104    105      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CTAORI       106    106      1   0    P   ORIGEN DE LA CUENTA                       ORIGEN_DE_LA_CUENTA_CONTABLE
 CTACAC       107    107      1        A   CODIGO DE ACTUALIZACION                   CODIGO_DE_ACTULIZACION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — cuenta consolidada |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta contable individual |

---

## Observaciones

- Catálogo consolidado para reportes multicompañía; ver `CogCta` para catálogo individual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
