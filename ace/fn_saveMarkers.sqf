/*
    Function: PersistentMarkers_ACE_fnc_saveMarkers
    Description: Saves current map markers to profile namespace with ACE integration
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

// Get all current map markers
private _allMarkers = allMapMarkers;

if (count _allMarkers == 0) exitWith {
    ["No markers to save", 1.5] call ace_common_fnc_displayTextStructured;
    diag_log "Persistent Markers ACE: No markers to save";
    false
};

private _markerData = [];

// Save each marker's properties
{
    private _markerName = _x;
    private _markerPos = getMarkerPos _markerName;
    private _markerType = getMarkerType _markerName;
    private _markerText = markerText _markerName;
    private _markerColor = getMarkerColor _markerName;
    private _markerSize = getMarkerSize _markerName;
    private _markerDir = markerDir _markerName;
    private _markerShape = markerShape _markerName;
    private _markerBrush = markerBrush _markerName;
    private _markerAlpha = markerAlpha _markerName;

    // ACE-specific: Get marker channel
    private _markerChannel = -1;
    if (hasInterface) then {
        _markerChannel = markerChannel _markerName;
    };

    // Store marker data
    _markerData pushBack [
        _markerName,
        _markerPos,
        _markerType,
        _markerText,
        _markerColor,
        _markerSize,
        _markerDir,
        _markerShape,
        _markerBrush,
        _markerAlpha,
        _markerChannel
    ];
} forEach _allMarkers;

// Save to profile namespace
profileNamespace setVariable ["PersistentMarkers_ACE_SavedMarkers", _markerData];
saveProfileNamespace;

// ACE notification
[format ["Saved %1 markers", count _markerData], 2] call ace_common_fnc_displayTextStructured;
diag_log format ["Persistent Markers ACE: Successfully saved %1 markers", count _markerData];

// Share markers with team if enabled
if (["PersistentMarkers_shareMarkers", 0] call ace_common_fnc_getSetting) then {
    [_markerData] remoteExec ["PersistentMarkers_ACE_fnc_receiveSharedMarkers", allPlayers];
};

true
