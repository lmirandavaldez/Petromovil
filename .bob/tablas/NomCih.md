# NomCih — Ciclos de Horas Extras

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Ciclos para el registro de horas extras. Define los períodos o ciclos en que se acumulan y procesan las horas extras trabajadas por los empleados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 CIHNSE        10     11      2   0    P   NUMERO DE SEMANA                          NUMERO_SEMANA_CIH
 CIHFIC        12     16      5   0    P   FECHA INICIO CICLO AMD                    FECHA_INICIO_CICLO_AMD_CIH
 CIHFFC        17     21      5   0    P   FECHA FINAL CICLO AMD                     FECHA_FINAL_CICLO_AMD_CIH
 CIHSOQ        22     22      1   0    P   CANTIDAD DE SEMANA                        CANTIDAD_SEMANA_CIH

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de ciclo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomHord | — | Horas trabajadas detalle |
| — | NomCip | — | Ciclo de pago relacionado |

---

## Observaciones

- Define los períodos de acumulación de horas extras para su pago en nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
