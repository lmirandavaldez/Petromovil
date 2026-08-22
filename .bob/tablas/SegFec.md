# SegFec — Tabla de Fechas (Calendario)

**Biblioteca:** SEGLIB
**Tipo:** Tabla física  
**Módulo:** SEG — Seguridad / Tablas Generales  
**Descripción:** Calendario corporativo. Contiene una fila por cada fecha válida del sistema.
Es la tabla central para convertir fechas numéricas (DECIMAL 8,0) a tipo DATE en DB2 for i,
y para validar si una fecha construida por concatenación de campos existe y es válida.

---

## Campos

------------------------------------------------------------------------------------------------------------------------------------
                                 Pos. Tipo
 Campo      Desde  Hasta  Long.  Dec. Campo Descripcion del campo                     Alias del Campo
------------------------------------------------------------------------------------------------------------------------------------
 FECISO         1     10     10   0    L   FECHA TIPO ISO                            FECHA_TIPO_ISO
 FECEUR        11     20     10   0    L   FECHA TIPO Eur                            FECHA_TIPO_EUR
 FECUSA        21     30     10   0    L   FECHA TIPO Usa                            FECHA_TIPO_USA
 FECJUL        31     36      6   0    L   FECHA TIPO Jul                            FECHA_TIPO_JUL
 FECYMD        37     41      5   0    P   FECHA TIPO AAAAMMDD                       FECHA_TIPO_AAAAMMDD
 FECDMY        42     46      5   0    P   FECHA TIPO DDMMAAAA                       FECHA_TIPO_DDMMAAAA
 FECMDY        47     51      5   0    P   FECHA TIPO MMDDAAAA                       FECHA_TIPO_MMDDAAAA
 FECDYY        52     53      2   0    P   DIA DEL ANO                               DIA_DEL_ANO
 FECFAM        54     57      4   0    P   ANO MES DE LA FECHA                       ANO_MES_DE_LA_FECHA
 FECANO        58     60      3   0    P   ANO DE LA FECHA                           ANO_DE_LA_FECHA
 FECMES        61     62      2   0    P   MES DE LA FECHA                           MES_DE_LA_FECHA
 FECDIA        63     64      2   0    P   DIA DE LA FECHA                           DIA_DE_LA_FECHA
 FECNMA        65     79     15        A   NOMBRE MES DEL ANO                        NOMBRE_MES_DEL_ANO
 FECDSE        80     80      1   0    P   DIA DE LA SEMANA                          DIA_DE_LA_SEMANA
 FECNDS        81     95     15        A   NOMBRE DIA DE LA SEMANA                   NOMBRE_DIA_DE_LA_SEMANA
 FECNSA        96     97      2   0    P   NUMERO SEMANA DEL ANO                     NUMERO_SEMANA_DEL_ANO
 FECNSM        98     98      1   0    P   NUMERO SEMANA DEL MES                     NUMERO_SEMANA_DEL_MES
 FECNBA        99     99      1   0    P   NUMERO BIMESTRE DEL ANO                   NUMERO_BIMESTRE_DEL_ANO
 FECNTA       100    100      1   0    P   NUMERO TRIMESTRE DEL ANO                  NUMERO_TRIMESTRE_DEL_ANO
 FECNCA       101    101      1   0    P   NUMERO CUATRIMESTRE DEL ANO               NUMERO_CUATRIMESTRE_DEL_ANO
 FECNSE       102    102      1   0    P   NUMERO SEMESTRE DEL ANO                   NUMERO_SEMESTRE_DEL_ANO
 FECABI       103    103      1   0    P   ANO BISIESTO                              ANO_BISIESTO

---

## Claves e Índices

| Tipo | Campos | Descripción 			    |
|------|--------|-----------------------------------|
| PK   | FecIso | Clave principal — FECHA TIPO ISO  |


---

## Uso estándar en vistas y funciones (Regla 6)

Cuando se construye una fecha concatenando campos separados (año, mes, día) en una
vista o función SQL, se debe hacer `LEFT JOIN` a esta tabla para:
1. Obtener el valor DATE válido.
2. Retornar `DATE('1900-01-01')` como centinela si la fecha no existe en el calendario.

**Patrón de uso:**
```sql
CROSS JOIN LATERAL (
    VALUES(
        CASE
            WHEN campo_ano IS NULL OR campo_ano = 0
              OR campo_mes IS NULL OR campo_mes NOT BETWEEN 1 AND 12
              OR campo_dia IS NULL OR campo_dia NOT BETWEEN 1 AND 31
            THEN DATE('1900-01-01')
            ELSE COALESCE(
                    (SELECT SF.FecIso
                       FROM SegFec SF
                      WHERE SF.FecYmd = (campo_ano * 10000)
                                      + (campo_mes * 100)
                                      + campo_dia
                      FETCH FIRST 1 ROW ONLY),
                    DATE('1900-01-01')
                 )
        END
    )
) AS FX(Fecha_Calculada)
```

---

## Observaciones

- La tabla actúa como validador: si una fecha construida no existe en SegFec,
  se considera inválida y se retorna el centinela `DATE('1900-01-01')`.
- Usada como parámetro en las funciones de tabla de SEGLIB:
  `SG_TIEMPO_ANOS`, `SG_TIEMPO_MESES`, `SG_TIEMPO_DIAS`.
- En programas RPG se referencia mediante `ExtName(SegFec) Qualified`.

---

## Historial de documentación

| Fecha | Autor | Descripción |
|-------|-------|-------------|
| dd-mm-yyyy | | Creación del documento |
