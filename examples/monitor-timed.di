<dirac>
  <!--
    Arduino Sensor Monitor with Time Limit
    Monitors Arduino sensor output for a specified number of readings,
    then processes and reports the data.
  -->
  
  <import href="../lib/arduino.di" />
  
  <defvar name="port">/dev/cu.usbserial-A800f88N</defvar>
  <defvar name="sketch">AnalogRead</defvar>
  <defvar name="max_readings">10</defvar>
  <defvar name="log_file">/tmp/arduino-sensor-log.txt</defvar>
  
  <output>Monitoring Arduino sensor for $max_readings readings...</output>
  
  <!-- Clean up old files -->
  <system>rm -f $log_file</system>
  
  <!-- Start monitor in background, log to file -->
  <system background="true">arduino-cli monitor -p $port --config baudrate=9600 > $log_file 2>&1 &</system>
  <output>✓ Monitor started, logging to $log_file</output>
  
  <!-- Give monitor time to start -->
  <system>sleep 2</system>
  
  <output>Reading sensor data...</output>
  <output>----------------------------------------</output>
  
  <!-- Read specified number of lines -->
  <defvar name="count">0</defvar>
  <loop condition="$count &lt; $max_readings">
    <!-- Wait for new line to appear -->
    <system>tail -n 1 $log_file</system>
    <defvar name="reading">$SYSTEM_OUTPUT</defvar>
    
    <!-- Process the reading -->
    <output>[$count] $reading</output>
    
    <!-- Example: Send to message service -->
    <!-- <system>curl -X POST http://localhost:3030/api/send -d "sensor=$reading"</system> -->
    
    <!-- Increment counter -->
    <eval>$count + 1</eval>
    <defvar name="count">$EVAL_RESULT</defvar>
    
    <!-- Small delay between readings -->
    <system>sleep 1</system>
  </loop>
  
  <output>----------------------------------------</output>
  <output>✓ Collected $max_readings sensor readings</output>
  
  <!-- Kill the background monitor process -->
  <system>pkill -f "arduino-cli monitor"</system>
  <output>✓ Monitor stopped</output>
  
  <!-- Show summary -->
  <output>Log file saved: $log_file</output>
</dirac>
