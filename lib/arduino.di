<!-- Arduino Library for DIRAC -->
<!-- Provides subroutines to compile, upload, and interact with Arduino boards -->

<dirac>
  <!-- List all connected Arduino boards -->
  <subroutine name="arduino-list-boards"
              description="List all connected Arduino boards and their ports">
    <system>arduino-cli board list</system>
  </subroutine>

  <!-- Compile an Arduino sketch -->
  <subroutine name="arduino-compile"
              description="Compile an Arduino sketch"
              param-sketch="string"
              param-board="string">
    <output>Compiling for board: <variable name="board" /></output>
    
    <eval name="fqbn">
      const maps = {
        'uno': 'arduino:avr:uno',
        'duemilanove': 'arduino:avr:diecimila',
        'nano': 'arduino:avr:nano',
        'mega': 'arduino:avr:mega'
      };
      return maps[board] || '';
    </eval>
    
    <output>Using FQBN: <variable name="fqbn" /></output>
    <system>arduino-cli compile --fqbn <variable name="fqbn" /> <variable name="sketch" /></system>
  </subroutine>

  <!-- Upload compiled sketch to board -->
  <subroutine name="arduino-upload"
              description="Upload compiled sketch to Arduino board"
              param-sketch="string"
              param-board="string"
              param-port="string">
    <eval name="fqbn">
      const maps = {
        'uno': 'arduino:avr:uno',
        'duemilanove': 'arduino:avr:diecimila',
        'nano': 'arduino:avr:nano',
        'mega': 'arduino:avr:mega'
      };
      return maps[board] || '';
    </eval>
    
    <output>Uploading to <variable name="board" /> on port <variable name="port" /></output>
    <system>arduino-cli upload -p <variable name="port" /> --fqbn <variable name="fqbn" /> <variable name="sketch" /></system>
  </subroutine>

  <!-- Compile and upload in one step -->
  <subroutine name="arduino-deploy"
              description="Compile and upload Arduino sketch in one step"
              param-sketch="string"
              param-board="string"
              param-port="string">
    <arduino-compile sketch="$sketch" board="$board" />
    <arduino-upload sketch="$sketch" board="$board" port="$port" />
  </subroutine>

  <!-- Open serial monitor -->
  <subroutine name="arduino-monitor"
              description="Open serial monitor to view Arduino output"
              param-port="string:required:Serial port"
              param-baud="string:optional:Baud rate (default: 9600)">
    <parameters select="@port" />
    <parameters select="@baud" />
    
    <defvar name="baudrate" trim="true">
      <eval>typeof baud === 'undefined' || !baud ? '9600' : baud</eval>
    </defvar>
    
    <output>Opening serial monitor on <variable name="port" /> at <variable name="baudrate" /> baud</output>
    <output>Press Ctrl+C to exit</output>
    <system>arduino-cli monitor -p <variable name="port" /> -c baudrate=<variable name="baudrate" /></system>
  </subroutine>

  <!-- Create a new Arduino sketch from template -->
  <subroutine name="arduino-create-sketch"
              description="Create a new Arduino sketch from template"
              param-name="string:required:Sketch name"
              param-path="string:optional:Path where sketch will be created (default: current directory)">
    <parameters select="@name" />
    <parameters select="@path" />
    
    <defvar name="targetPath" trim="true">
      <eval>typeof path === 'undefined' || !path ? './' : path</eval>
    </defvar>
    
    <output>Creating sketch: <variable name="name" /> in <variable name="targetPath" /></output>
    <system>arduino-cli sketch new <variable name="targetPath" />/<variable name="name" /></system>
  </subroutine>

  <!-- Search for Arduino libraries -->
  <subroutine name="arduino-lib-search"
              description="Search for Arduino libraries"
              param-query="string:required:Search query">
    <parameters select="@query" />
    <output>Searching for libraries: <variable name="query" /></output>
    <system>arduino-cli lib search <variable name="query" /></system>
  </subroutine>

  <!-- Install Arduino library -->
  <subroutine name="arduino-lib-install"
              description="Install an Arduino library"
              param-library="string:required:Library name">
    <parameters select="@library" />
    <output>Installing library: <variable name="library" /></output>
    <system>arduino-cli lib install <variable name="library" /></system>
  </subroutine>
</dirac>
