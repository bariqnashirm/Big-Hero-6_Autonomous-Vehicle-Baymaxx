// =====================================
// TEST DUAL MOTOR - CYTRON MDD10A + ARDUINO MEGA
// Mode: Sign-Magnitude PWM
// FIX: arah DIR dibalik (maju <-> mundur)
// =====================================

// --- MOTOR KIRI (channel 1 MDD10A) ---
const int DIR_KIRI = 9;
const int PWM_KIRI = 6;

// --- MOTOR KANAN (channel 2 MDD10A) ---
const int DIR_KANAN = 8;
const int PWM_KANAN = 7;

// --- SPEED SETTING (0-255) ---
const int SPEED_MAJU   = 100;
const int SPEED_MUNDUR = 100;

void stopMotor() {
  analogWrite(PWM_KIRI, 0);
  analogWrite(PWM_KANAN, 0);
}

void setMotorKiri(int speed, bool maju) {
  analogWrite(PWM_KIRI, 0);
  digitalWrite(DIR_KIRI, maju ? HIGH : LOW);   // <-- dibalik
  delay(5);
  analogWrite(PWM_KIRI, speed);
}

void setMotorKanan(int speed, bool maju) {
  analogWrite(PWM_KANAN, 0);
  digitalWrite(DIR_KANAN, maju ? LOW : HIGH);  // <-- dibalik
  delay(5);
  analogWrite(PWM_KANAN, speed);
}

void setup() {
  pinMode(DIR_KIRI, OUTPUT);
  pinMode(PWM_KIRI, OUTPUT);
  pinMode(DIR_KANAN, OUTPUT);
  pinMode(PWM_KANAN, OUTPUT);

  Serial.begin(9600);
  Serial.println("START TEST MOTOR - MDD10A");

  stopMotor();
  delay(1000);
}

void loop() {
  // ====== HANYA KIRI MAJU ======
  Serial.println("=== TEST 1: KIRI MAJU saja ===");
  setMotorKiri(SPEED_MAJU, true);
  delay(2000);
  stopMotor();
  delay(1500);

  // ====== HANYA KANAN MAJU ======
  Serial.println("=== TEST 2: KANAN MAJU saja ===");
  setMotorKanan(SPEED_MAJU, true);
  delay(2000);
  stopMotor();
  delay(1500);

  // ====== DUA-DUANYA MAJU ======
  Serial.println("=== TEST 3: KIRI + KANAN MAJU ===");
  setMotorKiri(SPEED_MAJU, true);
  setMotorKanan(SPEED_MAJU, true);
  delay(2000);
  stopMotor();
  delay(1500);

  // ====== DUA-DUANYA MUNDUR ======
  Serial.println("=== TEST 4: KIRI + KANAN MUNDUR ===");
  setMotorKiri(SPEED_MUNDUR, false);
  setMotorKanan(SPEED_MUNDUR, false);
  delay(2000);
  stopMotor();
  delay(1500);

  Serial.println(">>> Cycle selesai, ulang dari awal <<<\n");
}
