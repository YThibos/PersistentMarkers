/*
    Function: PersistentMarkers_Antistasi_ACE_fnc_antistasi_saveHook
    Description: Hook function that integrates with Antistasi's persistent save system with ACE notifications
    Parameters: None
    Returns: Nothing
*/

// Only save if we're in an Antistasi environment
if (isNil "teamPlayer" || isNil "serverSaveInProgress") exitWith {
    diag_log "Persistent Markers Antistasi-ACE: Not in Antistasi environment, skipping save hook";
};

// Wait for Antistasi's save to be in progress before we save our markers
if (!serverSaveInProgress) exitWith {
    diag_log "Persistent Markers Antistasi-ACE: Antistasi save not in progress, skipping marker save";
};

diag_log "Persistent Markers Antistasi-ACE: Antistasi save detected, saving markers alongside persistent data";

// Call the main save function
call PersistentMarkers_Antistasi_ACE_fnc_saveMarkers;

// Optional: Add markers to Antistasi's persistent data if possible
// This would require knowledge of Antistasi's save structure
if (!isNil "saveData" && typeName saveData == "ARRAY") then {
    private _markerData = profileNamespace getVariable ["PersistentMarkers_Antistasi_ACE_SavedMarkers", []];
    if (count _markerData > 0) then {
        // Try to integrate with Antistasi's save data structure
        // Note: This is a hypothetical integration - actual implementation would depend on Antistasi's structure
        saveData pushBack ["PersistentMarkers", _markerData];
        diag_log format ["Persistent Markers Antistasi-ACE: Added %1 markers to Antistasi save data", count _markerData];

        // Show ACE notification about successful integration
        if (hasInterface && isClass (configFile >> "CfgPatches" >> "ace_common")) then {
            [format ["Markers integrated with Antistasi save (%1 markers)", count _markerData], 2] call ace_common_fnc_displayTextStructured;
        };
    };
};
