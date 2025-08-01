/*
    Function: PersistentMarkers_fnc_loadMarkers
    Description: Loads previously saved map markers from profile namespace
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

// Get saved marker data from profile namespace
private _markerData = profileNamespace getVariable ["PersistentMarkers_SavedMarkers", []];

if (count _markerData == 0) exitWith {
    diag_log "Persistent Markers: No saved markers found";
    false
};

// Clear existing markers first (optional - comment out if you want to keep existing markers)
{
    deleteMarker _x;
} forEach allMapMarkers;

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

    // Create the marker
    private _newMarker = createMarker [_markerName, _markerPos];

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
diag_log format ["Persistent Markers: Loaded %1 out of %2 saved markers", _loadedCount, count _markerData];

// Return success
true
