# SegCia — Tabla de Compañías

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Catálogo maestro de compañías del sistema. Define las empresas o unidades de negocio habilitadas y sus parámetros generales.

---

## Campos
------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 CIACVE         1      2      2        A   NRO. COMPA#IA                             CODIGO_DE_LA_EMPRESA
 CIANOM         3     42     40        A   NOMBRE                                    RAZON_SOCIAL
 CIACAL        43     82     40        A   CALLE                                     CALLE
 CIASEC        83    112     30        A   SECTOR                                    SECTOR
 CIACIU       113    142     30        A   CIUDAD                                    CIUDAD
 CIAEST       143    172     30        A   ESTADO                                    ESTADO
 CIAPAI       173    202     30        A   PAIS                                      PAIS
 CIACPO       203    212     10        A   CODIGO POSTAL                             CODIGO_POSTAL
 CIAALE       213    252     40        A   CALLES ALEDANAS                           CALLE_ALEDANAS
 CIARNC       253    267     15        A   REGISTRO FISCAL                           REGISTRO_FISCAL
 CIANSS       268    282     15        A   INSCRIPCION SEGURO SOCIAL                 INSCRIPCION_SEGURO_SOCIAL
 CIAGIR       283    322     40        A   GIRO DE LA EMPRESA                        GIRO_DE_LA_EMPRESA
 CIADIN       323    362     40        A   DIRECCION INTERNET                        DIRECCION_INTERNET
 CIADEM       363    402     40        A   DIRECCION E-MAIL                          DIRECCION_E_MAIL
 CIAMIN       403    404      2   0    P   MES INICIAL PERIODO FISCAL                MES_INICIO_PERIODO_FISCAL
 CIAMFI       405    406      2   0    P   MES FINAL PERIODO FISCAL                  MES_FINAL_PERIODO_FISCAL
 CIALIB       407    414      8        A   NOMBRE DE LA LIBRERIA                     NOMBRE_DE_LA_LIBRERIA
 PRVCVE       415    416      2   0    P   CODIGO DE PROVINCIA                       CODIGO_DE_PROVINCIA
 MUNCVE       417    418      2   0    P   CODIGO DEL MUNICIPIO                      CODIGO_DEL_MUNICIPIO
 DMSCVE       419    420      2   0    P   CODIGO DEL DISTRITO MUNICIPAL             CODIGO_DEL_DISTRITO_MUNICIPAL
 DMSCPO       421    424      4   0    P   CODIGO POSTAL                             CODIGO_POSTAL_DM
 DMSSEC       425    426      2   0    P   SECUENCIA  DISTRITO MUNICIPAL             SECUENCIA_DISTRITO_MUNICIPAL

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria — código de compañía |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegUsr | — | Usuarios de la compañía |
| — | SegCiu | — | Usuarios por compañía |

---

## Observaciones

- Tabla central del módulo de seguridad; la mayoría de tablas del sistema la referencian.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
