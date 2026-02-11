<dirac>
  <!-- Blink Example: Classic LED blink using Arduino -->
  <!-- This example compiles and uploads the Blink sketch to an Arduino board -->
  
  <import src="../lib/arduino.di" />
  
  <output>========================================</output>
  <output>Arduino Blink Example</output>
  <output>========================================</output>
  <output></output>
  
  <!-- Detect connected boards -->
  <output>1. Detecting connected Arduino boards...</output>
  <arduino-list-boards />
  <output></output>
  
  <!-- Configure your board settings here -->
  <defvar name="sketch" trim="true">/Users/zhiwang/diraclang/dirac-arduino/sketches/Blink</defvar>
  <defvar name="board" trim="true">duemilanove</defvar>
  <defvar name="port" trim="true">/dev/cu.usbserial-A800f88N</defvar>
  
  <output>2. Configuration:</output>
  <output>   Sketch: <variable name="sketch" /></output>
  <output>   Board: <variable name="board" /></output>
  <output>   Port: <variable name="port" /></output>
  <output></output>
  
  <!-- Compile and upload the sketch -->
  <output>3. Compiling and uploading...</output>
  <arduino-deploy sketch="$sketch" board="$board" port="$port" />
  <output></output>
  
  <output>========================================</output>
  <output>Upload complete!</output>
  <output>The LED should now be blinking on your Arduino.</output>
  <output>========================================</output>
</dirac>
