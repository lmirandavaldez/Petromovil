# CogRfd — Detalle Razones Financieras

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de las razones financieras. Contiene la fórmula y las cuentas que intervienen en el cálculo de cada razón financiera (liquidez, solvencia, rentabilidad, etc.).

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RAZCVE         1      2      2   0    P   NRO. DE RAZON                             NUMERO_DE_RAZON
 RFVCVE         3      4      2   0    P   SECUENCIA VARIABLE                        NUMERO_DE_VARIABLE
 RFDCVE         5      7      3   0    P   NRO. DETALLE                              NUMERO_DETALLE_RAZON_FINANCIE
 CTACVE         8     25     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CCOCVE        26     35     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 AUXCVE        36     39      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogRfh | — | Cabecera de razón financiera |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Detalle de la fórmula de cada razón financiera; su cabecera es `CogRfh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
