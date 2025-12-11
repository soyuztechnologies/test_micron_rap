@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Basic Interface'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #FACT
define view entity ZI_MIC_AB_SALES as select from zmic_ab_so_item as item
association of many to one  zmic_ab_so_hdr as _Header on
$projection.OrderId = _Header.order_id
{
    key item.item_id as ItemId,
    key _Header.order_id as OrderId,
    item.product as Product,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    item.qty as Qty,
    item.uom as Uom,
    @Semantics.amount.currencyCode: 'Currency'
    item.amount as Amount,
    item.currency as Currency,
    _Header    
}
