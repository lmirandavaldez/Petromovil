# CogRel — Relación Catálogo Viejo

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre el catálogo de cuentas anterior y el nuevo. Utilizada en procesos de migración para mantener la trazabilidad de las cuentas durante la conversión del plan de cuentas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CTACVE         1     18     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CTADES        19     63     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 CTATIP        64     64      1   0    P   TIPO DE CUENTA                            TIPO_DE_CUENTA_CONTABLE
 CTAMAU        65     65      1        A   MANEJA AUXILIAR                           MANEJA_LISTA_AUXILIAR
 CTAMCC        66     66      1        A   MANEJA CENTRO DE COSTOS                   MANEJA_CENTRO_DE_COSTO
 CTAAFE        67     84     18        A   CUENTA QUE AFECTA                         NUMERO_CUENTA_AFECTA
 GRUCVE        85     86      2   0    P   CLAVE DE GRUPO                            CLAVE_DE_GRUPO
 AUXLIS        87     88      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CTAORI        89     89      1   0    P   ORIGEN DE LA CUENTA                       ORIGEN_DE_LA_CUENTA_CONTABLE
 CCOCVE        90     99     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 AUXCVE       100    103      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CTAVJE       104    115     12        A   CUENTA VIEJA
 AUXVJE       116    120      5        A   AUXILIAR VIEJO
 DPTVJE       121    122      2        A   DPTO. VIEJO
 CUENTA       123    141     19        A   CUENTA VIEJA COMPLETA
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — cuenta vieja |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogCta | — | Cuenta nueva equivalente |
| — | CogCcc | — | Control conversión cuenta contable |

---

## Observaciones

- Tabla de migración para conversión de plan de cuentas; ver `CogCcc`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
