


function poke(value,index)
 System.stress=System.stress+1
 System.memory[index]=value
end

function peek(index)
 System.stress=System.stress+1
 return System.memory[index]
end



local memory={}
for i=0x1,0x4000 do
 memory[i]=0x0
end

return memory