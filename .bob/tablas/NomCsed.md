# NomCsed — Temporal Detalle Cambio de Sueldos

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Detalle temporal de cambios de sueldo. Tabla de trabajo para el detalle de los cambios de sueldo en proceso antes de su confirmación definitiva.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CSECVE         1      4      4   0    P   NUMERO TEMPORAL                           NUMERO_TEMPORAL
 CSESEC         5      7      3   0    P   SECUENCIA                                 NRO_SECUENCIA
 EMPCVE         8     11      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 RCSCVE        12     13      2   0    P   CODIGO DE RAZON CAMBIO                    CODIGO_RAZON_CAMBIO_SUELDO
 CSESAN        14     20      7   2    P   SUELDO ANTERIOR                           SUELDO_ANTERIOR
 CSESAC        21     27      7   2    P   SUELDO ACTUAL                             SUELDO_ACTUAL
 CSEPVA        28     31      4   2    P   % DE VARIACION                            PROCIENTO_VARIACION
 CSEAEF        32     34      3   0    P   ANO DE EFECTIVIDAD                        ANO_EFECTIVIDAD
 CSEMEF        35     36      2   0    P   MES DE EFECTIVIDAD                        MES_EFECTIVIDAD
 CSEDEF        37     38      2   0    P   DIA DE EFECTIVIDAD                        DIA_EFECTIVIDAD
 CSEOBS        39     88     50        A   OBSERVACION                               OBSERVACION_CAMBIO_SUELDO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + empleado |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCseh | — | Cabecera temporal cambio de sueldos |
| — | NomEmp | — | Empleado |

---

## Observaciones

- Detalle temporal de cambios de sueldo; su cabecera es `NomCseh`. Al confirmar pasa a `NomCse`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
