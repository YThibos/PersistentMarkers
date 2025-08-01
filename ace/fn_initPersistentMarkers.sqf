/*
    Function: PersistentMarkers_ACE_fnc_initPersistentMarkers
    Description: Initializes the persistent markers system with ACE integration
    Parameters: None
    Returns: Nothing
*/

// Initialize variables
PersistentMarkers_ACE_Initialized = false;

// Check if ACE is loaded
if (!isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {
    diag_log "Persistent Markers ACE: ACE not detected, initialization failed";
    false
};

// Add event handlers for mission end to save markers
addMissionEventHandler ["Ended", {
    if (["PersistentMarkers_enableAutoSave", 1] call ace_common_fnc_getSetting) then {
        call PersistentMarkers_ACE_fnc_saveMarkers;
    };
}];

// ACE keybinding for manual save (replaces vanilla key handler)
["PersistentMarkers", "saveMarkers", "Save Map Markers", {
    call PersistentMarkers_ACE_fnc_saveMarkers;
    ["Map markers saved!", 1.5] call ace_common_fnc_displayTextStructured;
}, {false}, [31, [true, true, false]]] call ace_keybinding_fnc_addKeyHandler; // Ctrl+Shift+S

// Add ACE self-interaction menu entry
private _action = ["saveMarkers", "Save Map Markers", "", {
    call PersistentMarkers_ACE_fnc_saveMarkers;
    ["Map markers saved!", 1.5] call ace_common_fnc_displayTextStructured;
}, {true}] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// Set initialization flag
PersistentMarkers_ACE_Initialized = true;

diag_log "Persistent Markers ACE: System initialized with ACE integration";
