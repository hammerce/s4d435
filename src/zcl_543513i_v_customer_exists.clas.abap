class ZCL_543513I_V_CUSTOMER_EXISTS definition
  public
  inheriting from /BOBF/CL_LIB_V_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_VALIDATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_543513I_V_CUSTOMER_EXISTS IMPLEMENTATION.


  method /BOBF/IF_FRW_VALIDATION~EXECUTE.

    DATA lt_travel TYPE d435c_t_itraveltp.
    DATA lv_exists TYPE abap_bool.

    "for message
    DATA lo_msg TYPE REF TO cm_devs4d435.
    DATA ls_location TYPE /bobf/s_frw_location.

    "for appending et_failed_key
    DATA ls_key LIKE LINE OF et_failed_key.

    "Read required Data

   io_read->retrieve(
    EXPORTING
        iv_node = is_ctx-node_key
        it_key = it_key
    importing
        eo_message = eo_message
        et_data = lt_travel ).

    LOOP AT lt_travel ASSIGNING field-symbol(<ls_travel>).
        lv_exists = abap_false.

        IF <ls_travel>-customer IS NOT INITIAL.

            SELECT SINGLE @abap_true
                FROM d435_i_customer
                INTO @lv_exists
                WHERE customer = @<ls_travel>-customer.

            IF lv_exists <> abap_true.

                if eo_message IS NOT BOUND.
                    eo_message = /bobf/cl_frw_factory=>get_message( ).
                endif.

   "issue error message

        ls_location-bo_key = is_ctx-bo_key.
        ls_location-node_key = is_ctx-node_key.
        ls_location-key = <ls_travel>-key.
        APPEND if_d435c_i_traveltp_c=>sc_node_attribute-d435c_i_traveltp-customer
            TO ls_location-attributes.

    CREATE OBJECT lo_msg
        exporting
            textid = cm_devs4d435=>customer_not_exist
            severity = cm_devs4d435=>co_severity_error
            customer = <ls_travel>-customer
            ms_origin_location = ls_location.

    eo_message->add_cm( lo_msg ).

    "add key to failed keys

        ls_key-key = <ls_travel>-key.
        INSERT ls_key INTO TABLE et_failed_key.
        endif.
       ENDIF.
      ENDLOOP.

  endmethod.
ENDCLASS.
