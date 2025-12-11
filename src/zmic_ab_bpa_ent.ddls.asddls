@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMIC_AB_BPA_ENT as select from zmic_ab_bpa
association of one to one ZTF_GET_CUSTOMER_RANK as _CDSTF
on $projection.CompanyName = _CDSTF.company_name
{
    key bp_id as BpId,
    case bp_role
        when '01' then 'Customer'
        else 'Vendor' end
     as BpRole,
    company_name as CompanyName,
    street as Street,
    country as Country,
    region as Region,
    city as City,
    _CDSTF
}
