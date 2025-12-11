@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product master basic interface'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
define view entity ZI_MIC_AB_PROD as select from zmic_ab_product
{
    key product_id as ProductId,
    name as Name,
    category as Category,
    price as Price,
    currency as Currency,
    discount as Discount
}
