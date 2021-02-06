

-- fill out space to 0x4000!

for i=#System.memory,0x4000 do
 System.memory[i]=0x0
end