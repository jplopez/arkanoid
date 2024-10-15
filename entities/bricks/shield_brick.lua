function shieldbrick(sh)
  return brick:extend({
    shield=sh or 2,
    hits=0,
    s=37,
    hf=3, -- frames for hit anim
    hc=0,  -- hit counter
  
    update=function(_ENV)
      s=37
      if(hc>0)then s,hc=4,1 end
    end,
  
    on_collision=function(_ENV,b)
      -- log("shield brick on collision")
      local n_hits=b.hits
      hits+=n_hits
      score_hit(n_hits,b.power)
      if(hits<shield)then
        sfx(5)hc=hf
        return set(visible)
      end
      return set(hit)
    end
  })
end