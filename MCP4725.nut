/**************************************************************************/
/*!
    @file     MCP4725.nut
    @author   K. Townsend (Adafruit Industries)
    @license  BSD (see license.txt)

    This is a library for the Adafruit MCP4725 breakout board
    ----> http://www.adafruit.com/products/935

    Adafruit invests time and resources providing this open source code,
    please support Adafruit and open-source hardware by purchasing
    products from Adafruit!

    @section  HISTORY

    v1.0  - First release

    Ported to Esquilo 20161219 Leeland Heins
*/
/**************************************************************************/

const MCP4725_CMD_WRITEDAC       = 0x40;  // Writes data to the DAC
const MCP4725_CMD_WRITEDACEEPROM = 0x60;  // Writes data to the DAC and the EEPROM (persisting the assigned value after reset)

class MCP4725
{
    i2c = null;
    addr = 0;

    constructor (_i2c, _addr)
    {
        i2c = _i2c;
        addr = _addr;
    }
};

/**************************************************************************/
/*!
    @brief  Sets the output voltage to a fraction of source vref.  (Value
            can be 0..4095)

    @param[in]  output
                The 12-bit value representing the relationship between
                the DAC's input voltage and its output voltage.
    @param[in]  writeEEPROM
                If this value is true, 'output' will also be written
                to the MCP4725's internal non-volatile memory, meaning
                that the DAC will retain the current voltage output
                after power-down or reset.
*/
/**************************************************************************/
function MCP4725::setVoltage(output, writeEEPROM)
{
    local writeBlob = blob(3);
    i2c.address(addr);
    if (writeEEPROM) {
       writeBlob[0] = MCP4725_CMD_WRITEDACEEPROM;
    } else {
       writeBlob[0] = MCP4725_CMD_WRITEDAC;
    }
    writeBlob[1] = (output / 16);         // Upper data bits  (D11.D10.D9.D8.D7.D6.D5.D4)
    writeBlob[2] = ((output % 16) << 4);  // Lower data bits  (D3.D2.D1.D0.x.x.x.x)
    i2c.write(writeBlob);
}

