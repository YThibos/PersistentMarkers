// Log the load operation
diag_log format ["Persistent Markers Antistasi-ACE: Successfully loaded %1 markers (preserved %2 Antistasi markers, %3 conflicts resolved)", _loadedCount, _preservedCount, _conflictCount];

// Show detailed ACE notification
if (hasInterface && isClass (configFile >> "CfgPatches" >> "ace_common")) then {
    private _message = format ["Loaded %1 markers", _loadedCount];
    if (_preservedCount > 0) then {
        _message = _message + format [" (preserved %1 Antistasi)", _preservedCount];
    };
    if (_conflictCount > 0) then {
        _message = _message + format [" (%1 renamed)", _conflictCount];
    };
    [_message, 3] call ace_common_fnc_displayTextStructured;
} else {
    systemChat format ["Persistent Markers: Loaded %1 markers", _loadedCount];
};

// Additional system chat notification for marker restoration
if (hasInterface) then {
    if (_loadedCount > 0) then {
        systemChat format ["Persistent Markers Antistasi-ACE: Restored %1 saved markers", _loadedCount];
    } else {
        systemChat "Persistent Markers Antistasi-ACE: No markers to restore";
    };
};

true
