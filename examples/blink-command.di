<dirac>
  <import src="../lib/blink-control.di" />

  <output>Now triggering 3 flashes:</output>
  <blink times="3" interval="250" pin="12" port="/dev/cu.usbserial-A800f88N" />
</dirac>
