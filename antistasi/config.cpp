class CfgPatches
{
    class PersistentMarkers_Antistasi
    {
        name = "Persistent Map Markers - Antistasi Compatible";
        author = "Your Name";
        url = "";
        requiredVersion = 2.00;
        requiredAddons[] = {"A3_Functions_F"};
        units[] = {};
        weapons[] = {};
        version = "1.0";
    };
};

class CfgFunctions
{
    class PersistentMarkers_Antistasi
    {
        class Functions
        {
            file = "\persistent-markers-antistasi\functions";
            class saveMarkers {};
            class loadMarkers {};
            class initPersistentMarkers {};
            class antistasi_saveHook {};
            class antistasi_loadHook {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class PersistentMarkers_Antistasi
    {
        init = "call PersistentMarkers_Antistasi_fnc_initPersistentMarkers";
    };
};

class Extended_PostInit_EventHandlers
{
    class PersistentMarkers_Antistasi
    {
        init = "[] spawn {waitUntil {!isNull player && time > 0}; call PersistentMarkers_Antistasi_fnc_loadMarkers;};";
    };
};
