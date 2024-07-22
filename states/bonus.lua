-- Bonus

lives_bonus = {
  [1] = {score=2000 , claimed=false},
  [2] = {score=5000 , claimed=false},
  [3] = {score=10000 , claimed=false},
  [4] = {score=20000, claimed=false}
 }
 
 function init_bonus()
  for b in all(lives_bonus) do
   b["claimed"]=false
  end
 end
 
 function update_bonus()
 
  local p_score = _players["p1"]["score"]
  for n=1,#lives_bonus do 
   if not lives_bonus[n]["claimed"] then
    if p_score >= lives_bonus[n]["score"] then
     _players["p1"]["lives"]+=1
     lives_bonus[n]["claimed"]=true
     sfx(3)
     return false
    end
   end
  end
 end
 