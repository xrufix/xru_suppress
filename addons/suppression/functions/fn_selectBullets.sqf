#include "script_component.hpp"

params ["_bulletArgs", "_timeFactor"];
_bulletArgs params ["_bullet", "_hit", "_radius", "_lastPos"];

if (!alive _bullet) exitWith {false};

private _currPos = getPosASL _bullet;
if (_currPos == _lastPos) exitWith {true};
_bulletArgs set [3, _currPos];

if ((_lastPos distance (eyePos ace_player)) > 20) exitWith {true};

private _distanceToPath = [eyePos ace_player, _lastPos, _currPos] call FUNC(distancePointToLine);
if (_distanceToPath > _radius) exitWith {true};

[_hit, _distanceToPath, _radius] call FUNC(effect);
false
