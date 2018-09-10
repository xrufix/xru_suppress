#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = "xrufix";
        url = "http://www.gruppe-w.de";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "ace_common"};
        VERSION_CONFIG;
        ammo[] = {};
        magazines[] = {};
        units[] = {};
        weapons[] = {};
    };
};

class CfgMods {
    class ADDON {
        name = COMPONENT_NAME;
        actionName = "Website";
        action = "http://www.gruppe-w.de";
        description = "Gruppe W e.V.";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMissions.hpp"
