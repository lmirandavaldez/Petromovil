**FREE
ctl-opt copyright('Miranda Valdez, S. A., 1997')
        dftactgrp(*no) actgrp(*caller);
// -------------------------------------------------------------
// CenterText
//   Centra un texto dentro de un campo de longitud fija (500).
//   Parámetros de entrada:
//      Texto      texto a centrar (char(500))
//      Longitud   tamaño del campo destino
//   Parámetros de salida:
//      Resultado  campo destino con el texto centrado (char(500))
// -------------------------------------------------------------

dcl-pi *n;
  Texto     char(500) const;
  Longitud  int(10)   const;
  Resultado char(500);
end-pi;

dcl-c MAXLEN  500;

dcl-s Out      char(MAXLEN) inz(*blanks);
dcl-s LenTxt   int(10);
dcl-s LeftPad  int(10);

// Longitud real del texto sin espacios laterales
LenTxt = %len(%trimr(Texto));

// Calcula espacios a la izquierda para centrar
LeftPad = (Longitud - LenTxt) / 2;

// Inserta el texto centrado dentro del campo destino
if LenTxt > 0 and LeftPad >= 0;
  Out = %replace(%trimr(Texto) : Out : LeftPad + 1 : LenTxt);
endif;

Resultado = Out;

*inlr = *on;
return;
