/*
    Function: PersistentMarkers_ACE_fnc_loadMarkers
    Description: Loads previously saved map markers from profile namespace with ACE integration
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

// Get saved marker data from profile namespace
private _markerData = profileNamespace getVariable ["PersistentMarkers_ACE_SavedMarkers", []];

if (count _markerData == 0) exitWith {
    diag_log "Persistent Markers ACE: No saved markers found";
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
        "_markerAlpha",
        "_markerChannel"
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

        // ACE-specific: Set marker channel if applicable
        if (!isNil "_markerChannel" && _markerChannel != -1) then {
            _newMarker setMarkerChannel _markerChannel;
        };

        _loadedCount = _loadedCount + 1;
    };
} forEach _markerData;

// ACE notification
if (_loadedCount > 0) then {
    [format ["Loaded %1 persistent markers", _loadedCount], 2] call ace_common_fnc_displayTextStructured;
    diag_log format ["Persistent Markers ACE: Successfully loaded %1 markers", _loadedCount];
} else {
    ["No markers were loaded", 1.5] call ace_common_fnc_displayTextStructured;
    diag_log "Persistent Markers ACE: No markers were loaded";
};

true
