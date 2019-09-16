int degrees = 0;

void setup(){
  size(1920, 1080); 
  strokeWeight(2);
  //spiral(mouseX, mouseY, 0);
}

void spiral(float x, float y, float offset){
  float centreX = 1000;    //mouseX + 121.5
  float centreY = -200;       //mouseY - 85
  float R = 0;
  float G = 0;
  float B = 25;
  float angle = PI/9;
  float tightness = 10;
  float num = 70;
  for(int i=0; i<num ; i++){
     fill(R, G+((255 - G)/(num))*i, B+(3/3)*((255 - B)/(num))*i);
     strokeWeight(5-5*(i/num));
     stroke(R, G+((255 - G)/(num))*i, B+(3/3)*((255 - B)/(num))*i); //optionoal
     myArc(centreX, centreY, angle, x, y, offset);
     float newX = centreX + ((x-centreX)*cos(angle)-(y-centreY)*sin(angle));
     float newY = centreY + ((y-centreY)*cos(angle)+(x-centreX)*sin(angle)); 
     //print("\n" + newX + ", " + newY);
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
  //noFill();
  //translate(width/2, height/2);
  //rotate(PI/3);
  spiral(3000, 1000, radians(degrees++));
  //translate(-width/2, -height/2);
  //print("\n" + degrees);
}
