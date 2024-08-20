pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include globals.lua

-- Core functions and utilities
#include core/class.lua
#include core/log.lua
#include core/collision_engine.lua
#include core/state_machine.lua
#include core/game_states.lua
#include core/utils/timers.lua
#include core/utils/utils.lua


-- Entities
#include entities/paddle.lua
#include entities/ball.lua
#include entities/brick.lua
#include entities/level.lua

-- Levels
#include entities/levels/level_def.lua
#include entities/levels/level_parser.lua

-- Game States
#include states/init.lua
#include states/start.lua
#include states/game.lua
#include states/gameover.lua
#include states/levelup.lua
#include states/bonus.lua



-- collision handlers
#include collisions/paddle_collision_handler.lua
#include collisions/ball_collision_handler.lua
#include collisions/brick_collision_handler.lua


-------------
--game loop
-------------

function _init()
  cls()
  init_gamestates()
  init_players()
  init_objects()
  
  --start screen state
  set_gamestate("start")

  log("INI gamestate=".._gamestates["current"])
end

-- called every frame
function _update60()
  log("UPD gamestate=".._gamestates["current"])
  local gamestate = current_gamestate()
  if(gamestate != nil) gamestate:update()
end

-- called every frame
function _draw()
  log("DRW gamestate=".._gamestates["current"])
  local gamestate = current_gamestate()
  if(gamestate != nil) gamestate:draw()
end


__gfx__
00000000077007700000000000000000000000000700070007000500050005000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd00
088008e0788778e7000000000000000077777777776077607760555055505550d60606d0d61666d0d6ccc6d0d66866d0d6aa06d0d66866d0d66966d0d66666d0
0e8888807e888887000000000000000077777777060006000600050005000500d08080d0d61666d0d6c666d0d68986d0d660a0d0d68986d0d69a96d0d66a66d0
0e8888807e888887000000000000000077777777000000000000000000000000d08880d0d61666d0d66cc6d0d89a98d0d60aa0d0d89a98d0d9a7a9d0d6a7a6d0
00e8880007e88870000000000000000077777777000000000000000000000000d60806d0d61116d0d6ccc6d0d68986d0d660a0d0d9a6a9d0da767ad0da767ad0
0008800000788700000000000000000077777777000000000000000000000000d66066d0d66666d0d66666d0d66866d0d6aa06d0da666ad0d76667d0d76667d0
00000000000770000000000000000000000000000000000000000000000000000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd000ddddd00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0076d000000d67000000000000000000000000000000000000000000000000000ddddd000ddddd000ddddd000ddddd0000000000000000000000000000000000
07776d0000d67770000ddd0000ddd0009aaaaaa98eeeeee83bbbbbb3c666666cd66966d0d66166d0d63336d0d66866d000000000000000000000000000000000
777776d00d67777700d666d00d666d00a9999994e8888882b33333356cccccc1d69a96d0d61316d0d63666d0d68986d000000000000000000000000000000000
777776d00d6777770d66776dd67766d0a9999994e8888882b33333356cccccc1d69a96d0d13131d0d63636d0d89a98d000000000000000000000000000000000
777766d00d6677770d677776677776d0a9999994e8888882b33333356cccccc1d69a96d0d61316d0d63336d0d8aa98d000000000000000000000000000000000
07666d0000d666700d677777777776d0944444498222222835555553c111111cd66966d0d66166d0d66666d0d68886d000000000000000000000000000000000
00ddd000000ddd000077777007777700000000000000000000000000000000000ddddd000ddddd000ddddd000ddddd0000000000000000000000000000000000
00000000000000000007770000777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00dddd0000776d0000776d0000dddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d666670077776d0077776d0076666d0effffffe67777776a777777a566666657077777070077770000777700000777000000770000000000000000000000000
d67777777777776d7777776d7777766dfeeeeee2766666657aaaaaa96555555d7707770777007700700077007000070070000000000000000000000000000000
d67777777777776d7777776d7777776dfeeeeee2766666657aaaaaa96555555d7770070777700707770000007000000000000000000000000000000000000000
d67777777777776d7777776d7777776dfeeeeee2766666657aaaaaa96555555d7777707777777007777700077700000070000000000000000000000000000000
d67777777777766d7777766d7777776de222222e65555556a999999a5dddddd57777077777770077777700777770007770700007000000000000000000000000
0d677770076666d0076666d0077776d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d6770000dddd0000dddd0000776d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
088999a0000000000000000000000000000000000000000000000000000000007777077777770077777700777770007770700007000000000000000000000000
88999aaa000000000000000000000000000000000000000000000000000000007777707777777007777700077700000070000000000000000000000000000000
899aaaaa000000000000000000000000000000000000000000000000000000007770070777700707770000007000000000000000000000000000000000000000
899aaaaa000000000000000000000000000000000000000000000000000000007707770777007700700077007000070070000000000000000000000000000000
889aaaaa000000000000000000000000000000000000000000000000000000007077777070077770000777700000777000000770000000000000000000000000
0889aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00889a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007777770707777007077700000077000000070000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000700707700000077000000070000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007077077770070777700007770000007700000007000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007707777777077777770077777000077770000077000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007777770707777007077700000077000000070000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000700707700000077000000070000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007077077770070777700007770000007700000007000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007707777777077777770077777000077770000077000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00677770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
067d7d70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
067d7d77000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
67777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7d7777d70d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77dddd7700ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
4801000019320173201532013320123201032010320103201132015320173201e3201f32000300003000030000300003000030000300003000030000300013000130000300003000030000300003000030000300
000000001002112021140211600117001180311b0311e031230312a0312d031300313103126001250012500131001350013300132001000010000101001020010100100001000010100100001000010000100001
48020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
000200001954215542135420e54207542005420a5420c5420f5421254215542185421a5421c5421d5421f5422354225542285422b5422e5423054232542345423554236542395423a5423b5423b5423a5423b542
000400001e0501f0501f0501e0501b0501805014050120500f0500d0500905007050040500205001050000500005000050070000c0000e0000c00008000050000400002000020000200002000020000000000000
60020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
1901000033710377103871039730397300e7000e7000c7000b7003a7003c700077000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200000e3100f310027001a3201d3202a32014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200000f31010310027001e320233203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001031011310027001c3201e3203332014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001131012310027001d3201f320343503b3003a3003c3000730000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000000000000
010200001231013310027001e320203203532014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001331014310027001e320213203732014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
0102000014310153100270020320223203932014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
