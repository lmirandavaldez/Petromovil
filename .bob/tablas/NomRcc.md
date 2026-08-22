# NomRcc — Relación Concepto, Centro de Costo, Cuenta

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Relación entre concepto de nómina, centro de costo y cuenta contable. Define cómo se distribuyen contablemente los conceptos de nómina según el centro de costo del empleado.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CMCCVE         1      3      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 CTACVE         4     21     18        A   NUMERO CUENTA CONTABLE                    NUMERO_CUENTA_CONTABLE
 AUXCVE        22     25      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CMCCGA        26     43     18        A   CUENTA GASTOS APORTE PATRON               CUENTA_GASTOS_APORTE_PATRON
 CMCAGA        44     47      4   0    P   AUXIL. GASTOS APORTE PATRON               AUXILIAR_GASTOS_APORTE_PATRON
 CCOCVE        48     57     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_DE_CENTRO_COSTOS

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta concepto + centro de costo |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |
| — | CogCco | — | Centro de costos |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Tabla de integración nómina-contabilidad por concepto y centro de costo.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
