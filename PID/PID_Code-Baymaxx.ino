#define encoder0PinA 2
#define encoder0PinB 4
volatile long encoder0Pos = 0;

// Motor
int pwm = 7;
int dir = 8;

// Sesuaikan dengan encoder
float PPR = 500;

// Control
float setpointDeg = 720;
float posDeg = 0;
float Error = 0;
float U = 0;

// PID parameter
float Kp = 0.055;
float Ki = 0.009;
float Kd = 0.006;

// PID internal
float integrated_error = 0;
float last_error = 0;
float pTerm, iTerm, dTerm;
const float GUARD_GAIN = 10.0;

// Tuning
float toleranceDeg = 2.0;
int minPWM = 35;
int maxPWM = 255;

// Serial input
String inputString = "";
bool stringComplete = false;

void setup() {
  pinMode(encoder0PinA, INPUT_PULLUP);
  pinMode(encoder0PinB, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(encoder0PinA), doEncoder, RISING);
  pinMode(pwm, OUTPUT);
  pinMode(dir, OUTPUT);
  Serial.begin(115200);
  inputString.reserve(50);
}

void loop() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    if (inChar == '\n' || inChar == '\r') {
      if (inputString.length() > 0) stringComplete = true;
    } else {
      inputString += inChar;
    }
  }

  if (stringComplete) {
    parseInput(inputString);
    inputString = "";
    stringComplete = false;
  }

  posDeg = (encoder0Pos / PPR) * 360.0;
  Error = setpointDeg - posDeg;

  if (abs(Error) <= toleranceDeg) {
    stopMotor();
    U = 0;
    integrated_error = 0;
  } else {
    pTerm = Kp * Error;

    integrated_error += Error;
    integrated_error = constrain(integrated_error, -GUARD_GAIN, GUARD_GAIN);
    iTerm = Ki * integrated_error;

    dTerm = Kd * (Error - last_error);
    last_error = Error;

    U = pTerm + iTerm + dTerm;

    if (U > maxPWM) U = maxPWM;
    if (U < -maxPWM) U = -maxPWM;

    int pwmOut = abs((int)U);

    if (pwmOut > 0 && pwmOut < minPWM) pwmOut = minPWM;

    if (Error > 0) {
      backwardMotor(pwmOut);
    } else {
      forwardMotor(pwmOut);
    }
  }

  Serial.print(millis());
  Serial.print(",");
  Serial.println(posDeg, 2);

  delay(20);
}

void parseInput(String s) {
  s.trim();
  int eqIdx = s.indexOf('=');
  if (eqIdx == -1) return;

  String key = s.substring(0, eqIdx);
  String val = s.substring(eqIdx + 1);
  key.trim();
  val.trim();
  float value = val.toFloat();

  if (key.equalsIgnoreCase("Kp")) {
    Kp = value;
  } else if (key.equalsIgnoreCase("Ki")) {
    Ki = value;
    integrated_error = 0;
  } else if (key.equalsIgnoreCase("Kd")) {
    Kd = value;
  } else if (key.equalsIgnoreCase("SP")) {
    setpointDeg = value;
    integrated_error = 0;
  }
}

void stopMotor() {
  analogWrite(pwm, 0);
}

void forwardMotor(int a) {
  digitalWrite(dir, HIGH);
  analogWrite(pwm, a);
}

void backwardMotor(int a) {
  digitalWrite(dir, LOW);
  analogWrite(pwm, a);
}

void doEncoder() {
  if (digitalRead(encoder0PinA) == digitalRead(encoder0PinB)) {
    encoder0Pos++;
  } else {
    encoder0Pos--;
  }
}
