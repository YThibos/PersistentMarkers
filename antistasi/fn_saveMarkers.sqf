/*
    Function: PersistentMarkers_Antistasi_fnc_saveMarkers
    Description: Saves current map markers to profile namespace with Antistasi integration
    Parameters: None
    Returns: Boolean - true if successful, false otherwise
*/

// Get all current map markers
private _allMarkers = allMapMarkers;

if (count _allMarkers == 0) exitWith {
    diag_log "Persistent Markers Antistasi: No markers to save";
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

    // Only save user-created markers (not system markers)
    // Also filter out Antistasi-specific markers that shouldn't be persistent
    private _skipMarker = false;

    // Skip empty markers
    if (_markerType == "" && _markerText == "") then {
        _skipMarker = true;
    };

    // Skip Antistasi system markers (common prefixes)
    if (_markerName find "garrison_" == 0 ||
        _markerName find "attack_" == 0 ||
        _markerName find "defend_" == 0 ||
        _markerName find "spawn_" == 0 ||
        _markerName find "roadblock_" == 0) then {
        _skipMarker = true;
    };

    if (!_skipMarker) then {
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

// Save to profile namespace with Antistasi-specific key
profileNamespace setVariable ["PersistentMarkers_Antistasi_SavedMarkers", _markerData];
saveProfileNamespace;

// Log the save operation
diag_log format ["Persistent Markers Antistasi: Saved %1 markers", count _markerData];

// Notify player if in multiplayer
if (hasInterface) then {
    systemChat format ["Persistent Markers: Saved %1 markers", count _markerData];
};

true
