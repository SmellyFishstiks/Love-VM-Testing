



function convertToHex(value)
 local c=""
 
 if value<9 then 
  c = tostring(value)
 else
  c = string.char(value+87)
 end
 
 
 return c
 
end


function convertOutHex(value)
 return tonumber("0x"..value)
end