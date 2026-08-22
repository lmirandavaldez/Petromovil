# SegUsr — Tabla de Usuarios

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo maestro de usuarios del sistema. Almacena los datos de cada usuario, sus credenciales y parámetros de seguridad para el control de acceso.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 USRCVE         1     10     10        A   USUARIO                                   CODIGO_DEL_USUARIO
 USRCON        11     20     10        A   CONTRASENA                                CONTRASENA_DEL_USUARIO
 USRNOM        21     70     50        A   NOMBRE DEL USUARIO                        NOMBRE_DEL_USUARIO
 USRCDF        71     72      2        A   COMPANIA POR DEFAULT                      COMPANIA_POR_DEFAULT
 USRSDF        73     74      2        A   SISTEMA POR DEFAULT                       SISTEMA_POR_DEFAULT
 USRMDF        75     76      2        A   MENU POR DEFAULT                          MENU_POR_DEFAULT
 USRPRT        77     86     10        A   NOMBRE IMPRESORA                          NOMBRE_IMPRISORA_USR
 USRMAI        87    136     50        A   EMAIL DEL USUARIO                         MAIL_USUARIO
 USRTSP       137    137      1        A   TIPO DE  SPOOL                            TIPO_DE_SPOOL


---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código/nombre de usuario |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCiu | — | Compañías del usuario |
| — | SegUco | — | Relación usuario-compañía |
| — | SegUcs | — | Relación usuario-compañía-sistema |
| — | SegSme | — | Acceso a menús |
| — | SegUpg | — | Programas autorizados |

---

## Observaciones

- Tabla central del módulo de seguridad; referenciada por todas las tablas de relación de acceso.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
