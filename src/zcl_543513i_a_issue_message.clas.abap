class ZCL_543513I_A_ISSUE_MESSAGE definition
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



CLASS ZCL_543513I_A_ISSUE_MESSAGE IMPLEMENTATION.


  method /BOBF/IF_FRW_ACTION~EXECUTE.
    DATA lo_msg TYPE ref to zcm_543513_travel.
        IF eo_message IS NOT BOUND.
           eo_message = /bobf/cl_frw_message_factory=>create_container( ).
        ENDIF.

        CREATE object lo_msg
         EXPORTING
            textid = zcm_543513_travel=>zcm_543513_travel
            severity = zcm_543513_travel=>co_severity_success.
        eo_message->add_cm( io_message = lo_msg ).

        ev_static_action_failed = abap_false.

  endmethod.
ENDCLASS.
