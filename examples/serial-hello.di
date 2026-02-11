<dirac>
  <!-- Serial Hello Example: Send messages from Arduino to computer -->
  <!-- This example compiles, uploads, and monitors serial output -->
  
  <import lib="../lib/arduino.di" />
  
  <output>========================================</output>
  <output>Arduino Serial Hello Example</output>
  <output>========================================</output>
  <output></output>
  
  <!-- Detect connected boards -->
  <output>1. Detecting connected Arduino boards...</output>
  <arduino-list-boards />
  <output></output>
  
  <!-- Configure your board settings here -->
  <defvar name="sketch" trim="true">/Users/zhiwang/diraclang/dirac-arduino/sketches/SerialHello</defvar>
  <defvar name="board" trim="true">duemilanove</defvar>
  <defvar name="port" trim="true">/dev/cu.usbserial-A800f88N</defvar>
  <defvar name="baud" trim="true">9600</defvar>
  
  <output>2. Configuration:</output>
  <output>   Sketch: <variable name="sketch" /></output>
  <output>   Board: <variable name="board" /></output>
  <output>   Port: <variable name="port" /></output>
  <output>   Baud Rate: <variable name="baud" /></output>
  <output></output>
  
  <!-- Compile and upload -->
  <output>3. Compiling and uploading...</output>
  <arduino-deploy sketch="$sketch" board="$board" port="$port" />
  <output></output>
  
  <output>========================================</output>
  <output>Upload complete!</output>
  <output>Opening serial monitor...</output>
  <output>Press Ctrl+C to exit</output>
  <output>========================================</output>
  <output></output>
  
  <!-- Open serial monitor to see output -->
  <arduino-monitor port="$port" baud="$baud" />
</dirac>
