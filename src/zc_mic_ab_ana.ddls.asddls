@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for Analytic tools'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
define view entity ZC_MIC_AB_ANA as select from ZI_MIC_AB_CUBE
{
    key OrderId,
    key Name,
    @AnalyticsDetails.query.axis: #ROWS
    key CompanyName,
    key Country,
    Qty,
    @Consumption.filter.selectionType: #SINGLE
    @Consumption.filter.defaultValue: 'EA'
    Uom,
    Amount,
    @Consumption.filter.selectionType: #SINGLE
    @Consumption.filter.defaultValue: 'INR'
    Currency
    
}
