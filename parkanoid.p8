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

--#include sprites/tiny_numbers.lua

-- Entities
#include entities/paddle.lua
#include entities/ball.lua
#include entities/brick.lua
#include entities/level.lua
#include entities/powerbar.lua
#include entities/powerup.lua

--brick types
#include entities/bricks/composite_brick.lua
#include entities/bricks/shield_brick.lua
--#include entities/bricks/god_brick.lua

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
#include collisions/paddle_pup_collision_handler.lua
#include collisions/ball_collision_handler.lua
#include collisions/brick_collision_handler.lua


-------------
--game loop
-------------

function _init()
  cls()
  init_gamestates()
  init_cdata()
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
00000000077007700000000000000000000000000700070007000500050005000333330003333300033333000aaaaa000ddddd00033333000ddddd000ddddd00
088008e0788778e7000000000000000077777777776077607760555055505550360606d0361666d036ccc6d0a6686690d6aa0650366866d0d6696650d6666650
0e8888807e888887000000000000000077777777060006000600050005000500308080d0361666d036c666d0a6898690d660a050368986d0d69a9650d66a6650
0e8888807e888887000000000000000077777777000000000000000000000000308880d0361666d0366cc6d0a89a9890d60aa050389a98d0d9a7a950d6a7a650
00e8880007e88870000000000000000077777777000000000000000000000000360806d0361116d036ccc6d0a6898690d660a05039a6a9d0da767a50da767a50
0008800000788700000000000000000077777777000000000000000000000000366066d0366666d0366666d0a6686690d6aa06503a666ad0d7666750d7666750
00000000000770000000000000000000000000000000000000000000000000000ddddd000ddddd000ddddd0009999900055555000ddddd000555550005555500
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
077700000aaa00000888000000999000000000000000000000000000000000000ddddd000aaaaa000ddddd000aaaaa0000000000000000000000000000000000
76777000a9aaa0008d8880000a99f8009aaaaaa98eeeeee83bbbbbb3c666666cd6696650a6616690d6333650a668669000000000000000000000000000000000
77776000aaaaa000888880009aa98f90a9999994e8888882b33333356cccccc1d69a9650a6131690d6366650a689869000000000000000000000000000000000
7776d000aaaa90008888d000999f8990a9999994e8888882b33333356cccccc1d69a9650a1313190d6363650a89a989000000000000000000000000000000000
076d00000aa90000088d00009f889aa0a9999994e8888882b33333356cccccc1d69a9650a6131690d6333650a8aa989000000000000000000000000000000000
000000000000000000000000088faa00944444498222222835555553c111111cd6696650a6616690d6666650a688869000000000000000000000000000000000
0000000000000000000000000089a000000000000000000000000000000000000555550009999900055555000999990000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666100aa0a00a0a0aa0a0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06776610a0a0aaa0a00aa0aa00000000effffffe67777776a777777a566666657077777070077770000777700000777000000770000000000000000000000000
677776d1aaaaaaa0aa0aa0aa00000000feeeeee2766666657aaaaaa96555555d7707770777007700700077007000070070000000000000000000000000000000
67777dd1aa00a0a0aa0aa0a000000000feeeeee2766666657aaaaaa96555555d7770070777700707770000007000000000000000000000000000000000000000
66776d51aaaa00a0aa0a0a0a00000000feeeeee2766666657aaaaaa96555555d7777707777777007777700077700000070000000000000000000000000000000
6666d551000000000000000000000000e222222e65555556a999999a5dddddd57777077777770077777700777770007770700007000000000000000000000000
06dd5510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
015555110666666600993bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11422442663363c3029333b000000000000000000000000000000000000000007777077777770077777700777770007770700007000000000000000000000000
144444446c3cc6cc2449333b00000000000000000000000000000000000000007777707777777007777700077700000070000000000000000000000000000000
5444444463ccccc34449333300000000000000000000000000000000000000007770070777700707770000007000000000000000000000000000000000000000
5dd1ddd163cccc3c449333b300000000000000000000000000000000000000007707770777007700700077007000070070000000000000000000000000000000
524144446c3ccccc243333b300000000000000000000000000000000000000007077777070077770000777700000777000000770000000000000000000000000
144d442463cccccc0299333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
144d444463cccccc004933b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d11dddd636ccccc0022333b11d55000555555551181100000000000000000000000000000000000000000000000000000000000000000000000000011111111
1244444d66c3cccc0293333bd5333000333d999d197f100000000000000000000000000000000000000000000000000000000000000000000000000011111111
5444444d633ccccc2449333363bbb000bbb6aaa6a777e00000000000000000007777770707777007077700000077000000070000000000000000000011111111
5244444d6cccccc34449333b63bbb000bbb6aaa61b7d100000000000000000000700707700000077000000070000000000000000000000000000000075111111
5ddddd116c6ccc3c449333bbd5333000333d999d11c11000000000000000000070770777700707777000077700000077000000070000000000000000d2211111
124d4424663ccccc443333bb11d55000555555550000000000000000000000007707777777077777770077777000077770000077000000000000000002811111
144d444263cccccc0299333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000081111
544d44446ccccccc0292333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022111
1dddddd163cccccc0493333b11d55000555555550005500000000000000100000000000000000000000000000000000000000000000000000000000000008211
1244444d6cc3cccc04493333d5999000222d000d005995dd66666666d52990000000000000000000000000000000000000000000000000000000000000000281
1244444d636ccccc2449333369aaa00088860006059ff56676dddd676d5ff9517777770707777007077700000077000000070000000000000000000000000281
0444444d66ccccc32449333b69aaa000888600065d9f95d66d6666d66d2ef9dd0700707700000077000000070000000000000000000000000000000000000281
51ddddd16ccccc3c049333b0d5999000222d000d5c4995ddd5dddd5ddd2494c57077077770070777700007770000007700000007000000000000000000000281
54414424633cc3cc293333b011d55000555555550354420111111111152445307707777777077777770077777000077770000077000000000000000000000281
5441444466c33c630499333000000000bbbbbbbb0002200051555515511220000000000000000000000000000000000000000000000000000000000000000811
044d4442066666660449333000000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000008211
05511111066666660bbb333011d5500011d55bbb0000000000000000000000000000000000000000000000000000000000000000000000008200000000008111
12444441663363c33333b33bd5222000d5100bbb0000000000000000000000000000000000000000000000000000000000000000000000008222222222281111
1444444d6c3cc6cc3433333b6288800061000bbb00000000000000000000000000000000000000000000000000000000000000000000000082dddddddd281111
14424441636cccc3444933336288800061000bbb00000000000000000000000000000000000000000000000000000000000000000000000084dddddddde81111
5dddd1dd66cccc3c449923b3d5222000d5100bbb0000000000000000000000000000000000000000000000000000000000000000000000008efffffffe821111
544d4442633cc3cc449333b311d5500011d55bbb0000000000000000000000000000000000000000000000000000000000000000000000008e77788888211111
144d444466c33c632499333b00000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000008e77e81111111111
0441424406666666242933b000000000bbbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000008e7e811111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008e78111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008ef8111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008e81111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008841111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008821111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008211111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002111111111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111711111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111157721111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166082111111
11111111111111118e7777617111111777777511111111111111111111e882111111111177777761111111111d777761111111111d7777777777750002811111
111111111111111184ddde818211111edddde21111111111111111111e88222111111111eddddee1111115d55ddddd522221111114eddddeddddd10002221111
111111111111111e8200028708211118000082111111111111111111e8280281111111118200028111111d777500000888811111128000080000000000081111
11111111111111e8820002800082111800008211111111111111111e820800081111111182000281111775000000000000088211128000080000820000008211
1111111111111e8282000220000821180000821111111111111111e820080002211111118200028111ddd1000000000000022211128000080000820000002211
111111111111e82082000000000082180000821112211111111111e8000800008211111182000281166000000000000000000281128000080000888000000281
11111111111e82008200028000000280000082112802111111111e82000800000281111182000281750000000288888000000008128000080000821800000008
1111111111e82000820002820000022000008212800821111111e820000800000222111182000285650000022222222220000008188000080000821e00000008
111111111e82000082000288000000000000821800008211111e82000008000000081111820002e7000000088200000882000000888000080000811700000008
11111111e82000008200028700000000000088200000821111e820000008000000008211820002e70000028000022222282000008880000800008e6000000281
1111111e82000000820002e60000000000008820000021111e820000000800000000821182000286000002200152d22d248000002880000800008ed000000221
111111e82000000082000660000002800000820000021111e82000000008000000000281820002800000820026727dd726780000028000080000820000008211
11111e82000000008200000000008218000000000821111e82000000000800000000002882000280000082022222222222280000028000080000000000081111
1111e82000000000820000000000811800000000022111e8820000000028000000000018820002800000821d2222d22d22480000028000280000000000281111
111e82222228222282222222222811182222222282111e8222222222222822222222222282222882222282d726727dd726782222288222282222222228811111
11e82dddd488dddd82dddddddd281118dddddddd8211e82dddddd48dddd8ddddd48dddddddddd888ddddd88d2222d22d288ddddd888dddd8dddddddd82111111
1e82ddddd488dddd84ddddddddd81118dddddddd821e82ddddddd48dddd8ddddd88dddddddddd888ddddde8222222222288ddddd888dddd8dddddddd81111111
e82fffff8218ffff8effffffffff8218fffffffffe882fffffff821fffe8fffffe88fffffffffe88ffffffe88f727d288effffff888fffe8fffffff811111111
82f777f8111877778e7777777777f48877778f777fee8f7777f8111777f877777e818f7777777e818f77777ffe88e88fff7777f8128777f877777e8111111111
827777f8111877778e77777777777e8877778e7777f88e7777f8111777f877777e818e7777777e818e7777777e8888e7777777e8128777f877777e2111111111
02877777821877778e777e88777777f877f8128777778e777777821777f877777e81128777777e81128777777777777777777e81128777f87777821111111111
11277777f48877778e77e211ef7777f87e82118e777788e77777f44777f877777e81112e77777e81112eef777777777777fee21112877e8877fe211111111111
111877777e8877778e7782118e7777f8e8211118e77788877777788777f877777e81111877777e8111188e777777777777f8821112877e8877f8111111111111
1111877777f877778ef8111118e77e88821111118ef811187777777777f877777e8111118e777e81111112888e7777f88881111112e781187e81111111111111
1111287777f8eeee88421111118ee2282111111118e211118f777eeeeee8eeeee881111124e7e2111111112224eeee4222111111128e2118e211111111111111
1111128777f888888881111111188218111111111181111128777888888888888881111112878211111111111288888111111111128811188211111111111111
111111287e8111111111111111111111111111111111111112878211111111111111111111181111111111111111111111111111128111181111111111111111
11111112e21111111111111111111111111111111111111111282111111111111111111111121111111111111111111111111111112111121111111111111111
11111111111111111111111111111111111111111111111111121111111111111111111111111111111111111111111111111111111111111111111111111111
__sfx__
4801000019326173261532613326123261032610326103261132615326173261e3261f32600306003060030600306003060030600306003060030600306013060130600306003060030600306003060030600306
0001000015020180201a02016000170001c0301f0302203023030280302c030300303303026000250002500031000350003300032000000000000001000020000100000000000000100000000000000000000000
48020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
000200001954215542135420e54207542005420a5420c5420f5421254215542185421a5421c5421d5421f5422354225542285422b5422e5423054232542345423554236542395423a5423b5423b5423a5423b542
000400001e0501f0501f0501e0501b0501805014050120500f0500d0500905007050040500205001050000500005000050070000c0000e0000c00008000050000400002000020000200002000020000000000000
60020000123101331002700293202e3203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
3101000033760377603876039760397600e7000e7000c7000b7003a7003c700077000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
480200000f62617626016060160601606336363b6363a6363b6363c636256261f6261762616626166260160600606006060060600606006060060600606016060160600606006060060600606006060060600606
000300001e6301f6301f6301e6301b630186301463011630106300e6300c6300b6300a6300963007630046300463003630076000c6000e6000c60008600056000460002600026000260002600026000060000600
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200000e3100f310027001a3201d3202a32014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200000f31010310027001e320233203032014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001031011310027001c3201e3203332014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001131012310027001d3201f320343503b3003a3003c3000730000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000000000000
010200001231013310027001e320203203532014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200001331014310027001e320213203732014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
0102000014310153100270020320223203932014300383003b3003a3003c300073000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000e34011340005501d350223602a3601c5501a55016550135500e5500b5500755003550035500030000300003000030000300003000030000300003000030000300003000030000300003000030000300
