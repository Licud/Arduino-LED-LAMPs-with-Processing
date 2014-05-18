#include <DmxSimple.h>
int value = 0;
int channel;
int c;
void setup() {
  Serial.begin(9600);
}
void loop() {
while(!Serial.available());
  c = Serial.read();
  if ((c>='0') && (c<='9')) {
    value = 10*value + (c - '0');
  } else {
    if (c=='c') channel = value;
    else if (c=='w') {
      DmxSimple.write(channel, value);
      Serial.println();
    }
    value = 0;
  }
}
