# NomCse — Cambios de sueldo / historial

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
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 RCSCVE         5      6      2   0    P   CODIGO DE RAZON CAMBIO                    CODIGO_RAZON_CAMBIO_SUELDO
 CSESAN         7     13      7   2    P   SUELDO ANTERIOR                           SUELDO_ANTERIOR
 CSESAC        14     20      7   2    P   SUELDO ACTUAL                             SUELDO_ACTUAL
 CSEPVA        21     24      4   2    P   % DE VARIACION                            PROCIENTO_VARIACION
 CSEAEF        25     27      3   0    P   ANO DE EFECTIVIDAD                        ANO_EFECTIVIDAD
 CSEMEF        28     29      2   0    P   MES DE EFECTIVIDAD                        MES_EFECTIVIDAD
 CSEDEF        30     31      2   0    P   DIA DE EFECTIVIDAD                        DIA_EFECTIVIDAD
 APLUSR        32     41     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI        42     51     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR        52     55      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA        56     57      2   0    P   DIA QUE SE APLICO                         DIA_QUE_SE_APLICO
 APLMES        58     59      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO        60     62      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO
 CSEOBS        63    112     50        A   OBSERVACION                               OBSERVACION_CAMBIO_SUELDO

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
