_this addEventHandler ["fired", {
	_null = _this spawn {
		(_this) call anrop_aar_fnc_eventUnitFired;
	};
}];

_this setVariable ["anrop_aar", true];	// local note that the unit has EHs added
