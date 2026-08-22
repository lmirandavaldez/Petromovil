# NomCno — Conceptos / Ciclos de nómina

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
 CNOCVE         1      2      2   0    P   CODIGO CLASE DE NOMINA                    CODIGO_CLASE_NOMINA
 CNODES         3     42     40        A   DESCRIPCION CLASE NOMINA                  DESCRIPCION_CLASE_NOMINA
 CNODLA        43     44      2   1    P   DIAS LABORABLES EN LA SEMANA              DIAS_LABORABLE_SEMANAL
 CNOHRS        45     46      2   1    P   HORAS LABORABLES A LA SEMANA              HORAS_LABORABLE_SEMANAL
 CNOFPA        47     47      1   0    P   FRECUENCIA DE PAGO                        FRECUENCIA_PAGO
 CNOCIP        48     49      2   0    P   CICLOS DE PAGO ANUAL                      CANT_CICLOS_ANUAL
 CNOPAN        50     52      3   2    P   PORCIENTO DE ANTICIPO                     PORCIENTO_ANTICIPO
 CNOISR        53     53      1   0    P   PERIODO DE PAGO ISR                       PERIODO_PAGO_ISR
 CNOUCA        54     55      2   0    P   ULTIMO CICLO ACTUALIZDO                   ULTIMO_CICLO_ACTUALIZADO
 CNOUAA        56     58      3   0    P   ULTIMO ANO ACTUALIZDO                     ULTIMO_ANO_ACTUALIZADO
 CNOTSS        59     60      2   0    P   CODIGO NOMINA TSS                         CODIGO_NOMINA_TSS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK   |  CNOCVE| CODIGO CLASE DE NOMINA 


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
