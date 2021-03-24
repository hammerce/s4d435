class ZCL_543513I_A_SET_TO_CANCELLED definition
  public
  inheriting from /BOBF/CL_LIB_A_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_ACTION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_543513I_A_SET_TO_CANCELLED IMPLEMENTATION.


  method /BOBF/IF_FRW_ACTION~EXECUTE.
    DATA lo_msg TYPE REF TO cm_devs4d435.
    DATA ls_location TYPE /bobf/s_frw_location.

    DATA lt_travel TYPE d435b_t_itraveltp.

    DATA lr_travel TYPE REF TO d435b_s_itraveltp.
    FIELD-SYMBOLS <ls_travel> TYPE d435b_s_itraveltp.

    io_read->retrieve(
        exporting
            iv_node = is_ctx-node_key
            it_key = it_key
            iv_BEFORE_IMAGE = ABAP_FALSE
         IMPORTING
            et_data = lt_travel ).

    IF eo_message IS NOT BOUND.
        eo_message = /bobf/cl_frw_message_factory=>create_container(  ).
    ENDIF.

    LOOP AT lt_travel ASSIGNING <ls_travel>.
        ls_location-bo_key = is_ctx-bo_key.
        ls_location-node_key = is_ctx-node_key.
        ls_location-key = <ls_travel>-key.

        IF <ls_travel>-status = 'C'. "already cancelled

        "issue error message
            CREATE OBJECT lo_msg
                exporting
                textid = cm_devs4d435=>already_cancelled
                severity = cm_devs4d435=>co_severity_error
                travelnumber = <ls_travel>-travelnumber
                ms_origin_location = ls_location.

                eo_message->add_cm( io_message = lo_msg ).
        ELSE.
            <ls_travel>-status = 'C'.

            GET reference of <ls_travel> INTO lr_travel.

            io_modify->update(
                EXPORTING
                    iv_node = is_ctx-node_key
                    iv_key = <ls_travel>-key
                    is_data = lr_travel ).

            "issue success message
            CREATE OBJECT lo_msg
                exporting
                    textid = cm_devs4d435=>cancel_success
                    severity = cm_devs4d435=>co_severity_success
                    travelnumber = <ls_travel>-travelnumber
                    startdate = <ls_travel>-startdate
                    ms_origin_location = ls_location.

                eo_message->add_cm( io_message = lo_msg ).
        ENDIF.
      ENDLOOP.
  endmethod.
ENDCLASS.
