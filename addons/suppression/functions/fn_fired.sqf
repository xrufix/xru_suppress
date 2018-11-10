#include "script_component.hpp"

params ["_unit", "_weapon", "", "", "_ammo", "", "_projectile", ""];

// Exit conditions
if (vehicle _unit == vehicle ace_player) exitWith {};
if (ace_player distance _unit > 2000) exitWith {};
if (ace_player distance _unit < 10) exitWith {};
if ((tolower _weapon) in ["put", "throw"]) exitWith {};

if (isNull _projectile) then {
    _projectile = nearestObject [_unit, _ammo];
};
private _positionProjectile = getPosASL _projectile;
private _positionPlayer = eyePos ace_player;

// Exit if not pointed towards player
private _cos = (velocity _projectile) vectorCos (_positionProjectile vectorFromTo _positionPlayer);
if (_cos < 0.95) exitWith {};

// Get hit value from config or cache
if !([GVAR(hitHash), _ammo] call CBA_fnc_hashHasKey) then {
    [GVAR(hitHash), _ammo, getNumber (configfile >> "CfgAmmo" >> _ammo >> "hit")] call CBA_fnc_hashSet;
    TRACE_2("Hashed hit value",_ammo,_hit);
};
private _hit = [GVAR(hitHash), _ammo] call CBA_fnc_hashGet;

// Reduce the effect if the player is behind cover
private _intersections = lineIntersectsSurfaces [_positionPlayer, _positionProjectile, vehicle _unit, vehicle ace_player];
if (count _intersections != 0) then {
    _hit = _hit / 3;
};
private _radius = 10 min (_hit / 2);

GVAR(bullets) pushBack [_projectile, _hit, _radius, _positionProjectile];
