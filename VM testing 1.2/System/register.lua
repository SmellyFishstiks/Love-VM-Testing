




local r={
 -- holds state
 inst=0x0,
 -- accumulator stores math
 accu=0x0,
 
 -- general purpose registers
 0x0,0x0,0x0,0x0,
}

function initRegister()
 
 function getRegister(index)
  System.stress=System.stress+1
  
  if index=="inst" then return System.r.inst elseif index=="accu" then return System.r.accu end
  
  if index<1 or index>#System.r then error("bad getRegister call. ("..index..")") end
  
  
  
  return System.r[index]
 end
 
 function setRegister(index,value)
  System.stress=System.stress+1
  
  if value<0 or (value>0xff and index~="inst") then error("bad setRegister call. (number "..value.." is invaild!)") end
  
  
  if index=="inst" then System.r.inst=value return
  elseif index=="accu" then System.r.accu=value return end
  
  
  if index<1 or index>#System.r then error("bad setRegister call. ("..index..")") end
  
  System.r[index]=value
 end
 
end
 
return r