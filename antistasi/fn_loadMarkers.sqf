/*
    Function: PersistentMarkers_Antistasi_fnc_loadMarkers
    Description: Loads previously saved map markers from profile namespace with Antistasi integration
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

// Get saved marker data from profile namespace
private _markerData = profileNamespace getVariable ["PersistentMarkers_Antistasi_SavedMarkers", []];

if (count _markerData == 0) exitWith {
    diag_log "Persistent Markers Antistasi: No saved markers found";
    false
};

// In Antistasi, we should be more careful about clearing existing markers
// Only clear user markers, not Antistasi system markers
private _markersToDelete = [];
{
    private _markerName = _x;
    private _isSystemMarker = false;

    // Check if this is an Antistasi system marker
    if (_markerName find "garrison_" == 0 ||
        _markerName find "attack_" == 0 ||
        _markerName find "defend_" == 0 ||
        _markerName find "spawn_" == 0 ||
        _markerName find "roadblock_" == 0 ||
        _markerName find "factory_" == 0 ||
        _markerName find "resource_" == 0 ||
        _markerName find "outpost_" == 0) then {
        _isSystemMarker = true;
    };

    // Only delete non-system markers
    if (!_isSystemMarker) then {
        _markersToDelete pushBack _markerName;
    };
} forEach allMapMarkers;

// Delete user markers
{
    deleteMarker _x;
} forEach _markersToDelete;

private _loadedCount = 0;

// Restore each saved marker
{
    _x params [
        "_markerName",
        "_markerPos",
        "_markerType",
        "_markerText",
        "_markerColor",
        "_markerSize",
        "_markerDir",
        "_markerShape",
        "_markerBrush",
        "_markerAlpha"
    ];

    // Create the marker with a unique name to avoid conflicts
    private _uniqueMarkerName = _markerName;
    private _counter = 0;
    while {getMarkerType _uniqueMarkerName != ""} do {
        _counter = _counter + 1;
        _uniqueMarkerName = format ["%1_%2", _markerName, _counter];
    };

    private _newMarker = createMarker [_uniqueMarkerName, _markerPos];

    if (_newMarker != "") then {
        _newMarker setMarkerType _markerType;
        _newMarker setMarkerText _markerText;
        _newMarker setMarkerColor _markerColor;
        _newMarker setMarkerSize _markerSize;
        _newMarker setMarkerDir _markerDir;
        _newMarker setMarkerShape _markerShape;
        _newMarker setMarkerBrush _markerBrush;
        _newMarker setMarkerAlpha _markerAlpha;

        _loadedCount = _loadedCount + 1;
    };
} forEach _markerData;

// Log the load operation
diag_log format ["Persistent Markers Antistasi: Successfully loaded %1 markers", _loadedCount];

// Notify player if in multiplayer
if (hasInterface && _loadedCount > 0) then {
    systemChat format ["Persistent Markers Antistasi: Restored %1 saved markers", _loadedCount];
} else if (hasInterface) then {
    systemChat "Persistent Markers Antistasi: No markers to restore";
};

true
