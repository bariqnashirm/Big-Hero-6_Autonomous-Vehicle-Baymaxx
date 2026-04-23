// ======================================================
// SINGLE FILE ARDUINO CODE
// Trajectory arrays dari MATLAB sudah digabung di file ini
// Tidak perlu lagi file trajectory_arrays.h
// ======================================================

#include <avr/pgmspace.h>

// AUTO-GENERATED dari MATLAB. Jangan edit manual.


const unsigned int Ts_ms     = 10;
const int trajLength = 528;

// Index batas segmen 0-based untuk Arduino
const int IDX_SEG1_START  = 0;
const int IDX_SEG1_END    = 160;
const int IDX_SEG2A_START = 161;
const int IDX_SEG2A_END   = 190;
const int IDX_SEG2B_START = 191;
const int IDX_SEG2B_END   = 262;
const int IDX_SEG3_START  = 263;
const int IDX_SEG3_END    = 322;
const int IDX_SEG4A_START = 323;
const int IDX_SEG4A_END   = 352;
const int IDX_SEG4B_START = 353;
const int IDX_SEG4B_END   = 417;
const int IDX_SEG5_START  = 418;
const int IDX_SEG5_END    = 527;

const long countRefL[] PROGMEM = {
0,0,0,0,0,0,1,1,2,2,
3,4,5,6,7,9,11,13,15,17,
20,22,25,29,32,36,40,44,48,53,
58,63,69,74,80,87,93,100,107,114,
121,129,137,145,154,163,172,181,190,200,
210,220,230,240,251,262,273,284,295,307,
319,331,343,355,367,379,392,405,417,430,
443,456,469,482,495,509,522,535,548,562,
575,588,602,615,628,641,655,668,681,694,
707,720,732,745,757,770,782,794,806,818,
830,841,853,864,875,886,896,907,917,927,
937,947,956,965,974,983,991,1000,1008,1015,
1023,1030,1037,1044,1050,1057,1063,1068,1074,1079,
1084,1089,1093,1097,1101,1105,1108,1112,1115,1117,
1120,1122,1124,1126,1128,1129,1131,1132,1133,1134,
1135,1135,1136,1136,1136,1137,1137,1137,1137,1137,
1137,1137,1138,1140,1143,1147,1153,1160,1169,1179,
1190,1203,1216,1229,1243,1258,1272,1285,1298,1311,
1322,1332,1341,1348,1354,1358,1361,1363,1364,1364,
1364,1364,1364,1364,1363,1362,1361,1360,1358,1356,
1354,1350,1347,1343,1339,1334,1328,1322,1316,1309,
1302,1294,1286,1277,1268,1259,1249,1239,1229,1218,
1207,1196,1185,1174,1162,1151,1139,1128,1116,1105,
1094,1083,1072,1061,1050,1040,1030,1021,1011,1002,
994,986,978,971,964,958,952,947,942,938,
934,931,928,925,923,921,920,919,919,918,
918,918,918,918,919,920,923,926,932,938,
947,958,970,985,1001,1020,1041,1063,1088,1115,
1144,1174,1206,1239,1274,1311,1348,1386,1425,1465,
1505,1545,1586,1626,1667,1706,1745,1784,1821,1857,
1892,1926,1958,1988,2017,2043,2068,2091,2112,2130,
2147,2161,2174,2184,2193,2200,2205,2209,2211,2213,
2214,2214,2214,2214,2216,2219,2225,2232,2243,2256,
2272,2290,2310,2332,2356,2380,2406,2431,2457,2481,
2505,2527,2547,2565,2581,2594,2604,2612,2618,2621,
2623,2623,2623,2623,2624,2626,2630,2635,2642,2652,
2664,2679,2697,2718,2742,2768,2798,2831,2868,2907,
2949,2994,3041,3091,3144,3199,3256,3315,3375,3437,
3500,3564,3629,3694,3760,3825,3891,3955,4020,4083,
4145,4205,4264,4321,4376,4428,4478,4526,4571,4613,
4652,4688,4721,4751,4778,4802,4823,4840,4855,4868,
4877,4885,4890,4893,4895,4896,4897,4897,4897,4897,
4897,4897,4898,4898,4899,4900,4901,4903,4905,4907,
4910,4913,4916,4919,4923,4928,4932,4938,4943,4949,
4956,4962,4969,4977,4985,4993,5002,5011,5021,5031,
5041,5052,5063,5074,5086,5098,5110,5122,5135,5148,
5161,5175,5188,5202,5216,5230,5244,5259,5273,5287,
5302,5317,5331,5346,5360,5375,5389,5403,5418,5432,
5446,5459,5473,5486,5500,5513,5525,5538,5550,5562,
5574,5585,5596,5606,5617,5627,5636,5645,5654,5663,
5671,5678,5685,5692,5698,5704,5710,5715,5720,5724,
5728,5732,5735,5738,5741,5743,5745,5746,5747,5749,
5749,5750,5750,5751,5751,5751,5751,5751
};

const long countRefR[] PROGMEM = {
0,0,0,0,0,0,1,1,2,2,
3,4,5,6,7,9,11,13,15,17,
20,22,25,29,32,36,40,44,48,53,
58,63,69,74,80,87,93,100,107,114,
121,129,137,145,154,163,172,181,190,200,
210,220,230,240,251,262,273,284,295,307,
319,331,343,355,367,379,392,405,417,430,
443,456,469,482,495,509,522,535,548,562,
575,588,602,615,628,641,655,668,681,694,
707,720,732,745,757,770,782,794,806,818,
830,841,853,864,875,886,896,907,917,927,
937,947,956,965,974,983,991,1000,1008,1015,
1023,1030,1037,1044,1050,1057,1063,1068,1074,1079,
1084,1089,1093,1097,1101,1105,1108,1112,1115,1117,
1120,1122,1124,1126,1128,1129,1131,1132,1133,1134,
1135,1135,1136,1136,1136,1137,1137,1137,1137,1137,
1137,1137,1138,1140,1143,1147,1153,1160,1169,1179,
1190,1203,1216,1229,1243,1258,1272,1285,1298,1311,
1322,1332,1341,1348,1354,1358,1361,1363,1364,1364,
1364,1364,1364,1365,1365,1366,1367,1368,1370,1372,
1375,1378,1381,1385,1390,1395,1400,1406,1412,1419,
1427,1434,1443,1451,1460,1470,1479,1489,1500,1510,
1521,1532,1543,1555,1566,1577,1589,1600,1612,1623,
1635,1646,1657,1667,1678,1688,1698,1708,1717,1726,
1734,1743,1750,1757,1764,1770,1776,1781,1786,1791,
1794,1798,1801,1803,1805,1807,1808,1809,1810,1810,
1810,1811,1811,1811,1811,1813,1815,1819,1824,1831,
1840,1851,1863,1878,1894,1913,1934,1956,1981,2008,
2036,2067,2099,2132,2167,2203,2241,2279,2318,2358,
2398,2438,2479,2519,2559,2599,2638,2676,2714,2750,
2785,2818,2850,2881,2909,2936,2961,2984,3004,3023,
3040,3054,3067,3077,3086,3093,3098,3102,3104,3106,
3106,3107,3107,3107,3109,3112,3117,3125,3136,3149,
3164,3183,3203,3225,3248,3273,3298,3324,3349,3374,
3398,3420,3440,3458,3474,3487,3497,3505,3511,3514,
3515,3516,3516,3516,3517,3519,3523,3528,3535,3545,
3557,3572,3590,3611,3634,3661,3691,3724,3760,3800,
3842,3887,3934,3984,4037,4092,4149,4207,4268,4330,
4393,4457,4522,4587,4653,4718,4784,4848,4912,4976,
5037,5098,5157,5214,5268,5321,5371,5419,5464,5506,
5545,5581,5614,5644,5671,5695,5715,5733,5748,5760,
5770,5777,5783,5786,5788,5789,5789,5789,5790,5790,
5790,5790,5790,5791,5792,5793,5794,5796,5798,5800,
5803,5805,5809,5812,5816,5821,5825,5830,5836,5842,
5848,5855,5862,5870,5878,5886,5895,5904,5914,5924,
5934,5945,5956,5967,5978,5990,6003,6015,6028,6041,
6054,6067,6081,6095,6109,6123,6137,6151,6166,6180,
6195,6209,6224,6239,6253,6268,6282,6296,6310,6325,
6339,6352,6366,6379,6393,6406,6418,6431,6443,6455,
6466,6478,6489,6499,6510,6520,6529,6538,6547,6555,
6563,6571,6578,6585,6591,6597,6603,6608,6613,6617,
6621,6625,6628,6631,6633,6636,6637,6639,6640,6641,
6642,6643,6643,6644,6644,6644,6644,6644
};

// ================== PIN CONFIG ==================
  #define encoder0PinA 3
  #define encoder0PinB 5
  const int DIR_KIRI  = 9;
  const int PWM_KIRI  = 6;

  #define encoder1PinA 2
  #define encoder1PinB 4
  const int DIR_KANAN = 8;
  const int PWM_KANAN = 7;

  // ================== ENCODER ==================
  volatile long encoder0Pos = 0;
  volatile long encoder1Pos = 0;

  // ================== CONTROL ==================
  bool started = false;
  bool finished = false;

  float kFloat = 0.0f;   // index trajectory versi float
  int k = 0;             // index integer untuk akses array

  unsigned long lastControlTime = 0;
  unsigned long runStartTime = 0;

  // ================== QUICK TRACK TRIM ==================
  // potong bagian lurus awal trajectory
  const int startIndexOffset = 0;   // coba 80 / 100 / 120 / 150

  // ================== TRAJECTORY SPEED SCALE ==================
  // 1.00 = normal
  // 1.10 = sedikit lebih cepat
  // 1.20 = lebih agresif
  // jangan langsung 2.0
  float kStep = 1.00f;

  // ================== PID ==================
  float Kp = 0.5f;
  float Ki = 0.2f;
  float Kd = 0.1f;

  float error_L = 0, last_error_L = 0, integral_L = 0;
  float error_R = 0, last_error_R = 0, integral_R = 0;

  // ================== FEEDFORWARD ==================
  float Kff = 0.35f;
  long prevRefL = 0;
  long prevRefR = 0;

  // ================== MOTOR DIR STATE ==================
  int lastDirL = 0;
  int lastDirR = 0;

  // ================== LIMIT ==================
  const int pwmLimit = 255;
  const int minPWM = 110;
  const int turnMinPWM = 145;
  const int climbMinPWM = 165;

  const float stopTolerance = 15.0f;
  const float integralLimit = 4000.0f;

  // threshold deteksi kondisi
  const float turnDiffThreshold = 80.0f;     // beda error kiri-kanan
  const float climbErrThreshold = 120.0f;    // kedua error besar

  // ================== DEBUG ==================
  unsigned long lastPrintTime = 0;

  // =====================================================================
  void setup() {
    Serial.begin(115200);

    pinMode(DIR_KIRI, OUTPUT);
    pinMode(PWM_KIRI, OUTPUT);
    pinMode(DIR_KANAN, OUTPUT);
    pinMode(PWM_KANAN, OUTPUT);

    pinMode(encoder0PinA, INPUT_PULLUP);
    pinMode(encoder0PinB, INPUT_PULLUP);
    pinMode(encoder1PinA, INPUT_PULLUP);
    pinMode(encoder1PinB, INPUT_PULLUP);

    attachInterrupt(digitalPinToInterrupt(encoder0PinA), doEncoderLeft, RISING);
    attachInterrupt(digitalPinToInterrupt(encoder1PinA), doEncoderRight, RISING);

    stopAllMotors();

    Serial.println("AUTO START in 1 seconds...");
    delay(1000);
    startTrajectory();
  }

  // =====================================================================
  void loop() {
    if (!started || finished) return;

    unsigned long now = millis();

    if (now - lastControlTime < Ts_ms) return;
    lastControlTime += Ts_ms;

    // ambil index integer dari kFloat
    k = (int)(kFloat + 0.5f);

    if (k >= trajLength) {
      stopAllMotors();
      finished = true;
      Serial.println("DONE");
      return;
    }

    // ================== REF ==================
    long refL = pgm_read_dword(&countRefL[k]);
    long refR = pgm_read_dword(&countRefR[k]);

    // ================== ACTUAL ==================
    long posL, posR;
    noInterrupts();
    posL = encoder0Pos;
    posR = encoder1Pos;
    interrupts();

    float dt = Ts_ms / 1000.0f;

    // ================== ERROR ==================
    error_L = refL - posL;
    error_R = refR - posR;

    // ================== OPTIONAL STOP CHECK ==================
    // bisa dipakai kalau mau stop lebih halus di akhir
    if (k >= trajLength - 1 &&
        abs(error_L) < stopTolerance &&
        abs(error_R) < stopTolerance) {
      stopAllMotors();
      finished = true;
      Serial.println("DONE WITH TOLERANCE");
      return;
    }

    // ================== INTEGRAL ==================
    integral_L += error_L * dt;
    integral_R += error_R * dt;

    integral_L = constrain(integral_L, -integralLimit, integralLimit);
    integral_R = constrain(integral_R, -integralLimit, integralLimit);

    // ================== DERIVATIVE ==================
    float dL = (error_L - last_error_L) / dt;
    float dR = (error_R - last_error_R) / dt;

    // ================== FEEDFORWARD ==================
    float ffL = 0.0f;
    float ffR = 0.0f;

    if (k > startIndexOffset) {
      ffL = Kff * (refL - prevRefL);
      ffR = Kff * (refR - prevRefR);
    }

    // ================== PID + FF ==================
    float U_L = Kp * error_L + Ki * integral_L + Kd * dL + ffL;
    float U_R = Kp * error_R + Ki * integral_R + Kd * dR + ffR;

    // ================== PWM ADAPTIVE ==================
    int pwm_L = computeAdaptivePWM(U_L, error_L, error_R);
    int pwm_R = computeAdaptivePWM(U_R, error_R, error_L);

    driveMotorLeft(U_L, pwm_L);
    driveMotorRight(U_R, pwm_R);

    last_error_L = error_L;
    last_error_R = error_R;
    prevRefL = refL;
    prevRefR = refR;

    // ================== DEBUG ==================
    if (now - lastPrintTime > 50) {
      lastPrintTime = now;

      bool turning  = abs(error_L - error_R) > turnDiffThreshold;
      bool climbing = (abs(error_L) > climbErrThreshold && abs(error_R) > climbErrThreshold);

      Serial.print("k:");
      Serial.print(k);
      Serial.print(", refL:");
      Serial.print(refL);
      Serial.print(", posL:");
      Serial.print(posL);
      Serial.print(", refR:");
      Serial.print(refR);
      Serial.print(", posR:");
      Serial.print(posR);
      Serial.print(", eL:");
      Serial.print(error_L);
      Serial.print(", eR:");
      Serial.print(error_R);
      Serial.print(", ffL:");
      Serial.print(ffL);
      Serial.print(", ffR:");
      Serial.print(ffR);
      Serial.print(", pwmL:");
      Serial.print(pwm_L);
      Serial.print(", pwmR:");
      Serial.print(pwm_R);
      Serial.print(", turn:");
      Serial.print(turning ? 1 : 0);
      Serial.print(", climb:");
      Serial.println(climbing ? 1 : 0);
    }

    // ================== STEP INDEX ==================
    // jangan pakai 2.0 dulu
    kFloat += kStep;
  }

  // =====================================================================
  void startTrajectory() {
    noInterrupts();
    encoder0Pos = 0;
    encoder1Pos = 0;
    interrupts();

    integral_L = 0;
    integral_R = 0;
    last_error_L = 0;
    last_error_R = 0;

    prevRefL = 0;
    prevRefR = 0;

    lastDirL = 0;
    lastDirR = 0;

    kFloat = (float)startIndexOffset;
    k = startIndexOffset;

    started = true;
    finished = false;

    stopAllMotors();

    digitalWrite(DIR_KIRI, HIGH);
    digitalWrite(DIR_KANAN, LOW);
    delay(10);

    Serial.print("START from index ");
    Serial.println(k);
  }

  // =====================================================================
  int computeAdaptivePWM(float u, float errSelf, float errOther) {
    int pwm = (int)abs(u);

    bool turning  = abs(errSelf - errOther) > turnDiffThreshold;
    bool climbing = (abs(errSelf) > climbErrThreshold && abs(errOther) > climbErrThreshold);

    int localMinPWM = minPWM;

    if (turning)  localMinPWM = turnMinPWM;
    if (climbing) localMinPWM = climbMinPWM;

    if (pwm > pwmLimit) pwm = pwmLimit;
    if (pwm < localMinPWM) pwm = localMinPWM;

    return pwm;
  }

  // =====================================================================
  void doEncoderLeft() {
    if (digitalRead(encoder0PinA) == digitalRead(encoder0PinB)) encoder0Pos--;
    else encoder0Pos++;
  }

  void doEncoderRight() {
    if (digitalRead(encoder1PinA) == digitalRead(encoder1PinB)) encoder1Pos++;
    else encoder1Pos--;
  }

  // =====================================================================
  void stopAllMotors() {
    analogWrite(PWM_KIRI, 0);
    analogWrite(PWM_KANAN, 0);
  }

  // =====================================================================
  void driveMotorLeft(float u, int pwm) {
    int dir = (u >= 0) ? 1 : -1;

    if (dir != lastDirL) {
      analogWrite(PWM_KIRI, 0);
      digitalWrite(DIR_KIRI, (dir > 0) ? HIGH : LOW);
      delay(3);
      lastDirL = dir;
    }

    analogWrite(PWM_KIRI, pwm);
  }

  // =====================================================================
  void driveMotorRight(float u, int pwm) {
    int dir = (u >= 0) ? 1 : -1;

    if (dir != lastDirR) {
      analogWrite(PWM_KANAN, 0);
      digitalWrite(DIR_KANAN, (dir > 0) ? LOW : HIGH);
      delay(3);
      lastDirR = dir;
    }

    analogWrite(PWM_KANAN, pwm);
  }
