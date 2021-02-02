
local s={}

-- basicly the CPU%
s.stress=0


s.screen=_Lo.g.newCanvas(screenInfo.x,screenInfo.y)





s.r = require("System/register")



function initAPI()
 
 require("System/math")
 
 require("System/frame")
 
 require("System/instruction")
 
 initRegister()
 
 
 
 System.memory = require("System/memory")
 --[[
 for i=1,#System.memory do
  print(System.memory[i])
 end
 ]]
 
 require("System/loadProgram")
 
 
end


return s