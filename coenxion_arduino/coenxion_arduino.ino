char val;

int led = 13;
//A
int btn1A = 12;
//right
int btn2R = 10;
//down
int btn5D = 9;
//up
int btn4U = 8;
//left
int btn3L = 7;
int motor = 11;

int btn1AState = 0;
int btn2RState = 0;
int btn5DState = 0;
int btn4UState = 0;
int btn3LState = 0;


void setup() {
  Serial.begin(9600);
  pinMode(btn1A, INPUT);
  pinMode(btn2R, INPUT);
  pinMode(btn5D, INPUT);
  pinMode(btn4U, INPUT);
  pinMode(btn3L, INPUT);
  pinMode(led, OUTPUT);
  pinMode(motor, OUTPUT);

}

void loop() {

  btn1AState = digitalRead(btn1A);
  btn2RState = digitalRead(btn2R);
  btn5DState = digitalRead(btn5D);
  btn4UState = digitalRead(btn4U);
  btn3LState = digitalRead(btn3L);

  if (btn2RState == HIGH ) {
    Serial.print(2);

  }
  else if (btn3LState == HIGH ) {
    Serial.print(3);

  } else if ( btn4UState == HIGH ) {
    Serial.print(4);


  } else if (btn5DState) {
    Serial.print(5);

  }
  else if (btn1AState == HIGH) {
    Serial.print(1);

  } else {
    Serial.print(0);
    //analogWrite(motor, 0);
    // digitalWrite(led, LOW);
  }
  if (Serial.available ( )) {   // Checking if the Processing IDE has send a value or not
    val = Serial.read();
  }

   if (val == '2') {
    analogWrite(motor, 200);
    delay(200);
  } else {
    analogWrite(motor, 0);
  }
  //----------------------

  if (val == '1') {
    digitalWrite(led, HIGH);
        
  } else {
    digitalWrite(led, LOW);
  }
}
