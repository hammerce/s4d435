class ZCL_Z543513_C_TRAVELTP definition
  public
  inheriting from CL_SADL_GTK_EXPOSURE_MPC
  final
  create public .

public section.
protected section.

  methods GET_PATHS
    redefinition .
  methods GET_TIMESTAMP
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z543513_C_TRAVELTP IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~Z543513_C_TRAVELTP| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20210322132700.
  endmethod.
ENDCLASS.
