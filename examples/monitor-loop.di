<dirac>
  <!--
    Arduino Monitor with Loop Pattern
    This example shows how to continuously monitor Arduino output
    and process each line of data as it arrives.
  -->
  
  <import href="../lib/arduino.di" />
  
  <defvar name="port">/dev/cu.usbserial-A800f88N</defvar>
  <defvar name="sketch">SerialHello</defvar>
  <defvar name="pipe_path">/tmp/arduino-monitor-$sketch.pipe</defvar>
  
  <output>Starting Arduino monitor loop for $sketch...</output>
  
  <!-- Clean up old pipe if exists -->
  <system>rm -f $pipe_path</system>
  
  <!-- Create named pipe for communication -->
  <system>mkfifo $pipe_path</system>
  <output>✓ Created pipe: $pipe_path</output>
  
  <!-- Start monitor in background, redirect to pipe -->
  <system background="true">arduino-cli monitor -p $port --config baudrate=9600 > $pipe_path 2>&1 &</system>
  <output>✓ Monitor started in background</output>
  
  <!-- Give monitor time to initialize -->
  <system>sleep 2</system>
  
  <output>Reading from Arduino (Ctrl+C to stop)...</output>
  <output>----------------------------------------</output>
  
  <!-- Read from pipe line by line -->
  <!-- Note: This will block waiting for data, which is what we want -->
  <loop condition="true">
    <system>head -n 1 $pipe_path</system>
    <defvar name="line">$SYSTEM_OUTPUT</defvar>
    
    <!-- Process the line -->
    <output>Arduino: $line</output>
    
    <!-- Example: You could send this to a message, save to file, etc. -->
    <!-- <system>curl -X POST http://localhost:3030/api/send -d "message=$line"</system> -->
  </loop>
  
  <!-- This part won't be reached due to infinite loop, but good practice -->
  <system>rm -f $pipe_path</system>
</dirac>
