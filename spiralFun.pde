int degrees;
int style;
int numOfStyles;

void setup(){
  size(1920, 1080); 
  strokeWeight(2);
  degrees = 0;
  style = 0;
  numOfStyles = 6;
}

void spiral(float x, float y, int preset){
  float offset = radians(degrees);
  float R = 0, G = 0, B = 25; 
  float centreX = 1000, centreY = -200;
  float rateChangeR = 0, rateChangeG = 1, rateChangeB = 1;
  float angle = PI/9;
  float tightness = 10;
  float num = 70;
  
  if(preset == 0){
    preset = ((style++)/250)%numOfStyles + 1;   //250 corresponding to amount of delay, 
  }                                    // %numOfStyles to loop back to first style, +1 to make first style 1 instead of 0
  
  if(preset == 1){                      
    degrees++;
  }else if(preset == 2){
    degrees--;
  }else if(preset == 3){
    degrees+=2;
  }else if(preset == 4){
    degrees++;
    B = 0;
    rateChangeR = 1;
    rateChangeG = 0.8;
    rateChangeB = 0;
  }else if(preset == 5){
    degrees++;
    B = 0;
    rateChangeR = 0.7;
    rateChangeG = 0.2;
  }else{
    degrees++;
    centreX = mouseX + 280; //to make it roughly follow your pointer
    centreY = mouseY -500;       //TODO: needs adjusting    
    //Calculate centre based on starting point, then reverse engineer starting point inputs for given desired centre?       
    G = 20;
    B = 0;  
    rateChangeB = 0.2;
    rateChangeG = 0.75;
    rateChangeR = 0.95;
  }
  
  for(int i=0; i<num ; i++){
     fill(R+rateChangeR*((255-R)/num)*i, G+rateChangeG*((255 - G)/num)*i, B+rateChangeB*((255 - B)/num)*i);
     strokeWeight(5-5*(i/num)); //line gets correspondingly narrower as it gets tighter and closer to the centre
     stroke(R+rateChangeR*((255-R)/num*i), G+rateChangeG*((255 - G)/num)*i, B+rateChangeB*((255 - B)/num)*i); 
     //above line is optional/personal preference - makes curved border of each wedge the same colour as its wedge
     myArc(centreX, centreY, angle, x, y, offset);
     float newX = centreX + ((x-centreX)*cos(angle)-(y-centreY)*sin(angle));
     float newY = centreY + ((y-centreY)*cos(angle)+(x-centreX)*sin(angle)); 
     x = newX;
     y = newY;
     centreX = (x + (centreX*tightness))/(tightness+1);
     centreY = (y + (centreY*tightness))/(tightness+1);
  }
}

void myArc(float centreX, float centreY, float angle, float xPos, float yPos, float offset){
  float xDiff = xPos - centreX;
  float yDiff = yPos - centreY;
  float radius = sqrt(xDiff*xDiff + yDiff*yDiff);
  float alpha = atan(yDiff/xDiff) + offset;
  if(xDiff<0){
    alpha += PI;
  }
  
  float beta = alpha + angle;

  arc(centreX, centreY, 2*radius, 2*radius, alpha, beta);
}

void draw(){
  background(0);
  strokeWeight(2);
  spiral(3000, 1000, 0);
  //style parameter 0 reserved for showing a cycle of styles, 
}
