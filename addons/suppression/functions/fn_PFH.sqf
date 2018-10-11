#include "script_component.hpp"

if (GVAR(isSpectator) && {!GVAR(enableSpectator)}) exitWith {
    GVAR(PFH) call CBA_fnc_removePerFrameHandler;
    GVAR(PFH) = -1;
};

private _timeFactor = (time - GVAR(lastReduce));
private _lastShotAt = ace_player getVariable [QGVAR(lastShotAt), 0];

GVAR(bullets) = GVAR(bullets) select {
    [_x, _timeFactor] call FUNC(selectBullets);
};

private _suppression = ace_player getVariable [QGVAR(suppression), 0];
_suppression = 0 max (_suppression - _timeFactor * (((time - _lastShotAt) / 20) min 1) ^ 2);
ace_player setVariable [QGVAR(suppression), _suppression];

if (_suppression > 0) then {
    if (GVAR(Tunnelvision) > 0) then {
        private _inner = 1 - ( (GVAR(tunnelVision) / 2) ^ ( 2/3 ) )* (_suppression ^ (1/3) );
        private _outer = 1 - (_suppression / 3 * GVAR(tunnelVision));
        GVAR(tunnelVisionCC) ppEffectAdjust [1, 1, 0, [0,0,0,1], [1,1,1,1], [1,1,1,0], [_outer, _outer, 0, 0, 0, _inner, 0.5]];
        GVAR(tunnelVisionCC) ppEffectCommit 0;
    };
    if (GVAR(weaponSway) > 0) then {
        [ace_player, QUOTE(ADDON), GVAR(weaponSway) * 15 * (_suppression ^ 1)] call ace_common_fnc_setAimCoef;
    };
} else {
    [ace_player, QUOTE(ADDON), 0, false] call ace_common_fnc_setAimCoef;
};

#ifdef DEBUG_MODE_FULL
    hintSilent format [
        QUOTE(ADDON) + ": \n"
        + "Suppression: %1 \n"
        + "Redcution Factor: %2 \n"
        + "Last Shot at ace_player: %3s ago. \n"
        + "Weapon Sway: %4 \n"
        + "Tracked Bullets: \n %5",
        _suppression,
        _timeFactor,
        0.1 * round ((time - _lastShotAt) * 10),
        getCustomAimCoef ace_player,
        GVAR(bullets)
    ];
#endif

GVAR(lastReduce) = time;
