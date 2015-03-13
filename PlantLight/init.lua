--PlantLight/init.lua

wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')

-- wifi config start
wifi.sta.config("SSID","PASSWORD")--modify accordingly
-- wifi config end
dofile("config.lua")
print("Config done.")
--print(wifi.sta.getip())
--next tmr chunk flashes the blue LED once at every 10 seconds showing that
--the program is running. If it bothers you delete it.
tmr.alarm(2,10000,1, function() 
          gpio.write(bluePin,gpio.HIGH)
          tmr.delay(100000)
          gpio.write(bluePin,gpio.LOW)
end)
     
tmr.alarm(0, 5000, 1, function()
   ip = wifi.sta.getip()
   if ip=="0.0.0.0" or ip==nil then
      print("connecting to AP...")
   else
      tmr.stop(0)
      print("IP = "..wifi.sta.getip())
      dofile("googletime.lua")
   end
end)
