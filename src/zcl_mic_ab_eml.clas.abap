CLASS zcl_mic_ab_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    data: lv_type type c value 'C'.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mic_ab_eml IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.


     case lv_type.
        when 'R'.

            read ENTITIES of ZMIC_AB_TRAVEL
                entity Travel
                ALL FIELDS WITH
                value #( ( TravelId = '00000009' )  ( TravelId = '00000016' ) ( TravelId = '00006331' ) )
                result data(lt_found_records)
                FAILED   DATA(lt_failed)
                REPORTED DATA(lt_reported).

                out->write(
                  EXPORTING
                    data   = lt_found_records
*                    name   =
*                  RECEIVING
*                    output =
                ).
                out->write(
                  EXPORTING
                    data   = lt_failed
*                    name   =
*                  RECEIVING
*                    output =
                ).

        when 'C'.

                DATA(lv_description)  = 'Intro to EML'.
                DATA(lv_agency_id)    = '070048'.
                DATA(lv_my_agency_id) = '0700999'.

                " Get valid customer ID
                SELECT SINGLE customer_id FROM /dmo/customer INTO @data(gv_customer_id).

                " Create a new travel > booking > booking supplement
                MODIFY ENTITIES OF ZMIC_AB_TRAVEL
                      ENTITY Travel
                        CREATE FIELDS ( travelid agencyid customerid begindate enddate description overallstatus )
                          WITH VALUE #( ( %cid          = 'ANUBHAV'    " Preliminary ID for new travel instance
                                          travelid      = 3696
                                          agencyid      = lv_agency_id
                                          customerid    = gv_customer_id
                                          begindate     = cl_abap_context_info=>get_system_date( )
                                          enddate       = cl_abap_context_info=>get_system_date( ) + 30
                                          description   = lv_description
                                          overallstatus = CONV #( /dmo/if_flight_legacy=>travel_status-new ) )
                                        ( %cid          = 'ANUBHAV1'    " Different CID for second travel instance
                                          travelid      = 8586
                                          agencyid      = lv_agency_id
                                          customerid    = gv_customer_id
                                          begindate     = cl_abap_context_info=>get_system_date( )
                                          enddate       = cl_abap_context_info=>get_system_date( ) + 30
                                          description   = lv_description
                                          overallstatus = CONV #( /dmo/if_flight_legacy=>travel_status-new ) ) )
                      MAPPED   DATA(lt_mapped)
                      FAILED   lt_failed
                      REPORTED lt_reported.

                      out->write( expORTING data = |************Result of Create************|  )    .
                      out->write(
                          EXPORTING
                            data   = lt_mapped
*                            name   =
*                          RECEIVING
*                            output =
                        ).
                        out->write(
                          EXPORTING
                            data   = lt_failed
*                            name   =
*                          RECEIVING
*                            output =
                        ).



                   COMMIT ENTITIES.

*                   READ ENTITIES OF ZMIC_AB_TRAVEL
*                      ENTITY travel
*                      FIELDS ( agencyid Description )
*                        WITH VALUE #( ( travelid = lt_mapped-travel[ 1 ]-TravelId ) )
*                        RESULT DATA(lt_received_travel_data)
*                  REPORTED lt_reported
*                  FAILED   lt_failed.
*
*                out->write( lt_received_travel_data ).


                " Check criteria of success
                IF sy-subrc = 0.
                  out->write( 'Successful COMMIT!' ).
                ELSE.
                  out->write( 'COMMIT failed!' ).
                ENDIF.



    when 'U'.

*            Additionally data type can be created as below
*            data: it_instance_u type table for update ZMIC_AB_TRAVEL.

            MODIFY ENTITY ZMIC_AB_TRAVEL
                    UPDATE FIELDS ( agencyid description ) WITH
                            VALUE #( (
                              travelid          = '00008586'
                              agencyid          = '070017'
                              description              = 'Fantastic 4' ) )
                    FAILED   lt_failed
                    REPORTED lt_reported.

            if lt_failed is not INITIAL.
                out->write(
                  EXPORTING
                    data   = lt_failed
                ).

            ENDIF.
            COMMIT ENTITIES.

    when 'D'.

*        data: it_instance_d type table for delete ZMIC_AB_TRAVEL.

        MODIFY ENTITIES OF ZMIC_AB_TRAVEL
              " Delete travel and all child instances (booking, booking supplements)
              ENTITY travel
                   DELETE FROM VALUE #( ( TRAVELID  = '00008586' ) )
              REPORTED lt_reported
              FAILED   lt_failed.


        commit ENTITIES.
        if lt_failed is not INITIAL.
            out->write(
              EXPORTING
                data   = lt_failed
*                name   =
*              RECEIVING
*                output =
            ).

        ENDIF.

    endcase.



  ENDMETHOD.

ENDCLASS.
