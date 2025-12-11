@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View on View'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility: {
    extensible: true
}
define view entity ZMIC_AB_BPA_ENT_US
with parameters
    p_ctry: land1
 as select from ZMIC_AB_BPA_ENT
{
    key BpId,
    BpRole,
    CompanyName,
    Country,
    City
} where Country = $parameters.p_ctry
