# CogRfv — Razones Financieras Variables

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Variables de las razones financieras. Define los valores parametrizables que intervienen en el cálculo de las razones financieras para permitir su ajuste sin modificar las fórmulas base.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RAZCVE         1      2      2   0    P   NRO. DE RAZON                             NUMERO_DE_RAZON
 RFVCVE         3      4      2   0    P   SECUENCIA VARIABLE                        NUMERO_DE_VARIABLE
 RFVDES         5     44     40        A   DESCRIPCION                               DESCRIPCION_VARIABLE_RAZON
 RFVRES        45     59     15        A   DESCRIPCION DEL RESULTADO                 DESCRIPCION_DEL_RESULTADO
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta razón + variable |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRfh | — | Cabecera razón financiera |

---

## Observaciones

- Variables parametrizables para el cálculo de razones financieras.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
