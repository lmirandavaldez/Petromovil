# NomHorsd — Horas Semanales Trabajadas Detalle

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle de horas semanales trabajadas. Registra las horas trabajadas por día por empleado en la semana, base para el cálculo de horas normales y extras.

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
 EMPCVE        12     15      4   0    P   CODIGO DE EMPLEADO                        CODIGO_EMPLEADO
 HORFEC        16     20      5   0    P   FECHA DE TRABAJO                          FECHA_DE_TRABAJO
 HORDSE        21     21      1   0    P   DIA DE LA SEMANA                          DIA_DE_LA_SEMANA
 HORCHT        22     23      2   0    P   CANTIDAD DE HORAS TRABAJADAS              CANTIDAD_HORAS_TRABAJADAS
 HORMIN        24     25      2   0    P   CANTIDAD DE MINUTOS                       CANTIDAD_DE_MINUTOS
 HORHEN        26     51     26   0    Z   FECHA HORA ENTRADA                        FECHA_HORA_ENTRADA
 HORHSA        52     77     26   0    Z   FECHA HORA SALIDA                         FECHA_HORA_SALIDA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado + día |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomHorsh | — | Cabecera horas semanales |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle diario de horas semanales por empleado; su cabecera es `NomHorsh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
