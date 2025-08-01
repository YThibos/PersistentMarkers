class CfgPatches
{
    class PersistentMarkers_Antistasi_ACE
    {
        name = "Persistent Map Markers - Antistasi & ACE Compatible";
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
    class PersistentMarkers_Antistasi_ACE
    {
        class Functions
        {
            file = "\persistent-markers-antistasi-ace\functions";
            class saveMarkers {};
            class loadMarkers {};
            class initPersistentMarkers {};
            class addACEInteractions {};
            class antistasi_saveHook {};
            class antistasi_loadHook {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class PersistentMarkers_Antistasi_ACE
    {
        init = "call PersistentMarkers_Antistasi_ACE_fnc_initPersistentMarkers";
    };
};

class Extended_PostInit_EventHandlers
{
    class PersistentMarkers_Antistasi_ACE
    {
        init = "[] spawn {waitUntil {!isNull player && time > 0}; call PersistentMarkers_Antistasi_ACE_fnc_loadMarkers; call PersistentMarkers_Antistasi_ACE_fnc_addACEInteractions;};";
    };
};

// ACE Map Integration
class ACE_Settings {
    class PersistentMarkers_Antistasi_enableAutoSave {
        displayName = "Enable Auto Save with Antistasi";
        description = "Automatically save markers when Antistasi performs persistent saves";
        typeName = "BOOL";
        value = 1;
        category = "Persistent Markers";
    };

    class PersistentMarkers_Antistasi_filterSystemMarkers {
        displayName = "Filter Antistasi System Markers";
        description = "Exclude Antistasi system markers from persistent saves";
        typeName = "BOOL";
        value = 1;
        category = "Persistent Markers";
    };
};
