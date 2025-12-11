@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Entity'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view entity ZMIC_AB_BOOKING as select from /dmo/booking_m
composition[0..*] of ZMIC_AB_BOOKSUPPL as _BookSuppl
association to parent ZMIC_AB_TRAVEL as _Travel on
    $projection.TravelId = _Travel.TravelId
association[1] to /DMO/I_Customer as _Customer on
    $projection.CustomerId = _Customer.CustomerID
association[1] to /DMO/I_Carrier as _Airline on
    $projection.CarrierId = _Airline.AirlineID
association[1] to /DMO/I_Connection as _Connections on
    $projection.CarrierId = _Connections.AirlineID and 
    $projection.ConnectionId = _Connections.ConnectionID
association[1] to /DMO/I_Booking_Status_VH as _BookingStatus on
    $projection.BookingStatus = _BookingStatus.BookingStatus

{
    key travel_id as TravelId,
    key booking_id as BookingId,
    booking_date as BookingDate,
    customer_id as CustomerId,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: '/DMO/I_Carrier',
            entity.element: 'AirlineID'
    }]
    carrier_id as CarrierId,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: '/DMO/I_Connection',
            entity.element: 'ConnectionID',
            additionalBinding: [{
                element: 'AirlineID',
                localElement: 'CarrierId'
            }]
    }]
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    booking_status as BookingStatus,
    last_changed_at as LastChangedAt,
    _Travel,
    _Customer,
    _Airline,
    _Connections,
    _BookingStatus,
    _BookSuppl
}
