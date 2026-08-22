# CogIef — Grupo de Impresión Estados Financieros

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Grupos de impresión para estados financieros. Define los grupos utilizados para controlar el orden y formato de impresión de los estados financieros.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 IEFCVE         1      2      2   0    P   NRO. DE GRUPO
 IEFDES         3     52     50        A   DESCRIPCION O TITULO


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de grupo de impresión |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogEfi | — | Estado financiero |
| — | CogIep | — | Programas de impresión |

---

## Observaciones

- Controla el formato y secuencia de impresión de estados financieros.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
