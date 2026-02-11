// Analog sensor reading example
// Reads analog input from A0 and prints to serial port

const int analogPin = A0;  // Analog input pin (A0)
int sensorValue = 0;       // Variable to store the sensor value

void setup() {
  Serial.begin(9600);  // Initialize serial communication
  Serial.println("Analog Sensor Reader");
  Serial.println("Reading from pin A0...");
}

void loop() {
  sensorValue = analogRead(analogPin);  // Read the analog input
  
  // Print both raw value (0-1023) and voltage (0-5V)
  Serial.print("Raw value: ");
  Serial.print(sensorValue);
  Serial.print(" | Voltage: ");
  Serial.print(sensorValue * (5.0 / 1023.0));
  Serial.println("V");
  
  delay(500);  // Wait 500ms between readings
}
