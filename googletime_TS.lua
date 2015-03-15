function getTime()
    if lastUpdate >= 900 then

        conn=net.createConnection(net.TCP, 0)

        conn:on("connection",function(conn, payload)
            conn:send("HEAD / HTTP/1.1\r\n"..
                      "Host: google.com\r\n"..
                      "Accept: */*\r\n"..
                      "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
                      "\r\n\r\n")
			end)

        conn:on("receive", function(conn, payload)
        --print(payload)
            time = string.sub(payload,  string.find(payload,"Date: ")+23, string.find(payload,"Date: ")+31)
            hour = string.sub(time, 0, 2) + 20
  						if hour > 23 then hour = hour - 24 end
            minute = string.sub(time, 4,5) + 0
            second = string.sub(time, 7,9) + 0
							mins = 60*hour + minute
            print("Time: "..hour.."-"..minute.."-"..second)
            conn:close()
            lastUpdate = 0
            end)
        conn:connect(80,'google.com')
        heap = node.heap()
        print(heap)--for test, to be removed

    end--if
end--getTime

function increaseTime()
    second = second + 1
    lastUpdate = lastUpdate + 1
    if second == 60 then
        second = 0
        minute = minute + 1
        mins = 60*hour + minute
        if mins == 1440 then mins = 0 end
    end
    if minute == 60 then
        minute = 0
        hour = hour + 1
    end
    if hour == 24 then
        hour = 0
    end
end

getTime()
--print("now got time: "..hour.."-"..minute.."-"..second)

tmr.alarm(1, 1000, 1, function()
    increaseTime()

    print(hour.."-"..minute.."-"..second..", "..lastUpdate.." > "..mins)

end)

tmr.alarm(0, 10000, 1, function()
    l=adc.read(0)
    print('l = '..l)
    ip = wifi.sta.getip()
    if ip=="0.0.0.0" or ip==nil then
        print("connecting to AP")
    else
        getTime()
    end

	if mins >= 360 and mins < 1320 then --day
		day = 1
        if (l>50) then
            gpio.write(redPin,gpio.HIGH)
			      led = 1
        else
            gpio.write(redPin,gpio.LOW)
			      led = 0
        end
  else
		gpio.write(redPin,gpio.LOW)
		day = 0
  end
end)

tmr.alarm(3,300000,1, function()
	print("Sending data to thingspeak.com")
	conn=net.createConnection(net.TCP, 0)

	conn:on("receive", function(conn, payload)
		print(payload)
		conn:close()
		end)
		--: api.thingspeak.com 184.106.153.149

	conn:on("connection",function(conn, payload)
		conn:send("GET /update?key=xxxxxxxxxxxxxxxx&field1="..l.."&field2="..day.."&field3="..led.."HTTP/1.1\r\n"..
		"Host: api.thingspeak.com\r\n"..
		"Accept: */*\r\n"..
		"User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n"..
		"\r\n")
		end)
 conn:connect(80,'184.106.153.149')
 end)
