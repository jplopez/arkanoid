function nil_line()
  local line={}
  for i=1,_max_cols do
    add(line,nil)
  end
  return line
end
_lvl_map={col_sep=",",row_sep="|",n=nil,
  default={type=function()return brick:new()end,
    count=true},
  b={type=function()return brick:new() end,
    count=true},
  bo={type=function()return brick:new({s=20})end,
    count=true},
  br={type=function()return brick:new({s=21})end,
    count=true},
  bg={type=function()return brick:new({s=22})end,
    count=true},
  bb={type=function()return brick:new({s=23})end,
    count=true},
  bp={type=function()return brick:new({s=36})end,
    count=true},
  s={type=function()return shieldbrick(2)end,
    count=true},
  ti={type=function()return shieldbrick(4)end,
    count=true},
  g={type=function()return brick:new({unbreakable=true,s=38})end,
    count=false}
}
_lvl_def2={
  -- [1] = "|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,s,s,s,s,s,n,n,n,n,n|"..
  --     "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
  --     "n,n,n,n,n,s,s,s,s,s,n,n,n,n,n|",
[1] = "|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|",
[2] = "|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,s,s,s,s,s,s,s,s,s,s,s,n,n|"..
      "n,n,br,br,br,br,br,br,br,br,br,br,br,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"..
      "n,n,n,n,bo,bo,bo,bo,bo,bo,bo,n,n,n,n|"..
      "n,n,n,n,n,br,br,br,br,br,n,n,n,n,n|",
[3] = "||"..
      "n,n,n,s,s,s,s,s,s,s,s,s,n,n,n|"..
      "n,n,n,bg,bg,bg,bg,bg,bg,bg,bg,bg,n,n,n|"..
      "n,n,n,bg,br,br,b,b,b,br,br,bg,n,n,n|"..
      "n,n,n,bg,br,br,b,b,b,br,br,bg,n,n,n|"..
      "n,n,n,bg,b,b,b,b,b,b,b,bg,n,n,n|"..
      "n,n,n,bg,b,br,b,b,b,br,b,bg,n,n,n|"..
      "n,n,n,bg,b,b,br,br,br,b,b,bg,n,n,n|"..
      "n,n,n,n,b,b,b,b,b,b,b,n,n,n,n|",
[4] = "|"..
      "n,n,n,s,s,s,s,s,s,s,s,s,n,n,n|"..
      "n,n,n,bb,bb,bb,bb,bb,bb,bb,bb,bb,n,n,n|"..
      "n,n,n,bb,bb,bb,bg,bg,bg,bb,bb,bb,n,n,n|"..
      "n,n,n,bb,bb,bg,bg,bg,bg,bg,bb,bb,n,n,n|"..
      "n,n,n,bb,bb,bg,bg,bg,bg,bg,bb,bb,n,n,n|"..
      "n,n,n,bb,bb,bb,bb,bo,bb,bb,bb,bb,n,n,n|"..
      "n,n,n,bb,bb,bb,bb,bo,bb,bb,bb,bb,n,n,n|"..
      "n,n,n,g,g,g,g,g,g,g,g,g,n,n,n|"..
      "n,n,n,n,n,n,n,n,n,n,n,n,n,n,n|",
[5] = "|"..
      "n,bp,bp,bp,bp,bp,n,n,n,n,n,n,n,n,n|"..
      "n,bo,bo,bo,bo,bo,bo,n,n,n,n,n,n,n,n|"..
      "n,br,br,br,br,br,br,br,n,n,n,n,n,n,n|"..
      "n,bp,bp,bp,bp,bp,bp,bp,bp,n,n,n,n,n,n|"..
      "n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n,n,n|"..
      "n,bp,bp,bp,bp,bp,bp,bp,bp,bp,bp,n,n,n,n|"..
      "n,br,br,br,br,br,br,br,br,br,br,br,n,n,n|"..
      "n,g,g,g,g,g,g,g,g,g,g,g,s,s,n|"..
      "|",
[6] = "n,bg,g,g,g,g,g,g,g,g,g,g,g,bg,n|"..
      "n,bg,bg,bg,g,bb,bb,bb,bb,bb,g,bg,bg,bg,n|"..
      "n,bg,bg,bg,g,bb,bb,bb,bb,bb,g,bg,bg,bg,n|"..
      "|||"..
      "n,n,n,g,g,g,g,g,g,g,g,g,n,n,n|"..
      "n,n,n,br,br,br,br,br,br,br,br,br,n,n,n|"..
      "n,n,n,bp,bp,bp,bp,bp,bp,bp,bp,bp,n,n,n|"..
      "n,n,n,bo,bo,bo,bo,bo,bo,bo,bo,bo,n,n,n|"
}