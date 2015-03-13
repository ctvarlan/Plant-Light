
hour        = 0
minute      = 0
second      = 0
lastUpdate  = 900
--minimum quantity of light
--lower values mean more light
--higher values mean more darkness
--values are between 0 and 1023 highly nonlinear
minim_light = 50 

nightPin    = 4 --gpio 2
dayPin      = 3 --gpio 0
redPin      = 8 --gpio 15
greenPin    = 6 --gpio 12
bluePin     = 7 --gpio 13

gpio.mode(greenPin,gpio.OUTPUT)
gpio.mode(bluePin,gpio.OUTPUT)
gpio.mode(redPin,gpio.OUTPUT)

gpio.write(greenPin,gpio.LOW)   --off green LED
gpio.write(bluePin,gpio.LOW)    --off blue LED
gpio.write(redPin,gpio.LOW)     --off red LED
