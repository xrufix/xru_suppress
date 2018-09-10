#include "script_component.hpp"

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
[{call FUNC(PFH)}] call CBA_fnc_addPerFrameHandler;
