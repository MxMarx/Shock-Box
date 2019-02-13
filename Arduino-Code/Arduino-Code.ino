
#define TEST_PIN 2
#define SHOCK_PIN 12
#define LED_PIN 13

void setup() {
  pinMode(TEST_PIN, INPUT_PULLUP);
  Serial.begin(9600);

  pinMode(LED_PIN, OUTPUT);
  pinMode(SHOCK_PIN, OUTPUT);
  // digitalWrite(SHOCK_PIN,LOW);

}

unsigned long DURATION;
unsigned long currentMillis;
unsigned long previousMillis;
byte shockState = LOW;

void loop() {
  currentMillis = millis();

  if (currentMillis - previousMillis >= DURATION) {
    shockState = LOW;
  }

  if (Serial.available()) {
    DURATION = Serial.parseInt(); // Read the duration in milliseconds
    if (Serial.read() == '\n'){ // If new line character, indicating end of message
      shockState = HIGH; // turn the shock on
      previousMillis = currentMillis;  // Time when the shock came on
    }
  }





  if(digitalRead(TEST_PIN) == LOW) {
    shockState = HIGH;
  }
  else digitalWrite(SHOCK_PIN,LOW);

  digitalWrite(LED_PIN,shockState);
  digitalWrite(SHOCK_PIN,shockState);
}
