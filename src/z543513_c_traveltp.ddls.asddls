@AbapCatalog.sqlViewName: 'Z543513CTRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Consumption View'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Search.searchable: true
@ObjectModel: {
    transactionalProcessingDelegated: true,
    semanticKey: ['TravelAgency', 'TravelNumber'],
    
    updateEnabled: true // muss auf transactional und consumption view ebene da sein (hier damit edit-button angezeigt wird)
}

@Metadata.allowExtensions: true


define view Z543513_C_TRAVELTP
  as select from Z543513I_TRAVELTP
  association [1] to Z_543513_CVH_TRAVELTP as _Customer on $projection.Customer = _Customer.id
// da 1 travel zu 1 kunde gehört
  association [*] to Z543513C_TRITEMTP  as _Travel
    on  $projection.TravelNumber = _Travel.travelid
        and $projection.TravelAgency = _Travel.agencynum

{
  key TravelAgency,
  key TravelNumber,

      @Search: { defaultSearchElement: true,
                 fuzzinessThreshold: 0.8
               }

      TravelDescription,
      @Consumption.valueHelp: '_Customer'
      Customer,
      StartDate,
      EndDate,
      Status,
      ChangedAt,
      ChangedBy,
      _Customer,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Travel
}
