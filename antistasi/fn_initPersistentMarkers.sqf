/*
    Function: PersistentMarkers_Antistasi_fnc_initPersistentMarkers
    Description: Initializes the persistent markers system with Antistasi integration
    Parameters: None
    Returns: Nothing
*/

// Initialize variables
PersistentMarkers_Antistasi_Initialized = false;

// Add event handlers for mission end to save markers
addMissionEventHandler ["Ended", {
    call PersistentMarkers_Antistasi_fnc_saveMarkers;
}];

// Add key handler for manual save (optional - Ctrl+Shift+S)
(findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    // Ctrl+Shift+S to manually save markers
    if (_key == 31 && _shift && _ctrl) then {
        call PersistentMarkers_Antistasi_fnc_saveMarkers;
        systemChat "Map markers saved!";
        true
    } else {
        false
    };
}];

// Hook into Antistasi's persistent save system
// We'll check for Antistasi variables and hook into their save/load functions
[] spawn {
    waitUntil {time > 10}; // Wait for Antistasi to initialize

    // Check if Antistasi is running
    if (!isNil "teamPlayer" && !isNil "serverSaveInProgress") then {
        diag_log "Persistent Markers Antistasi: Antistasi detected, integrating with persistent save system";

        // Monitor for Antistasi save operations
        [] spawn {
            private _lastSaveTime = 0;
            while {true} do {
                // Check if Antistasi is performing a persistent save
                if (!isNil "serverSaveInProgress" && {serverSaveInProgress}) then {
                    if (time - _lastSaveTime > 30) then { // Prevent duplicate saves
                        diag_log "Persistent Markers Antistasi: Antistasi save detected, saving markers";
                        call PersistentMarkers_Antistasi_fnc_antistasi_saveHook;
                        _lastSaveTime = time;
                    };
                };
                sleep 5;
            };
        };

        // Hook into Antistasi initialization to load markers when appropriate
        if (!isNil "initVarServer" && {initVarServer}) then {
            call PersistentMarkers_Antistasi_fnc_antistasi_loadHook;
        };
    } else {
        diag_log "Persistent Markers Antistasi: Antistasi not detected, using standard functionality";
    };
};

// Set initialization flag
PersistentMarkers_Antistasi_Initialized = true;

// Notify player that the mod has loaded
if (hasInterface) then {
    systemChat "Persistent Markers Antistasi: Mod loaded and ready";
};

diag_log "Persistent Markers Antistasi: System initialized with Antistasi integration";
