# CogRtu — Relación Tipo Diario y Usuarios

**Biblioteca:** COGLIB  
**Tipo:** Tabla física  
**Módulo:** COG — Contabilidad General  
**Descripción:** Relación entre tipos de diario y usuarios. Controla qué usuarios tienen permiso para registrar asientos en cada tipo de diario contable.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 TDICVE         1      2      2        A   CLAVE DE TIPO DIARIO                      CLAVE_TIPO_DE_DIARIO
 USRCVE         3     12     10        A   ID DE USUARIO                             ID_DEL_USUARIO
 RTUCRE        13     13      1        A   USUARIO PUEDE CREAR                       USUARIO_PUEDE_CREAR
 RTUAPL        14     14      1        A   USUARIO PUEDE APLICAR                     USUARIO_PUEDE_APLICAR
 RTUDTL        15     15      1        A   USUARIO PUEDE BORRAR                      USUARIO_PUEDE_BORRAR
 RTUCNA        16     16      1   0    P   CODIGO NIVEL AUTORIZACION                 CODIGO_NIVEL_AUTORIZACION
 CREUSR        17     26     10        A   USUARIO QUE CREO REGISTRO                 USUARIO_QUE_CREO_REGISTRO
 CREWSI        27     36     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 CRETST        37     62     26   0    Z   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 MODUSR        63     72     10        A   USUARIO MODIFICO REGISTRO                 USUARIO_MODIFICO_REGISTRO
 MODWSI        73     82     10        A   TERMINAL DONDE SE MODIFICO                TERMINAL_DONDE_SE_MODIFICO
 MODTST        83    108     26   0    Z   FECHA QUE SE MODIFICO                     FECHA_QUE_SE_MODIFICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave compuesta tipo de diario + usuario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | CogTdi | — | Tipo de diario |
| — | SegUsr | — | Usuario |

---

## Observaciones

- Control de acceso por tipo de diario para cada usuario del módulo COG.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
