# Plant-Light
Control of light for plants, behind window, depending on hour and sunlight with ESP8266

What it does:
Keeps the light level for my plants (behind the window) during the winter time (and not only).
The "standard day" is from 6:00 to 22:00.

How it works:
Measures the sunlight, during the "standard day" and if it is not enough it lights up the local LED.

Each 15 minutes it synchronises the time with a google server.

Some parts of this project are inspired by, or shameless copied, from:
  - https://github.com/GeoNomad   the GoogleTime.lua (Copyright (c) 2015 Peter Jennings benlo.com)
  - https://github.com/squix78/ESP8266-lua-nightlight (Copyright (c) 2014 squix78)
    
The board used for this project is ESP8266-12, from AliExpress (http://www.aliexpress.com/item/ESP8266-serial-WIFI-industrial-grade-stable-version-of-the-test-plate-full-Total-IO-extraction/32242633472.html), as development board. It is already equiped with an LDR (photoresistor) connected on ADC pin, with LEDs connected on all GPIO pins. It also comes with a batteries holder attached (for 3 AA). I removed it and I soldered a connector that match my stuff.

On the board is mounted an RGB LED. It looks like the three GPIOs to RGB LED allow some current to pass and lighting up all three colors. Because I measure the quantity of light I had to get rid off all sources of light near the LDR. For this reason in the config file are some lines of code to deal with this and shut off the RGB LED(s).

I hope I’ll soon be able to put some more details about this project (pictures and LED lighting device).

Let me know if there are questions.

Meanwhile you can take a look at my other “application in action” for the very same board at Thingspeak (https://thingspeak.com/channels/15699).

I added a new version of file googletime.lua named googletime_TS.lua that send three parameters to ThinkSpeak (15Mar2015)
