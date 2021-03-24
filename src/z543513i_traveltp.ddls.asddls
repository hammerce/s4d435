@AbapCatalog.sqlViewName: 'Z543513ITRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Transactional View'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel:{
    compositionRoot: true,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZDV543513_TRAVEL',
    
    createEnabled: true,
    updateEnabled: 'EXTERNAL_CALCULATION',
    deleteEnabled: true,
    
    modelCategory: #BUSINESS_OBJECT,
    representativeKey: ['TravelNumber'],
    semanticKey: ['TravelAgency', 'TravelNumber']
}

define view Z543513I_TRAVELTP
  as select from Z543513I_TRAVEL
    association [*] to Z543513I_TRITEMTP as _Travel 
        on $projection.TravelNumber = _Travel.travelid
        and $projection.TravelAgency = _Travel.agencynum

{
      @ObjectModel.readOnly: true
  key TravelAgency,
      @ObjectModel.readOnly: true
  key TravelNumber,
      //annotations bewirken dass das auf der Oberfläche angezeigt wird, 
      //aber dass die prüfung auch wirkt muss auf BO-Ebene implementiert werden
      TravelDescription,
      @ObjectModel.mandatory: true
      Customer,
      @ObjectModel.mandatory: true
      StartDate,
      @ObjectModel.mandatory: true
      EndDate,
      @ObjectModel.readOnly: true
      Status,
      ChangedAt,
      ChangedBy,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Travel
}
