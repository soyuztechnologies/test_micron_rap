@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplement processor'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZMIC_AB_BOOKSUPPL_PROCESSOR as projection on ZMIC_AB_BOOKSUPPL
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking : redirected to parent ZMIC_AB_BOOKING_PROCESSOR,
    _Supplement,
    _SupplementText,
    _Travel: redirected to ZMIC_AB_TRAVEL_PROCESSOR
}
