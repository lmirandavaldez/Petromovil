# NomConc — Concepto Pagan ISR - Liquidación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Conceptos que pagan ISR en liquidación. Define los conceptos de nómina que están sujetos al cálculo del ISR en los procesos de liquidación de empleados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CMCCVE         1      3      3   0    P   CONCEPTO                                  CODIGO_CONCEPTO_CM
 ISRPGO         4      4      1        A   ISR PAGO                                  PAGA_ISR
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — concepto |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomCmc | — | Concepto de nómina |

---

## Observaciones

- Define qué conceptos generan retención de ISR en procesos de liquidación.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
