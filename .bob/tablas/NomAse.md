# NomAse — Acumulados Seguro Social

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Acumulados de seguro social por empleado. Almacena los montos acumulados de aportaciones al seguro social (SFS y SPF) por empleado para el período de liquidación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 AECANO         5      7      3   0    P   ANO ACUM. EMPLADO CONC.                   ANO_ACUM_ANUAL_EMPL_CONC
 AECMES         8      9      2   0    P   MES ACUMULADO                             MES_ACUMUL_EMPL_CONC
 ASEPEM        10     16      7   2    P   SEGURO PAGADO EMPLEADO                    SEGURO_PAGAD_EMPLEADO
 ASEPPA        17     23      7   2    P   SEGURO PAGADO PATRONOO                    SEGURO_PAGAD_PATRONO
 ASECSE        24     24      1   0    P   CANT. DE SEMANAS TRABAJADA                CANT_SEMANA_TRABAJADA
 ASESAL        25     31      7   2    P   SALARIO PERCIBIDO EN EL MES               SALARIO_DEVENGADO_DEL_MES
 ASECSA        32     32      1        A   CAMBIO DE SALARIO                         CAMBIO_DE_SALARIO
 EMPAIL        33     35      3   0    P   ANO INICIO LICENCIA                       ANO_INICIO_LICENCIA
 EMPMIL        36     37      2   0    P   MES INICIO LICENCIA                       MES_INICIO_LICENCIA
 EMPDIL        38     39      2   0    P   DIA INICIO LICENCIA                       DIA_INICIO_LICENCIA
 EMPAFL        40     42      3   0    P   ANO FIN LICENCIA                          ANO_FIN_LICENCIA
 EMPMFL        43     44      2   0    P   MES FIN LICENCIA                          MES_FIN_LICENCIA
 EMPDFL        45     46      2   0    P   DIA FIN LICENCIA                          DIA_FIN_LICENCIA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado |
| — | NomCss | — | Categoría de seguro social |

---

## Observaciones

- Acumulados de seguridad social para reportes a la TSS.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
