# NombreTabla — Descripción corta de la tabla

**Biblioteca:** DATOS02  
**Tipo:** Tabla física (PF) / Vista (LF) / Tabla SQL  
**Módulo:** NOM / SEG / COG / INV / ...  
**Descripción:** Descripción detallada del propósito de esta tabla en el sistema.

---

## Campos

| Campo | Tipo | Long | Dec | Descripción | Notas |
|-------|------|------|-----|-------------|-------|
| CmpCve | CHAR | 7 | — | Clave primaria | PK |
| CmpNom | CHAR | 40 | — | Descripción / Nombre | |
| CmpFec | DECIMAL | 8 | 0 | Fecha en formato AAAAMMDD | Usar LEFT JOIN SegFec para convertir a DATE |
| CmpImp | DECIMAL | 13 | 2 | Importe / Monto | |
| CmpSts | CHAR | 1 | — | Estado: A=Activo, I=Inactivo | |

> Completar con todos los campos reales de la tabla.

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | CmpCve | Clave primaria |
| IX1 | CmpNom | Índice por nombre |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| DepCve | NomDep | DepCve | Departamento al que pertenece |
| CmcCve | NomCmc | CmcCve | Centro de costo de nómina |

---

## Observaciones

- Anotar aquí comportamientos especiales, reglas de negocio o advertencias.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.
- Anotar campos calculados, derivados o de uso especial.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
