# CogRue — Relación Usuario-Estado Financiero

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre usuarios y estados financieros. Controla qué usuarios tienen acceso para visualizar o imprimir cada estado financiero configurado en el sistema.

---

## Campos

-----------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 USRCVE         1     10     10        A   COD. USUARIO                              ID_DEL_USUARIO
 EFICVE        11     12      2   0    P   COD. ESTADO FINCIERO                      NUMERO_DE_ESTADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta usuario + estado financiero |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUsr | — | Usuario |
| — | CogEfi | — | Estado financiero |

---

## Observaciones

- Control de acceso a estados financieros por usuario.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
