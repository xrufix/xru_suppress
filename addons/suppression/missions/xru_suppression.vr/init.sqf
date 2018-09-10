#include "..\..\script_component.hpp"

player createDiaryRecord ["Diary", [
    (localize LSTRING(mission_diary_title)),
    (localize LSTRING(mission_diary_l1))+"<br/>"+
    (localize LSTRING(mission_diary_l2))+"<br/>"+
    (localize LSTRING(mission_diary_l3))+"<br/>"+
    (localize LSTRING(mission_diary_l4))+"<br/>"+
    (localize LSTRING(mission_diary_l5))
]];

(allCurators select 0) addCuratorEditableObjects [allMissionObjects "All", true];

player addAction [localize LSTRING(mission_action), {
    [10, 2, 5] call FUNC(effect);
}, nil, 1.5, true, true, "defaultAction"];
