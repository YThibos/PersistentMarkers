/*
    Function: PersistentMarkers_ACE_fnc_addACEInteractions
    Description: Adds ACE interaction menu entries for marker management
    Parameters: None
    Returns: Nothing
*/

// Add self-interaction menu for marker management
private _markerMenu = ["markerManagement", "Marker Management", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _markerMenu] call ace_interact_menu_fnc_addActionToObject;

// Save markers action
private _saveAction = ["saveMarkers", "Save Current Markers", "", {
    call PersistentMarkers_ACE_fnc_saveMarkers;
}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "markerManagement"], _saveAction] call ace_interact_menu_fnc_addActionToObject;

// Load markers action
private _loadAction = ["loadMarkers", "Load Saved Markers", "", {
    call PersistentMarkers_ACE_fnc_loadMarkers;
}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "markerManagement"], _loadAction] call ace_interact_menu_fnc_addActionToObject;

// Clear all markers action
private _clearAction = ["clearMarkers", "Clear All Markers", "", {
    private _count = count allMapMarkers;
    {
        deleteMarker _x;
    } forEach allMapMarkers;
    [format ["Cleared %1 markers", _count], 1.5] call ace_common_fnc_displayTextStructured;
}, {count allMapMarkers > 0}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "markerManagement"], _clearAction] call ace_interact_menu_fnc_addActionToObject;

// Share markers with team action (if enabled)
private _shareAction = ["shareMarkers", "Share Markers with Team", "", {
    private _markerData = [];
    {
        private _markerName = _x;
        _markerData pushBack [
            _markerName,
            getMarkerPos _markerName,
            getMarkerType _markerName,
            markerText _markerName,
            getMarkerColor _markerName,
            getMarkerSize _markerName,
            markerDir _markerName,
            markerShape _markerName,
            markerBrush _markerName,
            markerAlpha _markerName,
            markerChannel _markerName
        ];
    } forEach allMapMarkers;

    [_markerData] remoteExec ["PersistentMarkers_ACE_fnc_receiveSharedMarkers", allPlayers - [player]];
    [format ["Shared %1 markers with team", count _markerData], 2] call ace_common_fnc_displayTextStructured;
}, {
    ["PersistentMarkers_shareMarkers", 0] call ace_common_fnc_getSetting &&
    count allMapMarkers > 0
}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "markerManagement"], _shareAction] call ace_interact_menu_fnc_addActionToObject;

diag_log "Persistent Markers ACE: ACE interactions added";
