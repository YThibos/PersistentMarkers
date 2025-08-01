class CfgPatches
{
    class PersistentMarkers_ACE
    {
        name = "Persistent Map Markers - ACE Compatible";
        author = "Your Name";
        url = "";
        requiredVersion = 2.00;
        requiredAddons[] = {"A3_Functions_F", "ace_main", "ace_interact_menu", "ace_map"};
        units[] = {};
        weapons[] = {};
        version = "1.0";
    };
};

class CfgFunctions
{
    class PersistentMarkers_ACE
    {
        class Functions
        {
            file = "\persistent-markers-ace\functions";
            class saveMarkers {};
            class loadMarkers {};
            class initPersistentMarkers {};
            class addACEInteractions {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class PersistentMarkers_ACE
    {
        init = "call PersistentMarkers_ACE_fnc_initPersistentMarkers";
    };
};

class Extended_PostInit_EventHandlers
{
    class PersistentMarkers_ACE
    {
        init = "[] spawn {waitUntil {!isNull player && time > 0}; call PersistentMarkers_ACE_fnc_loadMarkers; call PersistentMarkers_ACE_fnc_addACEInteractions;};";
    };
};

// ACE Map Integration
class ACE_Settings {
    class PersistentMarkers_enableAutoSave {
        displayName = "Enable Auto Save";
        description = "Automatically save markers on mission end";
        typeName = "BOOL";
        value = 1;
        category = "Persistent Markers";
    };
    class PersistentMarkers_shareMarkers {
        displayName = "Share Markers with Team";
        description = "Share persistent markers with team members";
        typeName = "BOOL";
        value = 0;
        category = "Persistent Markers";
    };
};
