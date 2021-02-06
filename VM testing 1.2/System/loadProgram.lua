


local programData=""--"030101030f040901020703000d0304020300010000"
for i=1,#programData/2 do
 System.memory[i]= tonumber( "0x"..string.sub(programData,i*2-1,i*2-1)..string.sub(programData,i*2,i*2) )
end




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