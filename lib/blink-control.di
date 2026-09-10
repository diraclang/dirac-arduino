<dirac>
  <!--
    Blink command library.
    Note: blink-setup uploads the BlinkControl sketch once. After that,
    blink sends "times interval" over serial to the board.
  -->

  <subroutine name="blink-setup"
              description="Compile/upload BlinkControl sketch"
              param-board="string:optional:Board type|duemilanove|uno|nano|mega"
              param-port="string:optional:Serial port"
              param-sketch="string:optional:Sketch folder path">
    <parameters select="@board" />
    <parameters select="@port" />
    <parameters select="@sketch" />

    <eval name="resolvedBoard">return typeof board === 'undefined' || !board ? 'duemilanove' : board</eval>
    <eval name="resolvedPort">return typeof port === 'undefined' || !port ? '/dev/cu.usbserial-A800f88N' : port</eval>
    <eval name="resolvedSketch">return typeof sketch === 'undefined' || !sketch ? '/Users/zhiwang/diraclang/dirac-arduino/sketches/BlinkControl' : sketch</eval>

    <eval name="fqbn">
      const maps = {
        'uno': 'arduino:avr:uno',
        'duemilanove': 'arduino:avr:diecimila',
        'nano': 'arduino:avr:nano',
        'mega': 'arduino:avr:mega'
      };
      return maps[resolvedBoard] || 'arduino:avr:diecimila';
    </eval>

    <output>Uploading BlinkControl sketch...</output>
    <output>Board: <variable name="resolvedBoard" /> (<variable name="fqbn" />)</output>
    <output>Port: <variable name="resolvedPort" /></output>
    <system>arduino-cli compile --fqbn <variable name="fqbn" /> <variable name="resolvedSketch" /></system>
    <system>arduino-cli upload -p <variable name="resolvedPort" /> --fqbn <variable name="fqbn" /> <variable name="resolvedSketch" /></system>
    <output>BlinkControl ready.</output>
  </subroutine>

  <subroutine name="blink"
              description="Blink N times at interval milliseconds"
              param-times="string:required:Number of flashes"
              param-interval="string:optional:On/off interval in ms|250"
              param-pin="string:optional:LED pin (default 12 to avoid D13 bootloader flashes)|12"
              param-settle="string:optional:Delay before first blink in ms|700"
              param-port="string:optional:Serial port"
              param-board="string:optional:Board type|duemilanove|uno|nano|mega">
    <parameters select="@times" />
    <parameters select="@interval" />
    <parameters select="@pin" />
    <parameters select="@settle" />
    <parameters select="@port" />
    <parameters select="@board" />

    <eval name="blinkTimes">return typeof times === 'undefined' || !times ? '1' : times</eval>
    <eval name="blinkInterval">return typeof interval === 'undefined' || !interval ? '250' : interval</eval>
    <eval name="blinkPin">return typeof pin === 'undefined' || !pin ? '12' : pin</eval>
    <eval name="blinkSettle">return typeof settle === 'undefined' || !settle ? '700' : settle</eval>
    <eval name="resolvedPort">return typeof port === 'undefined' || !port ? '/dev/cu.usbserial-A800f88N' : port</eval>
    <eval name="resolvedBoard">return typeof board === 'undefined' || !board ? 'duemilanove' : board</eval>
    <eval name="fqbn">
      const maps = {
        'uno': 'arduino:avr:uno',
        'duemilanove': 'arduino:avr:diecimila',
        'nano': 'arduino:avr:nano',
        'mega': 'arduino:avr:mega'
      };
      return maps[resolvedBoard] || 'arduino:avr:diecimila';
    </eval>

    <output>Blink command: <variable name="blinkTimes" /> times, <variable name="blinkInterval" />ms interval</output>
    <output>Board: <variable name="resolvedBoard" /> (<variable name="fqbn" />)</output>
    <output>Port: <variable name="resolvedPort" /></output>

    <python><![CDATA[
import os

count = int(str(blinkTimes).strip())
interval = int(str(blinkInterval).strip())
led_pin = int(str(blinkPin).strip())
settle_ms = int(str(blinkSettle).strip())

if count == 0:
  raise ValueError("times must be non-zero")
if interval == 0:
  raise ValueError("interval must be non-zero")
if led_pin < 0:
  raise ValueError("pin must be >= 0")
if settle_ms < 0:
  raise ValueError("settle must be >= 0")

if count > 500:
  count = 500
if 20 > interval:
  interval = 20
if interval > 10000:
  interval = 10000
if led_pin > 53:
  led_pin = 53
if settle_ms > 5000:
  settle_ms = 5000

sketch_dir = "/tmp/dirac-blink-once"
os.makedirs(sketch_dir, exist_ok=True)
sketch_file = os.path.join(sketch_dir, "dirac-blink-once.ino")

sketch = f'''const int LED_PIN = {led_pin};
const int FLASH_COUNT = {count};
const unsigned long INTERVAL_MS = {interval};
const unsigned long STARTUP_SETTLE_MS = {settle_ms};

void setup() {{
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, LOW);
  delay(STARTUP_SETTLE_MS);
  int i = 0;
  while (i != FLASH_COUNT) {{
    digitalWrite(LED_PIN, HIGH);
    delay(INTERVAL_MS);
    digitalWrite(LED_PIN, LOW);
    delay(INTERVAL_MS);
    i++;
  }}
}}

void loop() {{
  // One-shot program: done after setup() blink sequence.
  delay(1000);
}}
'''

with open(sketch_file, "w", encoding="utf-8") as handle:
  handle.write(sketch)

print(f"Generated one-shot sketch: pin={led_pin} count={count} interval={interval}ms settle={settle_ms}ms")
    ]]></python>

    <system>arduino-cli compile --fqbn <variable name="fqbn" /> /tmp/dirac-blink-once</system>
    <system>arduino-cli upload -p <variable name="resolvedPort" /> --fqbn <variable name="fqbn" /> /tmp/dirac-blink-once</system>
  </subroutine>
</dirac>
