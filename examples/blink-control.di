<dirac>
  <!-- BlinkControl example: adjustable flash count + interval -->
  <import src="../lib/arduino.di" />

  <output>========================================</output>
  <output>Arduino BlinkControl Example</output>
  <output>========================================</output>
  <output></output>

  <defvar name="sketch">/Users/zhiwang/diraclang/dirac-arduino/sketches/BlinkControl</defvar>
  <defvar name="board">duemilanove</defvar>
  <defvar name="port">/dev/cu.usbserial-A800f88N</defvar>

  <output>Sketch: <variable name="sketch" /></output>
  <output>Board: <variable name="board" /></output>
  <output>Port: <variable name="port" /></output>
  <output></output>

  <arduino-deploy sketch="$sketch" board="$board" port="$port" />

  <output></output>
  <output>Upload complete.</output>
  <output>Default behavior is 3 flashes with 250ms interval.</output>
  <output>To change at runtime, open serial monitor at 9600 and send:</output>
  <output>  5 200</output>
  <output>(means 5 flashes, 200ms on/off interval)</output>
</dirac>
