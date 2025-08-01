class CfgPatches
{
    class PersistentMarkers
    {
        name = "Persistent Map Markers";
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
    class PersistentMarkers
    {
        class Functions
        {
            file = "\persistent-markers\functions";
            class saveMarkers {};
            class loadMarkers {};
            class initPersistentMarkers {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class PersistentMarkers
    {
        init = "call PersistentMarkers_fnc_initPersistentMarkers";
    };
};

class Extended_PostInit_EventHandlers
{
    class PersistentMarkers
    {
        init = "[] spawn {waitUntil {!isNull player && time > 0}; call PersistentMarkers_fnc_loadMarkers;};";
    };
};
