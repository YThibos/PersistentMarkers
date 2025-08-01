/*
    Function: PersistentMarkers_Antistasi_fnc_antistasi_loadHook
    Description: Hook function that integrates with Antistasi's data loading system
    Parameters: None
    Returns: Nothing
*/

// Only load if we're in an Antistasi environment
if (isNil "teamPlayer") exitWith {
    diag_log "Persistent Markers Antistasi: Not in Antistasi environment, skipping load hook";
};

diag_log "Persistent Markers Antistasi: Antistasi environment detected, attempting to load markers";

// Wait a bit for Antistasi to finish its own loading process
[] spawn {
    sleep 10; // Give Antistasi time to load its data

    // Try to extract marker data from Antistasi's save data if available
    if (!isNil "loadedData" && typeName loadedData == "ARRAY") then {
        private _persistentMarkersData = [];

        // Look for our marker data in Antistasi's loaded data
        {
            if (typeName _x == "ARRAY" && count _x >= 2) then {
                if (_x select 0 == "PersistentMarkers") then {
                    _persistentMarkersData = _x select 1;
                    diag_log format ["Persistent Markers Antistasi: Found marker data in Antistasi save: %1 markers", count _persistentMarkersData];
                };
            };
        } forEach loadedData;

        // If we found marker data in Antistasi's save, use it
        if (count _persistentMarkersData > 0) then {
            profileNamespace setVariable ["PersistentMarkers_Antistasi_SavedMarkers", _persistentMarkersData];
            saveProfileNamespace;
        };
    };

    // Load markers from profile namespace
    call PersistentMarkers_Antistasi_fnc_loadMarkers;

    diag_log "Persistent Markers Antistasi: Load hook completed";
};
