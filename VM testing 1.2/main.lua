


function love.load()
 _Lo={g=love.graphics,e=love.event}
 _Lo.g.setDefaultFilter("nearest","nearest",1)
 _Lo.g.setLineStyle("rough")
 
 
 require("font/init_text")
 System = require("initsystem")
 
 initAPI()
 
 
end


function love.update()
 
 debuger.t[1]=debuger.t[1]+debuger.t[2]
 if debuger.t[1]%debuger.t[3]==1 or debuger.t[3]==1 then
  newSystemFrame()
  -- setps
  --[[
  while true do
   if System.stress>100 then break end
   step() 
  end
  ]]
  step() step() step()
 end
end


function love.draw()
 --[[
 System.screen:renderTo( function() end )
 
 _Lo.g.scale(screenInfo.scale)
 
 _Lo.g.draw(System.screen)
 
 _Lo.g.scale(1/screenInfo.scale)
 
 --]]
 
 
 debug()
 
 
 --[[
  _Lo.g.captureScreenshot(tostring(debuger.t[1]-1)..".png" )
 -- ]]
 
end



debuger={drawstate=true,t={1,1,20},memview=1}
function debug()
 
 
 _Lo.g.scale(screenInfo.scale)
 _Lo.g.print("cpu "..System.stress)
 
 _Lo.g.print("step",0,5)
 for i=1,#steps do
  _Lo.g.print(steps[i],i*8+10,5)
 end
 _Lo.g.print("inst".."# "..System.r.inst,0,10)
 _Lo.g.print("accu".."# "..System.r.accu,0,15)
 for i=1,#System.r do
  _Lo.g.print(i.."# "..System.r[i],0,i*5+15)
 end
 _Lo.g.print("memory",38,0)
 
 if not debuger.drawstate then
  
  debuger.memview = math.ceil(System.r.inst/3)*3-7
  if debuger.memview<0 then debuger.memview=0 end
  
  local l=0
  for i=1,11 do
   i=i+debuger.memview
   l=l+1
   _Lo.g.print(i.."# "..System.memory[i],52,l*5+10)
  end
  _Lo.g.print("(-",84,System.r.inst*5+10 - debuger.memview*5)
  
 else
  
  debuger.memview = math.ceil(System.r.inst/3)-4
  if debuger.memview<0 then debuger.memview=0 end
  
  local l=0
  local str={}
  
  for i=1,64 do
   
   local k=i+ debuger.memview
   
   str[#str+1]={"",""}
   l=l+1
   
   str[i][1]=math.floor(k).."#"..actionNames[System.memory[k*3-2]+1]
   _Lo.g.print(str[i][1],38,l*5+10)
   str[i][2]=System.memory[k*3-1].." "..System.memory[k*3]
   _Lo.g.print(str[i][2],68,l*5+10)
  end
  
  local slec=math.ceil(System.r.inst/3)
  if not str[slec] or slec==0 then return end
  local one=#str[slec][1]
  if one<7 then one=7 end
  _Lo.g.print("(-",38+ (one*4+#str[slec][2]*4) +5,slec*5+10 - debuger.memview*5)
  
 end
end



