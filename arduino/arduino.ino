/* 
  LILYGO Joystick Example with Button and Potentiometer
  Joystick X, Y, and SW are connected to pins 39, 32, and 33
  Button connected to pin 14
  Potentiometer connected to pin 36
  Prints out X, Y, Z, Button, and Potentiometer values to Serial
*/

int xyzPins[] = {39, 32, 33};   // x, y, z(switch) pins
int buttonPin = 15;             // Digital pin for the button
int potPin = 12;                // Analog pin for the potentiometer

void setup() {
  Serial.begin(115200);
  pinMode(xyzPins[2], INPUT_PULLUP);  // Pull-up resistor for joystick switch
  pinMode(buttonPin, INPUT_PULLUP);   // Pull-up resistor for button
}

void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  int buttonVal = digitalRead(buttonPin);
  int potVal = analogRead(potPin);

  // Send data to Serial in CSV format for easy parsing in Processing
  Serial.printf("%d,%d,%d,%d,%d\n", xVal, yVal, zVal, buttonVal, potVal);
  delay(100);
}
