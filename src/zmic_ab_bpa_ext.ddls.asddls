extend view entity ZMIC_AB_BPA_ENT_US with {
    @EndUserText.label: 'Street'
    ZMIC_AB_BPA_ENT.Street as ZZSTREET,
    @EndUserText.label: 'Region'
    ZMIC_AB_BPA_ENT.Region as ZZREGION
}
