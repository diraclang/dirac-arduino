/*
  BlinkControl

  Configurable LED blink program:
  - Control flash count and interval.
  - Defaults can be edited below.
  - Optional runtime update over Serial at 9600 baud by sending:
      <count> <interval_ms>
    Example: 5 200
*/

const int LED_PIN = 13;

int pendingFlashCount = 0;
unsigned long pendingIntervalMs = 250;

char cmdBuffer[64];
int cmdLen = 0;

void blinkPattern(int count, unsigned long interval) {
  for (int i = 0; i < count; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(interval);
    digitalWrite(LED_PIN, LOW);
    delay(interval);
  }
}

void handleCommandLine(const char* line) {
  int newCount = 0;
  unsigned long newInterval = 0;

  // Preferred command format: B <count> <interval_ms>
  // Backward-compatible fallback: <count> <interval_ms>
  int parsed = sscanf(line, "B %d %lu", &newCount, &newInterval);
  if (parsed != 2) {
    parsed = sscanf(line, "%d %lu", &newCount, &newInterval);
  }

  if (parsed == 2 && newCount > 0 && newInterval > 0) {
    if (newCount > 500) {
      newCount = 500;
    }
    if (newInterval < 20) {
      newInterval = 20;
    }
    if (newInterval > 10000) {
      newInterval = 10000;
    }

    pendingFlashCount = newCount;
    pendingIntervalMs = newInterval;

    Serial.print("ACK ");
    Serial.print(pendingFlashCount);
    Serial.print(" ");
    Serial.println(pendingIntervalMs);
  } else {
    Serial.println("ERR format: B <count> <interval_ms>");
  }
}

void tryUpdateFromSerial() {
  while (Serial.available() > 0) {
    char c = (char)Serial.read();

    if (c == '\r') {
      continue;
    }

    if (c == '\n') {
      if (cmdLen > 0) {
        cmdBuffer[cmdLen] = '\0';
        handleCommandLine(cmdBuffer);
        cmdLen = 0;
      }
      continue;
    }

    if (cmdLen < (int)sizeof(cmdBuffer) - 1) {
      cmdBuffer[cmdLen++] = c;
    } else {
      // Overflow guard: reset the buffer and ask for a shorter command.
      cmdLen = 0;
      Serial.println("ERR command too long");
    }
  }
}

void setup() {
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(9600);

  Serial.println("BlinkControl ready");
  Serial.println("Send: B <count> <interval_ms> (e.g. B 10 150)");
  Serial.println("Each command runs once, then stops.");
}

void loop() {
  tryUpdateFromSerial();
  if (pendingFlashCount > 0) {
    const int count = pendingFlashCount;
    const unsigned long interval = pendingIntervalMs;

    // Clear queue before running so a second serial command can queue while blinking.
    pendingFlashCount = 0;

    blinkPattern(count, interval);
    Serial.print("Done: ");
    Serial.print(count);
    Serial.println(" flashes");
  }

  delay(20);
}
