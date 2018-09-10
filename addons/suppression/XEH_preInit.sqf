#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// GVARs
GVAR(bullets) = [];
GVAR(lastReduce) = 0;

// CBA Settings
[QGVAR(enabled), "CHECKBOX", [localize LSTRING(settings_enabled), localize LSTRING(settings_enabled_tooltip)], COMPONENT_NAME, false, true, {}, true] call CBA_settings_fnc_init;
[QGVAR(blinking), "SLIDER", [localize LSTRING(settings_blinking), localize LSTRING(settings_blinking_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(camshake), "SLIDER", [localize LSTRING(settings_camshake), localize LSTRING(settings_camshake_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(tunnelVision), "SLIDER", [localize LSTRING(settings_tunnelVision), localize LSTRING(settings_tunnelVision_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(weaponSway), "SLIDER", [localize LSTRING(settings_weaponSway), localize LSTRING(settings_weaponSway_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;

ADDON = true;
