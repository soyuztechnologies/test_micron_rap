@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Analytic Cube, composite'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #CUBE
define view entity ZI_MIC_AB_CUBE as select from ZI_MIC_AB_CO_S
association of many to one ZI_MIC_AB_PROD as _Products
on $projection.Product = _Products.ProductId
{
   key ZI_MIC_AB_CO_S.ItemId,
   key ZI_MIC_AB_CO_S.OrderId,
   ZI_MIC_AB_CO_S.Product,
   @DefaultAggregation: #SUM
   ZI_MIC_AB_CO_S.Qty,
   ZI_MIC_AB_CO_S.Uom,
   @DefaultAggregation: #SUM
   ZI_MIC_AB_CO_S.Amount,
   ZI_MIC_AB_CO_S.Currency,
   ZI_MIC_AB_CO_S.Buyer,
   /* Associations */
   ZI_MIC_AB_CO_S._BusinessPartners.CompanyName,
   ZI_MIC_AB_CO_S._BusinessPartners.Country,
   _Products.Name 
}
