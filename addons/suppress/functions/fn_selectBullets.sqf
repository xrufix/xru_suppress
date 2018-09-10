#include "script_component.hpp"

params ["_bulletArgs", "_timeFactor"];
_bulletArgs params ["_bullet", "_hit", "_radius", "_lastPos"];

if (!alive _bullet) then {false} else {

    private _currPos = getPosASL _bullet;
    _bulletArgs set [3, _currPos];

    private _distance = _lastPos distance (eyePos ace_player);

    if (_distance > 20) then {true} else {
        private _distanceToPath = [eyePos ace_player, _lastPos, _currPos] call FUNC(distancePointToLine);
        if (_distanceToPath > _radius) then {true} else {
            [_hit, _distanceToPath, _radius] call FUNC(effect);
            false
        };
    };
};
