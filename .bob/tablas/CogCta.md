# CogCta — Plan de cuentas contables

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
 CTACVE         1     18     18        A   NUMERO CUENTA CONTABLE                    NUMERO_DE_CUENTA_CONTABLE
 CTADES        19     63     45        A   NOMBRE DE LA CUENTA                       DESCRIPCION_CUENTA_CONTABLE
 CTADCO        64     78     15        A   NOMBRE CORTO                              NOMBRE_CORTO_CUENTA_CONTABLE
 CTATIP        79     79      1   0    P   TIPO DE CUENTA                            TIPO_DE_CUENTA_CONTABLE
 CTAMAU        80     80      1        A   MANEJA AUXILIAR                           MANEJA_LISTA_AUXILIAR
 CTAMCC        81     81      1        A   MANEJA CENTRO DE COSTOS                   MANEJA_CENTRO_DE_COSTO
 CTAAFE        82     99     18        A   CUENTA QUE AFECTA                         NUMERO_CUENTA_AFECTA
 GRUCVE       100    101      2   0    P   CLAVE DE GRUPO                            CLAVE_DE_GRUPO
 AUXLIS       102    103      2   0    P   NUMERO LISTA AUXILIAR                     NUMERO_LISTA_AUXILIAR
 CTAORI       104    104      1   0    P   ORIGEN DE LA CUENTA                       ORIGEN_DE_LA_CUENTA_CONTABLE
 CTACAC       105    105      1        A   CODIGO DE ACTUALIZACION                   CODIGO_DE_ACTULIZACION
 CREUSR       106    115     10        A   USUARIO QUE CREO REGISTRO                 USUARIO_QUE_CREO_REGISTRO
 CREWSI       116    125     10        A   TERMINAL DONDE SE CREO                    TERMINAL_DONDE_SE_CREO
 CRETST       126    151     26   0    Z   FECHA QUE SE CREO                         FECHA_QUE_SE_CREO
 MODUSR       152    161     10        A   USUARIO MODIFICO REGISTRO                 USUARIO_MODIFICO_REGISTRO
 MODWSI       162    171     10        A   TERMINAL DONDE SE MODIFICO                TERMINAL_DONDE_SE_MODIFICO
 MODTST       172    197     26   0    Z   FECHA QUE SE MODIFICO                     FECHA_QUE_SE_MODIFICO

---

## Claves e Índices

| Tipo | Campos | Descripción |
|------|--------|-------------|
| PK | (campo) | Clave principal |

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
