@AbapCatalog.sqlViewName: 'Z543513ITRITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View Travel Item'
@VDM.viewType: #BASIC

define view Z543513I_TRITEM 
    as select from d435t_tritem 
    
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
          changedby
}
