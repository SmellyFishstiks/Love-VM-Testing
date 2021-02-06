


function poke(value,index)
 System.stress=System.stress+1
 System.memory[index]=value
end

function peek(index)
 System.stress=System.stress+1
 return System.memory[index]
end

System.memory={}

--- organize memory a little bit
-- task space! (AKA Stack)
require("System/memory/task")

-- RAM space! used for vars!
require("System/memory/ram")

-- finnal touch after the rest of memory is filled out
require("System/memory/size")