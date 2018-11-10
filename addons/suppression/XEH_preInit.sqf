#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// GVARs
GVAR(hitHash) = [] call CBA_fnc_hashCreate;
GVAR(bullets) = [];
GVAR(lastReduce) = 0;
GVAR(PFH) = -1;

// CBA Settings
[QGVAR(enabled), "CHECKBOX", [localize LSTRING(settings_enabled), localize LSTRING(settings_enabled_tooltip)], COMPONENT_NAME, false, true, {}, true] call CBA_settings_fnc_init;
[QGVAR(enableSpectator), "CHECKBOX", [localize LSTRING(settings_enableSpectator), localize LSTRING(settings_enableSpectator_tooltip)], COMPONENT_NAME, false, false, {
	params ["_setting"];
	if (!_setting) exitWith {};
	if (GVAR(PFH) == -1) then {
		GVAR(PFH) = [{call FUNC(PFH)}] call CBA_fnc_addPerFrameHandler;
	};
}, false] call CBA_settings_fnc_init;
[QGVAR(blinking), "SLIDER", [localize LSTRING(settings_blinking), localize LSTRING(settings_blinking_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(camshake), "SLIDER", [localize LSTRING(settings_camshake), localize LSTRING(settings_camshake_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(tunnelVision), "SLIDER", [localize LSTRING(settings_tunnelVision), localize LSTRING(settings_tunnelVision_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;
[QGVAR(weaponSway), "SLIDER", [localize LSTRING(settings_weaponSway), localize LSTRING(settings_weaponSway_tooltip)], COMPONENT_NAME, [0,2,1,1], true] call CBA_settings_fnc_init;

// Exit if not a player or not enabled
if (!hasInterface) exitWith {};
if (!GVAR(enabled)) exitWith {};

// Add Fired Eventhandler to all classes.
["All", "Fired", {call FUNC(fired)}, true] call CBA_fnc_addClassEventHandler;

// Initialize PPE
GVAR(tunnelVisionCC) = ppEffectCreate ["colorCorrections", 1452];
GVAR(tunnelVisionCC) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1], [1,1,1,0], [1,1,0,0,0,1,0]];
GVAR(tunnelVisionCC) ppEffectEnable true;
GVAR(tunnelVisionCC) ppEffectForceInNVG true;
GVAR(tunnelVisionCC) ppEffectCommit 0;

GVAR(blinkingBlur) = ppEffectCreate ["DynamicBlur", 776];
GVAR(blinkingBlur) ppEffectAdjust [0];
GVAR(blinkingBlur) ppEffectEnable true;
GVAR(blinkingBlur) ppEffectForceInNVG true;
GVAR(blinkingBlur) ppEffectCommit 0;

// Add PFH for effects
GVAR(isSpectator) = player isKindOf "VirtualSpectator_F";
GVAR(PFH) = [{call FUNC(PFH)}] call CBA_fnc_addPerFrameHandler;

ADDON = true;
