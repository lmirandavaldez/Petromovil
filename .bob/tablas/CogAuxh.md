# CogAuxh — Cabecera Lista de Auxiliares

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Cabecera de la lista de cuentas auxiliares contables. Agrupa los auxiliares por cuenta y período para el seguimiento detallado de movimientos.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AUXLIS         1      2      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXDES         3     42     40        A   DESCRIPCION                               DESCRIPCION_LISTA_AUXILIAR
 AUXUNR        43     46      4   0    P   ULTIMO NRO. UTILIZADO                     ULTIMO_NRO_UTILIZADO
 AUXFOL        47     47      1        A   UTILIZA FOLIADOR                          UTILIZA_FOLIADOR
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogAuxd | — | Detalles de auxiliares |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Tabla de cabecera; su detalle correspondiente es `CogAuxd`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
