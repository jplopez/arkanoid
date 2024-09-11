start,game,levelup,gameover=0,1,2,3
function init_gst()
  gstt(start, function() start_scene:load(_plevel)end,function() start_scene:unload()end)
  gstt(game, function()end, function()end)
  gstt(levelup, function()end, function()end)
  gstt(gameover, function()end, function()end)
end