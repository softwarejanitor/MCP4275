/**************************************************************************/
/*!
    @file     trianglewave.nut
    @author   Adafruit Industries
    @license  BSD (see license.txt)

    This example will generate a triangle wave with the MCP4725 DAC.

    This is an example sketch for the Adafruit MCP4725 breakout board
    ----> http://www.adafruit.com/products/935

    Adafruit invests time and resources providing this open source code,
    please support Adafruit and open-source hardware by purchasing
    products from Adafruit!

    Ported to Esquilo 20161219 Leeland Heins
*/
/**************************************************************************/

require("I2C");

// Create an I2C instance
i2c <- I2C(0);

// Load the library.
dofile("sd:/MCP4725.nut");

// For Adafruit MCP4725A1 the address is 0x62 (default) or 0x63 (ADDR pin tied to VCC)
// For MCP4725A0 the address is 0x60 or 0x61
// For MCP4725A2 the address is 0x64 or 0x65

// Instantiate the object;
local dac = MCP4725(i2c, 0x62)

print("Hello!\n");

print("Generating a triangle wave\n");

while (1) {
    local counter;
    // Run through the full 12-bit scale for a triangle wave
    for (counter = 0; counter < 4095; counter++) {
        dac.setVoltage(counter, false);
    }
    for (counter = 4095; counter > 0; counter--) {
        dac.setVoltage(counter, false);
    }
}

