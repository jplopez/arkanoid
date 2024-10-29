function shieldbrick(sh)
  return brick:extend({
    shield=sh or 2,
    hits=0,
    s=37,
    hf=3, -- frames for hit anim
    hc=0,  -- hit counter
  
    update=function(_ENV)
      s=37
      if(hc>0)then s,hc=4,hc-1 end
    end,
  
    on_collision=function(_ENV,b)
      hits+=b.hits
      score_hit(_ENV,b)
      if(hits<shield)then
        sfx(5)hc=hf
        return set(_ENV,visible)
      end
      hit_anim:rewind()
      return set(_ENV,hit)
    end
  })
end