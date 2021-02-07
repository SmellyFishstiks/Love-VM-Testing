-- RAM space!!

-- here's the memory that's going to be used for the variables
-- and such. (might have to make this bigger later..)

local m=System.memory
local s=#m

for i=0x1,0x200 do
 m[s+i]=0x0
end