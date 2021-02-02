
-- getInstruction
function fetch()
 local nextAddress = getRegister("inst")+1
 setRegister("inst",nextAddress)
 
 local instruction = System.memory[nextAddress]
 
 
 
 return instruction
 
end

function fetch2()
 local nextAddress = getRegister("inst")
 local instruction = System.memory[nextAddress]
 local instruction2 = System.memory[nextAddress+1]
 setRegister("inst",nextAddress + 2)
 
 
 return convertOutHex(convertToHex(instruction)..convertToHex(instruction2))
 
end


actions={
 -- dum
 (function() end),
 
 -- qit
 (function() debuger.t[3]=0 return true --[[_Lo.e.quit()]] end),
 
 -- hop
 (function(index) setRegister("inst",index) end),
 
 
 -- set_r
 (function(value,register)
   setRegister(register,value)
 end),
 
 -- set_a
 (function(value)
  setRegister("accu",value)
 end),
 
 -- set_m
 (function(value,spotinmemory)
  poke(spotinmemory,value)
 end),
 
 -- mov_r
 (function(index,register)
  local n = getRegister(index) --System.r[index]
  setRegister(register,n)
 end),
 
 -- mov_a
 (function(register)
  local n = getRegister("accu") --System.r[index]
  setRegister(register,n)
 end),
 
 -- mov_m
 (function(spotinmemory,register)
  peek(spotinmemory)
  setRegister(register,n)
 end),
 
 -- add
 (function(index,index2)
  local n = System.r[index] + System.r[index2]
  setRegister("accu",getRegister("accu")+n)
 end),
 
 -- sub
 (function(index,index2)
  local n = System.r[index] - System.r[index2]
  setRegister("accu",getRegister("accu")+n)
 end),
 
 -- mlt
 (function(index,index2)
  local n = System.r[index] * System.r[index2]
  setRegister("accu",getRegister("accu")+n)
 end),
 
 -- div
 (function(index,index2)
  local n = math.floor (System.r[index] / System.r[index2] +.5)
  setRegister("accu",getRegister("accu")+n)
 end),
 
 -- mor
 (function(index,index2)
  local n1 = System.r[index] 
  local n2 = System.r[index2]
  
  if n1>n2 then 
   setRegister("inst",getRegister("inst")+3)
  end
  
 end)
 
}

actionNames={
 "dum",
 "qit",
 
 "hop",
 
 "set_r",
 "set_a",
 "set_m",
 
 "mov_r",
 "mov_a",
 "mov_m",
 
 
 "add",
 "sub",
 
 "mlt",
 "div",
 
 "mor"
 
 
 
 
}

function execute(instruction,params)
 
 local action = actions[instruction+1]
 
 
 local f = action(params[1],params[2])
 
 return f
end


steps={}
function step()
 local f=false
 
 if #steps==3 then
  f = execute(steps[1],{steps[2],steps[3]})
  steps={}
 end
 
 steps[#steps+1] = fetch()
 
 if f then print("||SYSTEM|| > quit activated") return true end
end

