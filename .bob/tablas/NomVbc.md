# NomVbc — Valor de la Base del Cálculo ISR

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Valor de la base del cálculo de ISR. Almacena los valores base utilizados para el cálculo del Impuesto Sobre la Renta (ISR) de empleados, incluyendo los montos exentos y las tasas progresivas vigentes.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 EMPCVE         1      4      4   0    P   CODIGO EMPLEADO                           CODIGO_EMPLEADO
 VBCANO         5      7      3   0    P   ANO DEL CALCULO                           ANO_CALCULO_ISR
 VBCMES         8      9      2   0    P   MES DEL CALCULO                           MES_CALCULO_ISR
 VBCVAL        10     16      7   2    P   VALOR DE LA BASE CALCULO ISR              VALOR_BASE_ISR
 VBCVTE        17     23      7   2    P   V/BASE CALCULO ISR TEMPORAL               VALOR_BASE_ISR_TEMPORAL
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — año fiscal |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomTbld | — | Tablas de cálculo ISR |

---

## Observaciones

- Base de cálculo del ISR según la escala progresiva de la DGII vigente por año fiscal.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
