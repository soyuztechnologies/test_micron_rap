CLASS zcl_mic_ab_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    inteRFACES if_oo_adt_classrun.
    INTERFACES if_amdp_marker_hdb .
    class-meTHODS : add_numbers AMDP OPTIONS CLIENT INDEPENDENT imPORTING value(x) type i
                                          value(y) type i
                                          expORTING value(res) type i.

    class-meTHODS : get_customer_by_id AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
                                            imPORTING
                                                value(cust_id) type zmic_ab_dte_id
                                          expORTING value(e_name) type string.
    class-metHODS : get_product_mrp AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
                                impORTING
                                    value(i_tax) type i
                                exporTING
                                    value(otab) type ZMIC_AB_TT_MRP.
    clASS-meTHODS get_customer_rank
                                for table FUNCTION ZTF_GET_CUSTOMER_RANK.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mic_ab_amdp IMPLEMENTATION.
  METHOD add_numbers by DATABASE pROCEDURE FOR HDB LANGUAGE sqLSCRIPT opTIONS reAD-ONLY.

    --sql script coding in a normal abap class which is mutated
    res = :x + :y;

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    "Please change the ID in line 35
    zcl_mic_ab_amdp=>get_product_mrp(
      EXPORTING
        i_tax = 18
      IMPORTING
        otab  = data(result)
    ).
    out->write(
      EXPORTING
        data   = result
*        name   =
*      RECEIVING
*        output =
    ).

  ENDMETHOD.

  METHOD get_customer_by_id by DATABASE pROCEDURE FOR HDB LANGUAGE sqLSCRIPT opTIONS reAD-ONLY
                using zmic_ab_bpa.

    select company_name into e_name from zmic_ab_bpa where bp_id = :cust_id;

  ENDMETHOD.

  METHOD get_product_mrp by DATABASE pROCEDURE FOR HDB LANGUAGE sqLSCRIPT opTIONS reAD-ONLY
                using zmic_ab_product.

      --Ctrl+M to toggle full screen
      --declare variables
      declare lv_count integer;
      declare i integer;
      declare lv_mrp bIGINT;
      declare lv_price_d integer;

      --get all prooducts from db table in a implicit table variable
      lt_prod = select * from zmic_ab_product;

      --get the total records
      lv_count := record_count( :lt_prod );

      --loop at each record one by one and calculate price after discount
      for i in 1..:lv_count do

        --calculate the dicounted price
        lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i] ) / 100;
        --calculate the MRP
        lv_mrp := :lv_price_d + (  100 + :i_tax ) / 100;
        --if the MRP is above 5000, add extra 10% discount
        if lv_mrp > 5000 then
            lv_mrp := :lv_mrp * 0.90;
        end IF ;

        --Fill the output table to send result
        :otab.insert( (
                        :lt_prod.name[i],
                        :lt_prod.category[i],
                        :lt_prod.price[i],
                        :lt_prod.currency[i],
                        :lt_prod.discount[i],
                        :lv_price_d,
                        :lv_mrp
                      ), i );

      end FOR ;


  ENDMETHOD.

  METHOD get_customer_rank by dATABASE fuNCTION FOR HDB LANGUAGE SQLSCRIPT
  opTIONS rEAD-ONLY using zmic_ab_bpa zmic_ab_so_hdr zmic_ab_so_item.

    return select
            bpa.client,
            bpa.company_name,
            sum ( itm.amount ) as total_sales,
            itm.currency as currency_code,
            rank ( ) OVER ( ordeR BY sum( itm.amount ) desc ) as customer_rank
            from zmic_ab_bpa as bpa inner join
            zmic_ab_so_hdr as hdr on bpa.bp_id = hdr.buyer
            inner join zmic_ab_so_item as itm on
            itm.order_id = hdr.order_id
            group by bpa.client,
            bpa.company_name, itm.currency;

  ENDMETHOD.

ENDCLASS.
