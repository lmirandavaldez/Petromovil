# NomTratxt — Archivo Plano Importar Transacciones Externas

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física (archivo plano / tabla de importación)  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Archivo plano para importar transacciones externas. Define la estructura del archivo de texto utilizado para importar masivamente transacciones de nómina desde sistemas externos.

---

## Campos

-----------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DATOS01        1    300    300        A   REGISTRO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTrae | — | Transacciones externas procesadas |

---

## Observaciones

- Estructura del archivo plano de importación de transacciones externas de nómina.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
