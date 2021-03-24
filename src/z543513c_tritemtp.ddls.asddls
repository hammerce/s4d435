@AbapCatalog.sqlViewName: 'Z543513CTRITEMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View Travel Item'
@VDM.viewType:  #CONSUMPTION
@ObjectModel:{
//    transactionalProcessingDelegated: true,

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view Z543513C_TRITEMTP 
    as select from Z543513I_TRITEMTP 
    association [1] to Z543513_C_TRAVELTP as _Travel 
        on  $projection.travelid = _Travel.TravelNumber
            and $projection.agencynum = _Travel.TravelAgency

    {
          key agencynum,
          key travelid,
              tritemno,
              trguid,
              carrid,
              connid,
              fldate,
              bookid,
              class,
              passname,
              createdat,
              createdby,
              changedat,
              changedby,
              @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
              _Travel
}
