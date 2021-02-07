-- task space!!

-- here's the memory that's going to be used for the stack (tasks) and
-- other important system stuff. (not hardware state etc, stuff
-- like tasks and other importance.)

local m=System.memory
local s=#m

for i=0x1,0x80 do
 m[s+i]=0x0
end