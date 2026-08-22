# CogBan — Maestro de Bancos

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Catálogo maestro de bancos del sistema contable. Define las instituciones bancarias con las que opera la empresa, sus cuentas y parámetros de conciliación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 BANNOM         4     38     35        A   NOMBRE                                    NOMBRE_DEL_BANCO
 BANDI1        39     63     25        A   DIRECCION 1                               DIRECCION_DEL_BANCO_1
 BANDI2        64     88     25        A   DIRECCION 2                               DIRECCION_DEL_BANCO_2
 BANDI3        89    113     25        A   DIRECCION 3                               DIRECCION_DEL_BANCO_3
 BANSUC       114    148     35        A   NOMBRE SUCURSAL                           NOMBRE_DE_LA_SUCURSAL
 BANCTA       149    173     25        A   CUENTA BANCARIA                           CUENTA_BANCARIO
 BANCON       174    177      4   0    P   CONTADOR DE CHEQUE                        CONTADOR_DEL_CHEQUE
 BANRUT       178    192     15        A   RUTEO                                     RUTEO
 BANFCH       193    193      1        A   FORMATO DE CHEQUE                         FORMATO_DEL_CHEQUE
 BANEMI       194    194      1        A   EMISION DE CHEQUE S o N                   EMISION_DE_CHEQUE_S_N
 CTACVE       195    212     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXCVE       213    216      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de banco |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDgb | — | Datos generales del banco |
| — | CogCta | — | Cuenta contable asociada |

---

## Observaciones

- Tabla maestra de bancos; base para los procesos de conciliación bancaria.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
