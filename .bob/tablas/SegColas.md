# SegColas — Tabla para Colas de Datos

**Biblioteca:** SEGLIB  
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Administración de colas de datos del sistema. Controla el procesamiento asíncrono y la comunicación entre procesos mediante colas.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 COLNRO         1      4      4   0    S   CODIGO DE COLA                            CODIGO_COLA
 COLENT         5     52     48        A   NOMBRE DE LA COLA                         NOMBRE_DE_LA_COLA
 COLLIB        53     62     10        A   LIBRERIA                                  NOMBRE_DE_LA_LIBRERIA
 COLLNG        63     65      3   0    P   LONGITUD                                  LONGITUD
 COLWAI        66     70      5   0    S   TIEMPO DE ESPERA                          TIEMPO_DE_ESPERA
 COLORI        71     71      1        A   ORIGEN                                    ORIGEN
 COLTIP        72     72      1        A   TIPO                                      TIPO
 COLDES        73    132     60        A   DESCRIPCION DE LA COLA                    DESCRIPCION_DE_LA_COLA



---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | — | Clave primaria |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| — | SegCia | — | Compañía propietaria de la cola |

---

## Observaciones

- Utilizada para gestionar procesos en cola y comunicación asíncrona entre módulos.
- **Campos de fecha:** Los campos tipo DECIMAL 8,0 almacenan fechas en formato AAAAMMDD.
  Para convertirlos a DATE usar `LEFT JOIN SegFec ON tabla.campo = SegFec.FecYmd`
  con centinela `DATE('1900-01-01')` cuando la fecha no exista en SegFec.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
