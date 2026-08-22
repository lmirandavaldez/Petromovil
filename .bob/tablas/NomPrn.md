# NomPrn — Orden de Ejecución de Programas

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Orden de ejecución de programas de nómina. Define la secuencia y condiciones de ejecución de los programas del proceso de nómina para garantizar el orden correcto de procesamiento.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 PRNSEC         5      8      4   2    P   ORDEN DE EJECUCION                        ORDEN_EJECUCION
 PRNDES         9     48     40        A   DESCRIPCION DEL PROGRAMA                  DESCR_PROGRAMA
 PRNPGM        49     58     10        A   PROGRAMA EN EJECUCION                     PROGRAMA_EJECUTAR
 PRNSTA        59     59      1        A   STATUS DE LA EJECUCION                    STATUS_EJECUCION
 PRNTIP        60     60      1        A   TIPO DE EJECUCION                         TIPO_DE_EJECUCION

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegPgm | — | Programa a ejecutar |
| — | NomCip | — | Ciclo de pago |

---

## Observaciones

- Define la secuencia obligatoria de ejecución de programas en el proceso de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
