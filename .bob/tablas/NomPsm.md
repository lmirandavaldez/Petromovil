# NomPsm — Plan de Seguro Médico

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Planes de seguro médico. Define los planes de salud disponibles para los empleados, con sus coberturas, primas y condiciones de afiliación.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 PSMCVE         1      3      3   0    P   CODIGO DE SEGURO                          CODIGO_SEGURO
 PSMDES         4     33     30        A   DESCRIPCION                               DESCR_SEGURO
 PSMVEM        34     40      7   2    P   CUOTA EMPLEADO                            CUOTA_EMPLEADO_SEGURO
 PSMVPA        41     47      7   2    P   CUOTA PATRONAL                            CUOTA_PATRONAL_SEGURO
 CMCCVE        48     50      3   0    P   CODIGO DE CONCEPTO                        CODIGO_CONCEPTO_CM
 PSMCDP        51     51      1        A   CALCULAR POR DEPENDIENTE                  CALCULAR_POR_DEPENDIENTE
 PSMNRC        52     71     20        A   NRO. CONTRATO                             NRO_CONTRATO
 PSMCON        72     91     20        A   CONTACTO  SEGURO                          CONTACTO_SEGURO
 PSMTEL        92    111     20        A   TELEFONO CONTACTO                         TELEFONO_CONTACTO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de plan |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomRes | — | Relación empleado-plan de seguro |
| — | NomEmp | — | Empleados afiliados |

---

## Observaciones

- Catálogo de planes de seguro médico; ver `NomRes` para la afiliación por empleado.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
