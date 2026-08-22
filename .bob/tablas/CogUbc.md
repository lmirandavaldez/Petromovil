# CogUbc — Último Balance Conciliado

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Registro del último balance conciliado por banco. Almacena el saldo del último estado de cuenta bancario conciliado, usado como punto de partida para la siguiente conciliación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 UBCBCE         4     11      8   2    P   ULTIMO BALANCE CONCILIADO                 ULTIMO_BALANCE_CONCILIADO
 APLHOR        12     15      4   0    P   HORA QUE SE APLICO                        HORA_QUE_SE_APLICO
 APLDIA        16     17      2   0    P   DIA QUE SE APLICO                         DIA_QUE_APLICO
 APLMES        18     19      2   0    P   MES QUE APLICO                            MES_QUE_APLICO
 APLANO        20     22      3   0    P   ANO QUE APLICO                            ANO_QUE_APLICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — banco |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogBan | — | Banco |
| — | CogCbah | — | Última conciliación |

---

## Observaciones

- Punto de partida para cada proceso de conciliación bancaria.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
