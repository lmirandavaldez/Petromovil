# NomDem — Dependientes de Empleados

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Dependientes de empleados. Almacena los datos de los dependientes (cónyuge, hijos, etc.) de cada empleado, utilizados para el cálculo de deducciones familiares de ISR y beneficios de seguro médico.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 DEMNRO         5      6      2   0    P   NUMERO DE DEPENDIENTE                     NUMERO_DEPENDIENTE
 DEMNOM         7     36     30        A   NOMBRES DEPENDIENTE                       NOMBRE_DEPENDIENTE
 DEMSEX        37     37      1        A   SEXO                                      SEXO_DEPENDIENTE
 DEMPAR        38     47     10        A   PARENTESCO                                PARENTESCO
 DEMTSA        48     51      4        A   TIPO DE SANGRE                            TIPO_DE_SANGRE_DEP
 DEMANA        52     54      3   0    P   ANO DE NACIMIENTO                         ANO_NACIMIENTO_DEP
 DEMMNA        55     56      2   0    P   MES DE NACIMIENTO                         MES_NACIMIENTO_DEP
 DEMDNA        57     58      2   0    P   DIA DE NACIMIENTO                         DIA_NACIMIENTO_DEP
 DEMCA1        59     73     15        A   NUMERO CARNET SEGURO 1                    NRO_CARNET_1
 DEMCA2        74     88     15        A   NUMERO CARNET SEGURO 2                    NRO_CARNET_2

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta empleado + dependiente |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleado titular |

---

## Observaciones

- Datos de dependientes para deducciones de ISR y cobertura de seguro médico.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
