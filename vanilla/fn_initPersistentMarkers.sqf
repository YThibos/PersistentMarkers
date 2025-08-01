/*
    Function: PersistentMarkers_fnc_initPersistentMarkers
    Description: Initializes the persistent markers system
    Parameters: None
    Returns: Nothing
*/

// Initialize variables
PersistentMarkers_Initialized = false;

// Add event handlers for mission end to save markers
addMissionEventHandler ["Ended", {
    call PersistentMarkers_fnc_saveMarkers;
}];

// Add key handler for manual save (optional - Ctrl+Shift+S)
(findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    // Ctrl+Shift+S to manually save markers
    if (_key == 31 && _shift && _ctrl) then {
        call PersistentMarkers_fnc_saveMarkers;
        systemChat "Map markers saved!";
        true
    } else {
        false
    };
}];

// Set initialization flag
PersistentMarkers_Initialized = true;

// Notify player that the mod has loaded
systemChat "Persistent Markers: Mod loaded and ready";
diag_log "Persistent Markers: System initialized";
