# NomCip — Comprobantes individuales de pago

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
 TNOCVE         3      4      2   0    P   CODIGO TIPO DE NOMINA                     CODIGO_TIPO_NOMINA
 CIPANO         5      7      3   0    P   ANO CICLO                                 ANO_CICLO
 CIPNUM         8      9      2   0    P   NUMERO DE CICLO                           NUMERO_CICLO
 CIPAIN        10     12      3   0    P   ANO INICIAL CICLO                         ANO_INICIO_CICLO
 CIPMIN        13     14      2   0    P   MES INICIAL CICLO                         MES_INICIO_CICLO
 CIPDIN        15     16      2   0    P   DIA INICIAL CICLO                         DIA_INICIO_CICLO
 CIPAFC        17     19      3   0    P   ANO FINAL CICLO                           ANO_FINAL_CICLO
 CIPMFC        20     21      2   0    P   MES FINAL CICLO                           MES_FINAL_CICLO
 CIPDFC        22     23      2   0    P   DIA FINAL CICLO                           DIA_FINAL_CICLO
 CIPAPG        24     26      3   0    P   ANO DE PAGO                               ANO_PAGO_CICLO
 CIPMPG        27     28      2   0    P   MES PAGO CICLO                            MES_PAGO_CICLO
 CIPDPG        29     30      2   0    P   DIA PAGO CICLO                            DIA_PAGO_CICLO
 CIPFEP        31     65     35        A   FECHA EXTENDIDA DE PAGO                   FECHA_EXTENDIDA_PAGO
 CIPSOQ        66     66      1   0    P   NRO DE SEMANA O QUINCENA MES              NRO_SEMANA_O_QUINCENA
 CIPAAC        67     69      3   0    P   ANO QUE ACUMULAR                          ANO_QUE_ACUMULA
 CIPMAC        70     71      2   0    P   MES QUE ACUMULA                           MES_QUE_ACUMULA
 CIPPR0        72     72      1   0    P   PERIODICIDAD 0                            PERIODICIDAD_0
 CIPPR1        73     73      1   0    P   PERIODICIDAD 1                            PERIODICIDAD_1
 CIPPR2        74     74      1   0    P   PERIODICIDAD 2                            PERIODICIDAD_2
 CIPPR3        75     75      1   0    P   PERIODICIDAD 3                            PERIODICIDAD_3
 CIPPR4        76     76      1   0    P   PERIODICIDAD 4                            PERIODICIDAD_4
 CIPPR5        77     77      1   0    P   PERIODICIDAD 5                            PERIODICIDAD_5
 CIPPR6        78     78      1   0    P   PERIODICIDAD 6                            PERIODICIDAD_6
 CIPPR7        79     79      1   0    P   PERIODICIDAD 7                            PERIODICIDAD_7
 CIPPR8        80     80      1   0    P   PERIODICIDAD 8                            PERIODICIDAD_8
 CIPPR9        81     81      1   0    P   PERIODICIDAD 9                            PERIODICIDAD_9
 CIPTPN        82     88      7   2    P   TOTAL PAGADO NOMINA                       TOTAL_PAGADO_NOMINA
 CIPTIF        89     95      7   2    P   TOTAL INFOTEP                             TOTAL_PAGADO_INFOTEP
 CIPCEM        96     98      3   0    P   CANTIDAD DE EMPLEADOS                     TOTAL_EMPLEADOS_CICLO
 CIPSTA        99     99      1        A   STATUS DEL CICLO                          STATUS_CICLO
 APLUSR       100    109     10        A   USUARIO QUE APLICO                        USUARIO_QUE_APLICO
 APLWSI       110    119     10        A   TERMINAL DONDE SE APLICO                  TERMINAL_DONDE_SE_APLICO
 APLHOR       120    123      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA       124    125      2   0    P   DIA QUE SE APLICO                         DIA_QUE_SE_APLICO
 APLMES       126    127      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO       128    130      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO
---

## Claves e Índices

| Tipo 	| Campos | Descripción			|
|-------|--------|------------------------	|
| PK 	| CNOCVE | CODIGO CLASE DE NOMINA	| 
| PK   	| TNOCVE | CODIGO TIPO DE NOMINA	|
| PK	| CIPANO | ANO CICLO   			|
| PK  	| CIPNUM | NUMERO DE CICLO		|



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
