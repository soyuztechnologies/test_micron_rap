*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

clASS lcl_earth deFINITION.

    puBLIC SECTION.
        class-meTHODS : start_engine reTURNING VALUE(r_value) type string.
        class-meTHODS : leave_orbit reTURNING VALUE(r_value) type string.

enDCLASS.

clASS lcl_earth implEMENTATION.

    method start_engine.
        r_value = 'Start engine from earth'.
    eNDMETHOD.
    method leave_orbit.
        r_value = 'Leave earth orbit'.
    enDMETHOD.

enDCLASS.

clASS lcl_ip deFINITION.

    puBLIC SECTION.
        class-meTHODS : enter_orbit reTURNING VALUE(r_value) type string.
        class-meTHODS : leave_orbit reTURNING VALUE(r_value) type string.

enDCLASS.

clASS lcl_ip implEMENTATION.

    method enter_orbit.
        r_value = 'Enter IP orbit and charge batteries'.
    eNDMETHOD.
    method leave_orbit.
        r_value = 'Leave IP orbit'.
    enDMETHOD.

enDCLASS.


clASS lcl_mars deFINITION.

    puBLIC SECTION.
        class-meTHODS : enter_orbit reTURNING VALUE(r_value) type string.
        class-meTHODS : start_explore reTURNING VALUE(r_value) type string.

enDCLASS.

clASS lcl_mars implEMENTATION.

    method enter_orbit.
        r_value = 'Enter Mars orbit Insertion sucesss!'.
    eNDMETHOD.
    method start_explore.
        r_value = 'Roger We found the water'.
    enDMETHOD.

enDCLASS.
