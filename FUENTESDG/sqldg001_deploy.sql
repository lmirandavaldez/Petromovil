-- =============================================================
-- Script de despliegue: VWDGI_Comprobantes
-- Programa  : SQLDG001
-- Version   : 2
-- Fecha     : 2026-08-02
-- Autor     : L. Miranda
-- -------------------------------------------------------------
-- Instrucciones:
--   1. Conectarse a la biblioteca/esquema correspondiente
--      antes de ejecutar este script.
--   2. El CREATE OR REPLACE reemplaza la vista si ya existe
--      sin necesidad de DROP previo.
--   3. Verificar que las tablas referenciadas existen y son
--      accesibles desde la biblioteca activa:
--        FacDtoh, FacDed, FpsFach,
--        SegDis, SegSis, SegTcf, IteEst, SegFec
--   4. Verificar que 'FA' y 'FS' existen en SegSis antes
--      de ejecutar (ver sugerencia 2 del script fuente).
-- =============================================================

CREATE OR REPLACE VIEW VWDGI_Comprobantes
    (SisCve, SisDes, DisCve, DisDes, DtoTip, CliCve,
     EstNcf, FecAno, FecYmd,
     Status, NcfNro, TcfCve, TcfDes, NcfSec, MonFac)
AS

-- Rama 1: Documentos de facturacion (sistema FA)
SELECT
    T4.SisCve,
    T4.SisDes,
    T1.DisCve,
    T3.DisDes,
    T1.DtoTip,
    T1.CliCve,
    T6.EstNcf,
    T9.FecAno,
    T9.FecYmd,
    T1.DtoSta,
    T2.NcfNro,
    CASE
        WHEN SUBSTRING(T2.NcfNro, 12, 2) <> '  '
        THEN CAST(SUBSTRING(T2.NcfNro, 10, 2) AS DEC(2, 0))
        ELSE CAST(SUBSTRING(T2.NcfNro,  2, 2) AS DEC(2, 0))
    END,
    T5.TcfDes,
    CASE
        WHEN SUBSTRING(T2.NcfNro, 12, 2) <> '  '
        THEN CAST(SUBSTRING(T2.NcfNro, 12, 8) AS DEC(8, 0))
        ELSE CAST(SUBSTRING(T2.NcfNro,  4, 8) AS DEC(8, 0))
    END,
    T1.DtoMne
FROM FacDtoh T1
JOIN FacDed T2
    ON  T1.DisCve = T2.DisCve
    AND T1.DtoTip = T2.DtoTip
    AND T1.DtoNro = T2.DtoNro
JOIN SegDis T3
    ON  T1.DisCve = T3.DisCve
JOIN SegSis T4
    ON  T4.SisCve = 'FA'
JOIN SegTcf T5
    ON  CAST(SUBSTRING(T2.NcfNro, 2, 2) AS DEC(2, 0)) = T5.TcfCve
LEFT OUTER JOIN IteEst T6
    ON  T1.DisCve = T6.DisCve
LEFT OUTER JOIN SegFec T9
    ON  T1.DtoAno = T9.FecAno
    AND T1.DtoMes = T9.FecMes
    AND T1.DtoDia = T9.FecDia
WHERE T2.NcfNro <> '  '
  AND SUBSTRING(T2.NcfNro, 12, 2) = '  '

UNION ALL

-- Rama 2: Facturas de sistema externo (sistema FS)
SELECT
    T4.SisCve,
    T4.SisDes,
    T1.DisCve,
    T3.DisDes,
    1,
    T1.CliCve,
    T6.EstNcf,
    T9.FecAno,
    T9.FecYmd,
    T1.SitCve,
    T1.NcfNro,
    CASE
        WHEN SUBSTRING(T1.NcfNro, 12, 2) <> '  '
        THEN CAST(SUBSTRING(T1.NcfNro, 10, 2) AS DEC(2, 0))
        ELSE CAST(SUBSTRING(T1.NcfNro,  2, 2) AS DEC(2, 0))
    END,
    T5.TcfDes,
    CASE
        WHEN SUBSTRING(T1.NcfNro, 12, 2) <> '  '
        THEN CAST(SUBSTRING(T1.NcfNro, 12, 8) AS DEC(8, 0))
        ELSE CAST(SUBSTRING(T1.NcfNro,  4, 8) AS DEC(8, 0))
    END,
    T1.FacTin
FROM FpsFach T1
JOIN SegDis T3
    ON  T1.DisCve = T3.DisCve
JOIN SegSis T4
    ON  T4.SisCve = 'FS'
JOIN SegTcf T5
    ON  CAST(SUBSTRING(T1.NcfNro, 2, 2) AS DEC(2, 0)) = T5.TcfCve
LEFT OUTER JOIN IteEst T6
    ON  T1.DisCve = T6.DisCve
LEFT OUTER JOIN SegFec T9
    ON  T1.FacAno = T9.FecAno
    AND T1.FacMes = T9.FecMes
    AND T1.FacDia = T9.FecDia
WHERE T1.NcfNro <> '  '
  AND SUBSTRING(T1.NcfNro, 12, 2) = '  ';

-- =============================================================
-- Verificacion post-despliegue (ejecutar por separado):
--   SELECT COUNT(*) FROM VWDGI_Comprobantes
-- =============================================================
