/*
    Function: PersistentMarkers_fnc_saveMarkers
    Description: Saves all current map markers to a profile namespace variable
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

private _markerData = [];

// Get all markers
private _allMarkers = allMapMarkers;

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

    // Only save user-created markers (not system markers)
    if (_markerType != "" || _markerText != "") then {
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
            _markerAlpha
        ];
    };
} forEach _allMarkers;

// Save to profile namespace
profileNamespace setVariable ["PersistentMarkers_SavedMarkers", _markerData];
saveProfileNamespace;

// Log the save operation
diag_log format ["Persistent Markers: Saved %1 markers", count _markerData];

// Return success
true
