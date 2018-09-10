#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// GVARs
GVAR(bullets) = [];
GVAR(lastReduce) = 0;

// CBA Settings
[QGVAR(enabled), "CHECKBOX", ["Enable Effects", "Enable to use suppression effects"], COMPONENT_NAME, false, true, {}, true] call CBA_settings_fnc_init;
[QGVAR(blinking), "SLIDER", ["Blinking", "Amount of blur when bullets pass nearby. Set to 0 to disable"], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(camshake), "SLIDER", ["Camshake", "Amount of camshake when bullets pass nearby. Set to 0 to disable"], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(tunnelVision), "SLIDER", ["Tunnelvision", "Narrows the field of view relative to suppression. Set to 0 to disable"], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(weaponSway), "SLIDER", ["Weapon Sway", "Increases weapon sway relative to suppression. Set to 0 to disable"], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;

ADDON = true;
