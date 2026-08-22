# NomBan — Instituciones Financieras

**Biblioteca:** NOMLIB  
**Tipo:** Tabla física  
**Módulo:** NOM — Nómina de Pago  
**Descripción:** Catálogo de instituciones financieras para nómina. Define los bancos y entidades financieras a través de los cuales se realizan los pagos de nómina a los empleados.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 BANCVE         1      3      3   0    P   CODIGO DEL BANCO                          CODIGO_DEL_BANCO
 BANDES         4     33     30        A   DESCRIPCION DEL BANCO                     DESCRIPCION_DEL_BANCO
 BANIDE        34     36      3   0    P   IDENTIFICACION DE LA EMPRESA              IDENTIFICACION_DE_LA_EMPRESA
 PRNPGM        37     46     10        A   PROGRAMA EN EJECUCION                     PROGRAMA_EJECUTAR
 BANCDB        47     61     15        A   CUENTA A DEBITAR EN TRANSF.               CUENTA_DEBITAR_TRANSFERENCIA
 BANEMA        62    111     50        A   DIRECCION EMAIL                           DIRECCION_EMAIL_ENVIO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de banco |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | NomEmp | — | Empleados con cuenta en este banco |

---

## Observaciones

- Catálogo de bancos para transferencias de nómina; ver `NomBhd`, `NomBpd`, `NomBpr` para archivos específicos por banco.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
