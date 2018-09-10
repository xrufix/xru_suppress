#include "script_component.hpp"

params ["_unit", "_weapon", "", "", "_ammo", "", "_projectile", ""];

if (_unit == ace_player) exitWith {};
if (_unit == vehicle ace_player) exitWith {};
if ((vehicle ace_player != ace_player) && !(isTurnedOut ace_player)) exitWith {};
if ((tolower _weapon) in ["put", "throw"]) exitWith {};
if (ace_player distance _unit > 2000) exitWith {};
if (ace_player distance _unit < 10) exitWith {};

if (isNull _projectile) then {
    _projectile = nearestObject [_unit, _ammo];
};

private _hit = getNumber (configfile >> "CfgAmmo" >> _ammo >> "hit");

// Reduce the effect if the player is behind cover
private _intersections = lineIntersectsSurfaces [eyePos ace_player, getPosASL _projectile, _unit, ace_player];
if (count _intersections != 0) then {
    _hit = _hit / 3;
};

private _radius = 10 min (_hit / 2);

GVAR(bullets) pushBack [_projectile,_hit,_radius];

#ifdef DEBUG_MODE_FULL
    systemChat str [_projectile,_hit,_radius];
#endif
