# CogAuxd — Detalles Lista de Auxiliares

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalle de la lista de cuentas auxiliares contables. Contiene el desglose de cada auxiliar asociado a las cuentas del catálogo contable.

---

## Campos
------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 AUXLIS         1      2      2   0    P   NUMERO DE LISTA                           NUMERO_LISTA_AUXILIAR
 AUXCVE         3      6      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 AUXNOM         7     46     40        A   NOMBRE AUXILIAR                           NOMBRE_DEL_AUXILIAR
 AUXSTA        47     47      1        A   STATUS DEL AUXILIAR                       STATUS_DEL_AUXILIAR

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + secuencia |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogAuxh | — | Cabecera de lista de auxiliares |
| — | CogCta | — | Cuenta contable |

---

## Observaciones

- Tabla de detalle; su cabecera correspondiente es `CogAuxh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
