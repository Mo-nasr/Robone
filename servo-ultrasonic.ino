
#include <Servo.h> 
#define trig 13
#define echo 12

Servo myservo; 
int pos = 1;
long duration, distance=0;
int st=0;

void setup() 
{ 
  pinMode(trig,OUTPUT);
  pinMode(echo,INPUT);
  Serial.begin(9600);
  myservo.attach(9); 
 } 
 
 
void loop() 
{ 

 if (pos == 1)
   st = 0;
    
 if (pos == 180)
  st = 1;
    
 if (st==0)
  pos = pos+1;
    
 if (st==1)
      pos = pos-1;
         
  myservo.write(pos);
  
  get_ultrasonic(); //get ultrasonic readings  
  
  Serial.print(pos); Serial.print(" "); 
  Serial.println(distance);
  delay(30);
  
}


void get_ultrasonic()
{
   digitalWrite(trig, LOW);  
   delayMicroseconds(2); 
   digitalWrite(trig, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trig, LOW);
   duration = pulseIn(echo, HIGH);
   // convert the time into a distance
   distance = (duration/2) / 29.1; 
  if (distance>400)
  {
    distance = 400;
  }
}



