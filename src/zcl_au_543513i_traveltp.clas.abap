class ZCL_AU_543513I_TRAVELTP definition
  public
  inheriting from /BOBF/CL_LIB_AUTH_DRAFT_ACTIVE
  final
  create public .

public section.

  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY
    redefinition .
  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_AU_543513I_TRAVELTP IMPLEMENTATION.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY.
    DATA:
       lt_travels TYPE d435b_t_itraveltp.
    DATA:
        lv_activity TYPE activ_auth.


     CASE is_ctx-activity.
        WHEN /bobf/cl_frw_authority_check=>sc_activity-create "'01'
          OR /bobf/cl_frw_authority_check=>sc_activity-change "'02'
          OR /bobf/cl_frw_authority_check=>sc_activity-display. "'03'

            lv_activity = is_ctx-activity.

        WHEN /bobf/cl_frw_authority_check=>sc_activity-execute. "'16'
        "special case Execute
            CASE is_ctx-action_name.
                WHEN 'SET_TO_CANCELLED'.
                    lv_activity =  /bobf/cl_frw_authority_check=>sc_activity-change.
                WHEN OTHERS.
                    lv_activity =  /bobf/cl_frw_authority_check=>sc_activity-display.
            ENDCASE.
      ENDCASE.

      IF lv_activity IS NOT INITIAL.

        io_read->retrieve(
            exporting
                iv_node = is_ctx-node_key
                it_key = it_key
            IMPORTING
                et_data = lt_travels
                et_failed_key = et_failed_key ).

      LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<ls_travel>)
            WHERE travelagency IS NOT INITIAL.


      cl_s4d435_model=>authority_check(
        EXPORTING
            iv_agencynum = <ls_travel>-travelagency
            iv_actvt = lv_activity
            RECEIVING
                rv_rc = DATA(lv_subrc) ).

      IF lv_subrc <> 0.
        .
        et_failed_key = VALUE #( BASE et_failed_key ( key = <ls_travel>-key ) ).
      ENDIF.
     ENDLOOP.
    ENDIF.

  endmethod.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY.
  endmethod.
ENDCLASS.
