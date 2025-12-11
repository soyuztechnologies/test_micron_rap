CLASS zcl_mic_ab_mars DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    clASS-DATA itab type table of string.
    inTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mic_ab_mars IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lcl_earth=>start_engine(
      RECEIVING
        r_value = data(lv_str)
    ).
    append lv_str to zcl_mic_ab_mars=>itab.
    lcl_earth=>leave_orbit(
      RECEIVING
        r_value = lv_str
    ).
    append lv_str to zcl_mic_ab_mars=>itab.
    lcl_ip=>enter_orbit(
      RECEIVING
        r_value = lv_str
    ).
    append lv_str to zcl_mic_ab_mars=>itab.
    lcl_ip=>leave_orbit(
      RECEIVING
        r_value = lv_str
    ).
    append lv_str to zcl_mic_ab_mars=>itab.
    lcl_mars=>enter_orbit(
      RECEIVING
        r_value = lv_str
    ).
    append lv_str to zcl_mic_ab_mars=>itab.
    lcl_mars=>start_explore(
      RECEIVING
        r_value = lv_str
    ).
    append lv_str to zcl_mic_ab_mars=>itab.


    out->write(
      EXPORTING
        data   = zcl_mic_ab_mars=>itab
*        name   =
*      RECEIVING
*        output =
    ).
  ENDMETHOD.

ENDCLASS.
