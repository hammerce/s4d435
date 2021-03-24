class ZCL_543513I_V_SEQUENCE_OF_DATE definition
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



CLASS ZCL_543513I_V_SEQUENCE_OF_DATE IMPLEMENTATION.


  method /BOBF/IF_FRW_VALIDATION~EXECUTE.


    DATA lt_travel TYPE d435c_t_itraveltp.
    DATA lt_travel_before TYPE d435c_t_itraveltp.

    "for message
    DATA lo_msg TYPE REF TO cm_devs4d435.
    DATA lt_msg TYPE /bobf/cm_frw=>tt_frw.

    CONSTANTS c_s_initial_travel TYPE d435c_s_itraveltp VALUE IS INITIAL.


    "Read required Data

   io_read->retrieve(
    EXPORTING
        iv_node = is_ctx-node_key
        it_key = it_key
    importing
        eo_message = eo_message
        et_data = lt_travel ).

    LOOP AT lt_travel ASSIGNING field-symbol(<ls_travel>)
            WHERE startdate IS NOT INITIAL
                AND enddate IS NOT INITIAL.



   io_read->retrieve(
    EXPORTING
        iv_node = is_ctx-node_key
        it_key = VALUE #( ( key = <ls_travel>-key ) )
        iv_before_image = abap_true
    importing
        eo_message = eo_message
        et_data = lt_travel_before ).


    ASSIGN lt_travel_before[ 1 ] TO FIELD-symbol(<ls_travel_before>).
    IF sy-subrc <> 0.
        ASSIGN c_s_initial_travel TO <ls_travel_before>.
    ENDIF.


   IF <ls_travel>-enddate < <ls_travel>-startdate.

    CREATE OBJECT lo_msg
        exporting
            textid = cm_devs4d435=>dates_wrong_sequence
            severity = cm_devs4d435=>co_severity_error.

        APPEND lo_msg TO lt_msg.
   ENDIF.


   IF <ls_travel>-enddate < sy-datum.

    CREATE OBJECT lo_msg
        exporting
            textid = cm_devs4d435=>end_date_past
            severity = cm_devs4d435=>co_severity_error.

        APPEND lo_msg TO lt_msg.
   ENDIF.


   IF <ls_travel>-startdate = <ls_travel_before>-startdate.
   ELSEIF <ls_travel>-startdate < sy-datum.

    CREATE OBJECT lo_msg
        exporting
            textid = cm_devs4d435=>start_date_past
            severity = cm_devs4d435=>co_severity_error.

        APPEND lo_msg TO lt_msg.
   ENDIF.

   IF lt_msg IS NOT INITIAL.

    INSERT VALUE #( key = <ls_travel>-key ) INTO TABLE et_failed_key.

    IF eo_message IS NOT BOUND.
        eo_message = /bobf/cl_frw_factory=>get_message(  ).
    ENDIF.

    eo_message->add_cm(
        EXPORTING
            it_message = lt_msg ).
    ENDIF.

   ENDLOOP.



  endmethod.
ENDCLASS.
