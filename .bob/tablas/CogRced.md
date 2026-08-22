# CogRced — Definitivo Relación Cliente Empleado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación definitiva entre cuentas contables y clientes/empleados. Almacena la asignación confirmada de cuentas a terceros específicos (clientes o empleados) para el detalle de las cuentas por cobrar/pagar.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 SECCVE         1      4      4   0    P   NUMERO SOLICITUD DE CHEQUE                NUMERO_DE_SOLICITUD_CHEQUE
 SECSEC         5      6      2   0    P   SECUENCIA                                 SECUENCIA_DEL_REGISTRO_SOLICI
 BANCVE         7      9      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 SECTTR        10     10      1   0    P   TIPO DE TRANSACCION                       TIPO_TRANSACCION
 CHETDI        11     12      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO_CKS
 BANNCH        13     16      4   0    P   NUMERO DEL CHEQUE                         NUMERO_DEL_CHEQUE
 PERANO        17     19      3   0    P   ANO PERIODO                               ANO_PERIODO_CONTABLE
 PERNUM        20     21      2   0    P   NUMERO PERIODO                            NUMERO_PERIODO_CONTABLE
 CTACVE        22     39     18        A   CUENTA CONTABLE                           NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        40     41      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        42     45      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        46     55     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 MONCVE        56     57      2   0    P   CODIGO DE MONEDA                          CODIGO_DE_MONEDA
 SECDES        58     97     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOV_DE_SOLICI
 SECVAL        98    103      6   2    P   VALOR DEL MOVIMIENTO                      VALOR_DEL_MOVIMIENTO_SOLICITU
 SECORI       104    104      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_CONT_DEBITO_CREDITO
 RCETIP       105    105      1        A   TIPO DE DATOS                             TIPO_DE_DATOS_FACA
 RCECIA       106    108      3        A   CODIGO DE COMPANIA COP                    CODIGO_DE_COMPANIA_COP
 RCECEM       109    111      3   0    P   CODIGO EMPLEADO                           CODIGO_DE_EMPLEADO_FACA
 RCECCL       112    117      6        A   CODIGO CLIENTE O EMPLEADO                 COD_CLIENTE_O_EMPLEADO_FACA
 RCESTA       118    118      1        A   STATUS DEL PROCESO                        STATUS_DEL_PROCESO_FACA

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cuenta + tercero |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRcec | — | Relación cuenta tipo cliente/empleado |
| — | CogRcet | — | Temporal relación cliente/empleado |

---

## Observaciones

- Versión definitiva de la relación cuenta-tercero; ver `CogRcet` para la temporal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
