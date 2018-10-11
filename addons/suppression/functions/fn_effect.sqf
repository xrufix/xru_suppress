#include "script_component.hpp"

params [["_hit",10,[1]],["_distance",5,[1]],["_radius",10,[1]]];

if ((vehicle ace_player != ace_player) && {!isTurnedOut ace_player}) exitWith {};

private _impact = (10 min (_hit / 3)) * (1 - _distance / _radius);
private _suppression = ace_player getVariable [QGVAR(suppression), 0];
_suppression = 0.25 max (_suppression + _impact / 100) min 1;
ace_player setVariable [QGVAR(suppression), _suppression];

#ifdef DEBUG_MODE_FULL
    systemChat format ["hit: %1 – dist: %2 – rad: %3 | impact: %4 – suppression: %5", _hit, _distance, _radius, _impact, _suppression];
#endif

if (GVAR(camShake) != 0) then {
    addCamShake [_impact * GVAR(camShake) / 2, 0.3, 30];
};

if (GVAR(blinking) != 0) then {
    GVAR(blinkingBlur) ppEffectAdjust [_impact * GVAR(blinking) / 2];
    GVAR(blinkingBlur) ppEffectCommit 0;
    GVAR(blinkingBlur) ppEffectAdjust [0];
    GVAR(blinkingBlur) ppEffectCommit (0.2 + _impact / 10);
};

ace_player setVariable [QGVAR(lastShotAt), time];
