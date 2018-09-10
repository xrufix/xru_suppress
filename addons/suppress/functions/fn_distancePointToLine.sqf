#include "script_component.hpp"

params ["_point", "_linePoint1", "_linePoint2"];

vectorMagnitude ( ( _point vectorDiff _linePoint1 ) vectorCrossProduct ( _point vectorDiff _linePoint2 ) ) 
/
vectorMagnitude ( _linePoint2 vectorDiff _linePoint1 )