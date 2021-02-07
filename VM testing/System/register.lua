




local r={
 -- holds state
 inst=0x0,
 -- accumulator stores math
 accu=0x0,
 
 -- stack ponter
 sta_ptr=0x0,
 -- stack size
 sta_siz=0x0,
 
 -- holds call state
 sta_state=false,
 
 
 -- general purpose registers
 0x0,0x0,0x0,0x0,
}

function initRegister()
 
 function getRegister(index)
  System.stress=System.stress+1
  
  if index=="inst" then return System.r.inst elseif
  index=="accu"    then return System.r.accu elseif 
  index=="sta_ptr" then return System.r.sta_ptr elseif
  index=="stack" then
   setRegister("sta_ptr",getRegister("sta_ptr")-1)
   local v = peek(System.r.sta_ptr+1)
   setRegister("stack",0)
   System.r.sta_ptr=System.r.sta_ptr-1
   return v
  end
  
  if index<1 or index>#System.r then error("bad getRegister call. ("..index..")") end
  
  
  
  return System.r[index]
 end
 
 function setRegister(index,value)
  System.stress=System.stress+1
  
  if value<0 or value>0x4000 then
   error("bad setRegister call. (number "..value.." is invaild!)")
  end
  
  
  if index=="inst" then System.r.inst=value return
  elseif index=="accu" then System.r.accu=value return 
  elseif index=="sta_ptr" then System.r.sta_ptr=value return
  elseif index=="stack" then
   System.memory[System.r.sta_ptr+1]=value
   
   setRegister("sta_ptr",getRegister("sta_ptr")+1 )
   return
  end
  
  
  if index<1 or index>#System.r then error("bad setRegister call. ("..index..")") end
  
  System.r[index]=value
 end
 
end
 
return r