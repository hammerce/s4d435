@AbapCatalog.sqlViewName: 'Z543513CVHTRAV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Value Help'
define view Z_543513_CVH_TRAVELTP 
    as select from scustom
{
  key id,
      name,
      form,
      street,
      postbox,
      postcode,
      city,
      country,
      region,
      telephone,
      custtype,
      discount,
      langu,
      email,
      webuser
}
