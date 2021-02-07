-- program space, expand this later if needed. 
-- (area that stores machine code.)

local m=System.memory
local s=#m

local programData= "0301010302020303030304041000db000000000000000000".."1"


-- set inst to the start of Program space.
System.programPointer=s-1
System.r.inst=System.programPointer


for i=0x1,0x200 do
 local char = tonumber( "0x"..string.sub(programData,i*2-1,i*2-1)..string.sub(programData,i*2,i*2) )
 if not char then char=0 end
 m[s+i-1] = char
end



--[[

010000


--[[ programs

 -- ∞ counter (well till crash..)
 "030101090102020300"
 
 -- basic adding 2+3=5
 "030201030302090102010000"
 
 -- for loop!
 "030101030f040901020703000d0304020300010000"
 (    )
 set_r
 030101
 set_r
 030f04
 add
 090102
 mov_a
 070300
 mor
 0d0304
 hop
 020300
 qit
 010000
 (    )


]]
