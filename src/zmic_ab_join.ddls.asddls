@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join and aggregation'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMIC_AB_JOIN as select from ZMIC_AB_BPA_ENT as bpa
inner join zmic_ab_so_hdr as So
on bpa.BpId = So.buyer
{
    key bpa.CompanyName ,
    bpa.Country,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    sum(So.gross_amount) as total_amount,
    So.currency_code as CurrencyCode
} group by bpa.CompanyName ,
    bpa.Country, So.currency_code
