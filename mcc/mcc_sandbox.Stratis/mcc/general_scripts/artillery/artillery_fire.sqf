private ["_sound", "_pos", "_shelltype", "_shellspread", "_nshell","_lasertargets","_nul","_x","_simulate"];
_pos					 = _this select 0; 
_shelltype 			     = _this select 1; 
_shellspread			 = _this select 2; 
_nshell 				 = _this select 3; 
_simulate				 = _this select 4; 

_sound = true;

switch (_simulate) do
			{
				case 0:	//DPICM
			    { 
					[_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_DPICM;
				};
				
				case 1:	//Bomb
			    { 
					[_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_BOMB;
				};
				
				case 2:	//FLare 
			    { 
					[_pos, _shelltype, _shellspread, _nshell, _sound] spawn MCC_ARTY_FLARE;
				};
				
				case 3:	// Laser-guided
			    { 
					_sound = true;
					_lasertargets = [];
					for [{_x = 0},{_x < _nshell},{_x = _x+1}] do	{
						_lasertargets = nearestObjects[_pos,["LaserTarget"],500]; 
						if (count _lasertargets == 0) then { 						//No laser target act as normal barage
							[_pos, "Sh_120mm_AMOS_LG", _shellspread, 1, _sound] spawn MCC_ARTY_BOMB;
							};
						if (!isnull (_lasertargets select 0)) then { 				//Laser target lock on LT
								_nul=[(_lasertargets select 0), [_pos select 0, _pos select 1, 200],_shelltype,100,true,""] execVM MCC_path + "mcc\general_scripts\CAS\missile_guide.sqf"; 
								};
					sleep random 3; 
					};
				};
			};
		