CLASS zcl_mic_ab_first_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mic_ab_first_class IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  "you can press F2 key on method to view the signature
    select * from ZMIC_AB_BPA_ENT into table @data(itab) .
    "Ctrl+Space and Shift+Enter for code completion
    out->write(
      EXPORTING
        data   = itab
*        name   =
*      RECEIVING
*        output =
    ).

  ENDMETHOD.
ENDCLASS.
