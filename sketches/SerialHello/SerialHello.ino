// Serial Hello World example
// Sends "Hello from Arduino!" to serial port every second

void setup() {
  Serial.begin(9600);  // Initialize serial communication at 9600 baud
  while (!Serial) {
    ; // Wait for serial port to connect (needed for Leonardo/Micro)
  }
  Serial.println("Arduino Serial Hello World");
  Serial.println("Ready to send messages...");
}

void loop() {
  Serial.println("Hello from Arduino!");
  delay(1000);  // Wait 1 second between messages
}
