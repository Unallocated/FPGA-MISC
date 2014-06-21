byte output[] = {30,31,32,33,34,35,36,37,38,39,40,41};
void setup() {
  Serial.begin(115200);
  for(int a = 0; a < 12; a++){
    pinMode(output[a], OUTPUT);
  }
  
  analogReadResolution(10);
}

byte last = 0x00;
double d = 0;
short dataPos = 0;
byte samples = 128;
byte diff = 3;
void loop() {
  d += analogRead(0);
  if(dataPos == samples){
    short fin = (short)(d/dataPos);
    for(int a = 0; a < 12; a++){
      digitalWrite(output[a], fin & (0x001 << a));
    }
    
    Serial.println(fin,HEX);
    dataPos = 0;
    d = 0;
  }else{
    dataPos++;
  }
}
