# CogDcdd — Detalles Distribución Contable Pre-Definida

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Detalles de las distribuciones contables pre-definidas. Contiene el desglose de cuentas y porcentajes de cada plantilla de distribución contable predefinida.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 DCDCVE         1      3      3   0    P   CODIGO DISTRIBUCION CONTABLE              CODIGO_DISTRIBUCION_CONTABLE
 DGESEC         4      6      3   0    P   SECUENCIA                                 SECUENCIA
 CTACVE         7     24     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 AUXLIS        25     26      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 AUXCVE        27     30      4   0    P   CLAVE AUXILIAR                            CLAVE_AUXILIAR
 CCOCVE        31     40     10        A   CLAVE DE CENTRO COSTOS                    CLAVE_CENTRO_DE_COSTO
 DGEDE1        41     80     40        A   DESCRIPCION DEL MOVIMIENTO                DESCRIPCION_DEL_MOVIMIENTO
 RGCPOR        81     83      3   2    P   PORCIENTO A DISTRIBUIR                    PORCIENTO_A_DISTRIBUIR
 DGEORI        84     84      1   0    P   ORIGEN CONT. DEBITO/CREDITO               ORIGEN_DEL_MOVIMIENTO
 DGEERR        85     86      2   0    P   CODIGO DE ERROR                           CODIGO_DE_ERROR
---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta cabecera + línea |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogDcdh | — | Cabecera distribución pre-definida |
| — | CogCta | — | Cuenta contable destino |

---

## Observaciones

- Detalle de plantillas de distribución contable; su cabecera es `CogDcdh`.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
