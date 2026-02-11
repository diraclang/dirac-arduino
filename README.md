# DIRAC Arduino Integration

Control and program Arduino boards using DIRAC language.

## Supported Boards
- Arduino Uno
- Arduino Duemilanove
- Other AVR-based Arduino boards

## Prerequisites

### Install arduino-cli
```bash
# macOS
brew install arduino-cli

# Or download directly
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

### Initial Setup
```bash
# Initialize configuration
arduino-cli config init

# Update core index
arduino-cli core update-index

# Install Arduino AVR core (for Uno and Duemilanove)
arduino-cli core install arduino:avr

# List connected boards
arduino-cli board list
```

## Quick Start

1. Create a DIRAC script to control your Arduino:
```xml
<dirac>
  <import lib="arduino.di" />
  
  <!-- Compile and upload blink sketch -->
  <arduino-compile sketch="examples/Blink" board="uno" />
  <arduino-upload board="uno" port="/dev/cu.usbserial-*" />
</dirac>
```

2. Run it:
```bash
dirac my-arduino-script.di
```

## Examples

The `examples/` directory contains sample DIRAC scripts:

- `blink.di` - Classic LED blink example
- `serial-hello.di` - Serial communication demo
- `sensor-read.di` - Read analog sensor values

Each example includes:
- Board detection
- Compilation
- Upload
- Serial monitoring (where applicable)

### Running Examples

Before running examples, update the port path in each file to match your board:

```bash
# Find your board's port
arduino-cli board list

# Edit the example file and update the portPath variable
# For Uno: usually /dev/cu.usbmodem* or /dev/ttyACM0
# For Duemilanove: usually /dev/cu.usbserial-* or /dev/ttyUSB0
```

Then run with DIRAC:

```bash
# From the dirac-arduino/examples directory
cd examples
dirac blink.di
```

## Library Reference

The `lib/arduino.di` library provides these subroutines:

- `<arduino-list-boards />` - List connected Arduino boards
- `<arduino-compile sketch="path" board="uno|duemilanove|nano|mega" />` - Compile sketch
- `<arduino-upload sketch="path" board="type" port="/dev/cu.*" />` - Upload sketch
- `<arduino-deploy sketch="path" board="type" port="/dev/cu.*" />` - Compile and upload
- `<arduino-monitor port="/dev/cu.*" baud="9600" />` - Open serial monitor
- `<arduino-create-sketch name="MySketch" path="./" />` - Create new sketch
- `<arduino-lib-search query="sensor" />` - Search for libraries
- `<arduino-lib-install library="Servo" />` - Install library

## Troubleshooting

### Board Not Detected

```bash
# Check USB connection
arduino-cli board list

# Try resetting the board
# Press the reset button on the Arduino

# Check permissions (Linux)
sudo usermod -a -G dialout $USER
# Then log out and back in
```

### Upload Failed

- Verify the port path is correct
- Make sure no other program (Arduino IDE, serial monitor) is using the port
- Try pressing reset on the board right before upload
- Check that the board type matches your hardware

### Duemilanove Specific

The Duemilanove uses the `diecimila` FQBN (Fully Qualified Board Name) in arduino-cli. The library automatically handles this mapping when you specify `board="duemilanove"`.
