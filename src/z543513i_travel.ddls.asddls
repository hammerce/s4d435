@AbapCatalog.sqlViewName: 'Z543513ITRAVEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Interface View'

@VDM.viewType: #BASIC

define view Z543513I_TRAVEL
  as select from z543513_travel
{
  key agencynum as TravelAgency,
  key travelid  as TravelNumber,
      trdesc    as TravelDescription,
      customid  as Customer,
      stdat     as StartDate,
      enddat    as EndDate,
      status    as Status,
      changedat as ChangedAt,
      changedby as ChangedBy
}
