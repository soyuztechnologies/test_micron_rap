@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Root Entity for BO'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define root view entity ZMIC_AB_TRAVEL as select from /dmo/travel_m 
composition[0..*] of ZMIC_AB_BOOKING as _Booking
association[1] to /DMO/I_Agency as _Agency on
$projection.AgencyId = _Agency.AgencyID
association[1] to /DMO/I_Customer as _Customer on
$projection.CustomerId = _Customer.CustomerID
association[1] to I_Currency as _Currency on
$projection.CurrencyCode = _Currency.Currency
association[1] to /DMO/I_Overall_Status_VH as _Status on
$projection.OverallStatus = _Status.OverallStatus

{
    key /dmo/travel_m.travel_id as TravelId,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: '/DMO/I_Agency',
            entity.element: 'AgencyID'
    }]
    /dmo/travel_m.agency_id as AgencyId,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: '/DMO/I_Customer',
            entity.element: 'CustomerID'
    }]
    /dmo/travel_m.customer_id as CustomerId,
    /dmo/travel_m.begin_date as BeginDate,
    /dmo/travel_m.end_date as EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    /dmo/travel_m.booking_fee as BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    /dmo/travel_m.total_price as TotalPrice,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: 'I_Currency',
            entity.element: 'Currency'
    }]
    /dmo/travel_m.currency_code as CurrencyCode,
    /dmo/travel_m.description as Description,
    @Consumption.valueHelpDefinition: [{ 
            entity.name: '/DMO/I_Overall_Status_VH',
            entity.element: 'OverallStatus'
    }]
    /dmo/travel_m.overall_status as OverallStatus,
    @Semantics.user.createdBy: true
    /dmo/travel_m.created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    /dmo/travel_m.created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    /dmo/travel_m.last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    /dmo/travel_m.last_changed_at as LastChangedAt,
    
    case overall_status 
        when 'O' then 'Open'
        when 'A' then 'Approved'
        when 'X' then 'Rejected'
        else 'Unknown' end as OverallStatusText,
     case overall_status 
        when 'O' then 2
        when 'A' then 3
        when 'X' then 1
        else 1 end as IconColor,   
    _Agency,
    _Customer,
    _Currency,
    _Status,
    _Booking
}
