@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking processor entity'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZMIC_AB_BOOKING_APPROVER as projection on ZMIC_AB_BOOKING
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LastChangedAt,
    /* Associations */
    _Airline,
    _BookingStatus,
    _Connections,
    _Customer,
    _Travel : redirected to parent ZMIC_AB_TRAVEL_APPROVER
}
