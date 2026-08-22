# NomRaz — Razones de Salida del Empleado

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de razones de salida de empleados. Define los motivos de desvinculación laboral (renuncia, despido, jubilación, etc.) utilizados en los procesos de liquidación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 RAZCVE         1      2      2   0    P   RAZON DE SALIDA                           RAZON_SALIDA
 RAZDES         3     32     30        A   DESCRIPCION RAZON                         DESCRIPCION_RAZON
 RAZDCO        33     42     10        A   DESCRIPCION CORTA                         DESCRIPCION_CORTA_RAZON

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de razón |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomLqc | — | Liquidación de empleados |
| — | NomEmp | — | Empleado desvinculado |

---

## Observaciones

- Catálogo de causales de desvinculación según Código Laboral dominicano.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
