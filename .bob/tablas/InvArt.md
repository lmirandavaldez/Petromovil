# InvArt — Artículos / Inventario maestro

**Biblioteca:** DATOS02  
**Tipo:** Tabla física  
**Módulo:** (completar)  
**Descripción:** (completar)

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 ARTCVE         1     20     20        A   CODIGO DE ARTICULO                        CODIGO_DE_ARTICULO
 ARTDES        21     60     40        A   DESCRIPCION                               DESCRIPCION_DEL_ARTICULO
 MARCVE        61     63      3   0    P   CLAVE MARCA                               CODIGO_DE_MARCA
 CATCVE        64     66      3   0    P   CLAVE CATEGORIA                           CODIGO_DE_LA_CATEGORIA
 SCACVE        67     69      3   0    P   CLAVE SUB-CATEGORIA                       CODIGO_SUB_CATEGORIA
 ARTCBP        70     85     16        A   CODIGO BARRA UNIDAD                       CODIGO_BARRA_UNIDAD
 ARTCBC        86    101     16        A   CODIGO BARRA CAJA                         CODIGO_BARRA_CAJA
 ARTUAL       102    104      3   0    P   CODIGO UNIDAD ALMACENAMIENTO              CODIGO_UNIDAD_ALMACENAMIENTO
 ARTCUA       105    109      5   2    P   CONTENIDO UND.ALMACENAMIENTO              CONTENIDO_UNIDAD_ALMACENAMIEN
 ARTUVE       110    112      3   0    P   CODIGO UND.VENTA                          CODIGO_UNIDAD_VENTA
 ARTCUV       113    117      5   2    P   CONTENIDO UND.VENTA                       CONTENIDO_UNIDAD_VENTA
 ARTMER       118    118      1        A   MERCADO DEL PRODUCTO                      MERCADO_DEL_PRODUCTO
 PAICVE       119    121      3   0    P   PAIS DE ORIGEN                            CODIGO_PAIS_ORIGEN
 ARTRPD       122    122      1        A   REQUIERE PESO AL DESPACHAR?               REQUIERE_PESO_AL_DESPACHAR
 ARTPPR       123    123      1        A   PRODUCTO CON PRECIO REGULADO              PRODUCTO_CON_PRECIO_REGULADO
 ARTMCE       124    124      1        A   MANEJA CONTROL DE EXISTENCIA              MANEJA_CONTROL_DE_EXISTENCIA
 ARTPER       125    125      1        A   ES PERECEDERO SI O NO                     ES_PERECEDERO_SI_O_NO
 ARTIMP       126    126      1        A   PAGA IMPUESTO?                            PAGA_IMPUESTOS
 ARTPRE       127    136     10        A   PRESENTACION                              PRESENTACION
 TIICVE       137    137      1   0    P   TIPO DE INVENTARIO                        TIPO_DE_INVENTARIO
 ARTPML       138    144      7   3    P   PRECIO BASE MONEDA LOCAL                  PRECIO_VENTA_BASES_MONE_LOCAL
 ARTPME       145    151      7   3    P   PRECIO BASE MONEDA EXTRANJE RA            PRECIO_VENTA_BASES_MONE_EXTRA
 ARTCLA       152    152      1        A   CLASIFICACION DEL ARTICULO                CLASIFICACION_A_B_C
 ARTVOL       153    158      6   5    P   VOLUMEN C/U                               VOLUMEN_C_U
 ARTPBE       159    164      6   5    P   PESO BRUTO POR EMPAQUE                    PESO_BRUTO_POR_EMPAQUE
 ARTPNE       165    170      6   5    P   PESO NETO POR EMPAQUE                     PESO_NETO_POR_EMPAQUE
 ARTPBP       171    176      6   5    P   PESO BRUTO DEL PRODUCTO                   PESO_BRUTO_DEL_PRODUCTO
 ARTPNP       177    182      6   5    P   PESO NETO CONTENIDO PRODUCTO              PESO_NETO_CONTENIDO_PRODUCTO
 ARTLON       183    187      5   0    P   LONGITUD EN M.M.                          LONGITUD_EN_M_M
 ARTALT       188    192      5   0    P   ALTURA EN M.M.                            ALTURA_EN_M_M
 ARTPRO       193    197      5   0    P   PROFUNDIDAD EN M.M.                       PROFUNDIDAD_EN_M_M
 ARTCPA       198    200      3   0    P   CONTENIDO DE LA PALETA                    CONTENIDO_DE_LA_PALETA
 ARTAMP       201    203      3   0    P   ALTURA MAXIMA PALETA                      ALTURA_MAXIMA_PALETA
 ARTCPL       204    211      8   6    P   COSTO PROMEDIO MONEDA LOCAL               COSTO_PROMEDIO_MONEDA_LOCAL
 ARTCUL       212    219      8   6    P   COSTO ULT. MONEDA LOCAL                   COSTO_ULT_MONEDA_LOCAL
 ARTCPU       220    227      8   6    P   COSTO PROMEDIO EN DOLAR                   COSTO_PROMEDIO_EN_DOLAR
 ARTCUU       228    235      8   6    P   COSTO ULT. EN DOLAR                       COSTO_ULT_EN_DOLAR
 ARTCST       236    243      8   6    P   COSTO STANDARD                            COSTO_STANDARD
 ARTCMI       244    250      7   2    P   CANTIDAD MINIMA                           CANTIDAD_MINIMA
 ARTCMA       251    257      7   2    P   CANTIDAD MAXIMA                           CANTIDAD_MAXIMA
 ARTCRE       258    264      7   2    P   PUNTO DE RE-ORDEN                         PUNTO_DE_RE_ORDEN
 ARTCTR       265    271      7   2    P   CANTIDAD EN TRANSITO                      CANTIDAD_EN_TRANSITO
 ARTTLL       272    273      2   0    P   TIEMPO DE LLEGADA EN DIAS                 TIEMPO_DE_LLEGADA_EN_DIAS
 ARTRCO       274    274      1        A   REQUERIMIENTO DE COMPRA                   REQUERIMIENTO_DE_COMPRA
 ARTDCR       275    276      2   0    P   DIA CREACION                              DIA_CREACION
 ARTMCR       277    278      2   0    P   MES CREACION                              MES_CREACION
 ARTACR       279    281      3   0    P   ANO CREACION                              ANO_CREACION


---

## Claves e Índices

| Tipo | Campos | Descripción        |
|------|--------|--------------------|
| PK   | ARTCVE | CODIGO_DE_ARTICULO |

---

## Relaciones

| Campo local | Tabla relacionada | Campo FK | Descripción |
|-------------|-------------------|----------|-------------|
| (completar) | | | |

---

## Observaciones

(Completar con comportamientos especiales, reglas de negocio o advertencias.)

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
