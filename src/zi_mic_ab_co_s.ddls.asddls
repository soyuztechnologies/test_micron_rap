@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite Sales CDS'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #FACT
define view entity ZI_MIC_AB_CO_S as select from ZI_MIC_AB_SALES as sales
association of many to one ZI_MIC_AB_BPA as _BusinessPartners
on $projection.Buyer = _BusinessPartners.BpId
{
    key ItemId,
    key OrderId,
    Product,
    Qty,
    Uom,
    Amount,
    Currency,
    /* Associations */
    _Header.buyer as Buyer,
    _BusinessPartners
}
