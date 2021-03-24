@AbapCatalog.sqlViewName: 'Z543513ITRITEMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View Travel Item'
@VDM.viewType:  #TRANSACTIONAL
@ObjectModel:{
//    compositionRoot: true,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'd435t_tritem',

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,

//    modelCategory: #BUSINESS_OBJECT,
    representativeKey: ['agencynum', 'travelid'],
    semanticKey: ['agencynum', 'travelid']
}

define view Z543513I_TRITEMTP 
    as select from Z543513I_TRITEM 
    association[1] to Z543513I_TRAVELTP as _Travel
        on $projection.travelid = _Travel.TravelNumber
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
