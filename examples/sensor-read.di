<dirac>
  <!-- Analog Sensor Reading Example -->
  <!-- This example reads analog input from pin A0 and displays values -->
  
  <import lib="../lib/arduino.di" />
  
  <output>========================================</output>
  <output>Arduino Analog Sensor Reading Example</output>
  <output>========================================</output>
  <output></output>
  
  <output>This example reads analog values from pin A0.</output>
  <output>Connect a sensor or potentiometer to A0 to see values change.</output>
  <output></output>
  
  <!-- Detect connected boards -->
  <output>1. Detecting connected Arduino boards...</output>
  <arduino-list-boards />
  <output></output>
  
  <!-- Configure your board settings here -->
  <defvar name="sketch">/Users/zhiwang/diraclang/dirac-arduino/sketches/AnalogRead</defvar>
  <defvar name="board">duemilanove</defvar>
  <defvar name="port">/dev/cu.usbserial-A800f88N</defvar>
  <defvar name="baud">9600</defvar>
  
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
  <output>Opening serial monitor to view sensor readings...</output>
  <output>Press Ctrl+C to exit</output>
  <output>========================================</output>
  <output></output>
  
  <!-- Open serial monitor to see sensor readings -->
  <arduino-monitor port="$port" baud="$baud" />
</dirac>
