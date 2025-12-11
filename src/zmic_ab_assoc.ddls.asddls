@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association concept lose coupling'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMIC_AB_ASSOC as select from ZMIC_AB_BPA_ENT as bpa
association of one to many zmic_ab_so_hdr as _SalesOrders
on $projection.BpId = _SalesOrders.buyer
association of one to one I_Country as _Country
on $projection.Country = _Country.Country
{
    key bpa.BpId,
    bpa.BpRole,
    bpa.CompanyName,
    bpa.Street,
    bpa.Country,
    bpa.Region,
    bpa.City,
    --exposed association
    _SalesOrders,
    --ad hoc association
    _Country._Text[ Language = $session.system_language ].CountryName
} 
