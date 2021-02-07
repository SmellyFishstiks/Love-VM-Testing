
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
 (function()
  
  -- if in the middle of a cal
  if not System.r.sta_state then
   debuger.t[3]=0 return true 
   
  else
   System.r.sta_state=false
   
   actions[16](1)
   local amount = getRegister(1)-6
   print(amount)
   
   actions[16](1)
   System.r.accu = getRegister(1)
   
   actions[16](1)
   System.r.inst = getRegister(1)*3
   
   -- pop it out
   for i=1,#System.r do
    actions[16](#System.r-i+1)
   end
  end
  
 end),
 
 -- hop
 (function(index)
  setRegister("inst",System.programPointer+index)
 end),
 
 
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
  
 end),
 
 
 -- psh
 (function(index)
  if index<1 or index>#System.r then error("Bad psh call, Register #"..index.." is not vaild.") end
  local n = getRegister(index)
  setRegister("stack",n)
  
  
 end),
 
 
 -- pop
 (function(index)
  if index<1 or index>#System.r then error("Bad pop call, Register #"..index.." is not vaild.") end 
  local n = getRegister("stack")
  setRegister(index,n)
  
 end),
 
 
 
 -- cal
 (function(spotinmemory,spotinmemory2)
  local str1=string.format("%x",tostring(spotinmemory))
  if #str1==1 then str1="0"..str1 end
  local str2=string.format("%x",tostring(spotinmemory2))
  if #str2==1 then str2="0"..str2 end
  local n = tonumber( "0x"..str1..str2 ) *3-3
  
  
  
  
  setRegister("inst",n)
  System.r.sta_state=true
  -- psh the registers out
  local s=2
  for i=1,#System.r do
   actions[15](i)
   s=s+1
  end
  
  -- psh the inst and accu into the stack along side size of this chunk.
  actions[4](math.floor(System.r.inst/3),1)
  actions[15](1)
  actions[4](System.r.accu,1)
  actions[15](1)
  actions[4](s,1)
  actions[15](1)
  
  
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
 
 "mor",
 
 
 "psh",
 "pop",
 
 "cal"
 
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

