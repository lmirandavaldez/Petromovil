# NomBoe — Exclusión Empleados Bonificación

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Empleados excluidos del proceso de bonificación. Registra los empleados que, por alguna razón justificada, quedan excluidos del cálculo o pago de la bonificación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BONANO         1      3      3   0    P   ANO PERTENECE BONOS                       ANO_PERTENECE_BONOS
 EMPCVE         4      7      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + período bonificación |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado excluido |
| — | NomBon | — | Corte de bonificación |

---

## Observaciones

- Lista de exclusiones para el proceso de bonificación anual.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
