int degrees;
int style;
int numOfStyles;

void setup(){
  size(1920, 1080); 
  strokeWeight(2);
  degrees = 0;
  style = 0;
  numOfStyles = 8;
}

void spiral(float x, float y, int preset){
  float offset = radians(degrees);
  float R = 0, G = 0, B = 25; 
  float centreX = 1000, centreY = -200;  //default values
  //float centreX = 1200, centreY = -20;    //executable 
  float rateChangeR = 0, rateChangeG = 1, rateChangeB = 1;
  float angle = PI/9;
  float tightness = 10;
  float num = 70;
  
  if(preset == 0){
    preset = ((style++)/400)%numOfStyles + 1;   //400 corresponding to amount of delay, 
  }                                    // %numOfStyles to loop back to first style, +1 to make first style 1 instead of 0
  
  if(preset == 1){                      
    degrees++;
  }else if(preset == 2){
    degrees--;
  }else if(preset == 3){
    degrees+=2;
  }else if(preset == 4){
    degrees+=4;
  }else if(preset == 5){
    degrees+=2;
    B = 0;
    rateChangeR = 1;
    rateChangeG = 0.8;
    rateChangeB = 0;
  }else if(preset == 6){
    degrees++;
    B = 0;
    rateChangeR = 0.7;
    rateChangeG = 0.2;
  }else if(preset == 7){
    degrees++;
    R = 255;
    B = 0;
    float eachTransition = num/4;  //divisor can be changed to 5 to end at magenta or 6 to loop back to red.
    float colourInc = 255/eachTransition;
    rateChangeB = 0;
    rateChangeG = colourInc;
    
    for(int i=0; i<num ; i++){
      
      System.out.println(i);
      
      if(i>=eachTransition*5){
        rateChangeR = 0;
        rateChangeG = -colourInc;
      }else if(i>=eachTransition*4){
        rateChangeG = 0;
        rateChangeR = colourInc;
      }else if(i>=eachTransition*3){
        rateChangeB = 0;
        rateChangeG = -colourInc;
      }else if(i>=eachTransition*2){
        rateChangeR = 0;
        rateChangeB = colourInc;
      }else if(i>=eachTransition){
        rateChangeG = 0;
        rateChangeR = -colourInc;
      }

     fill((R+=rateChangeR)*0.85, (G+=rateChangeG)*0.85, (B+=rateChangeB)*0.85); //was a little too bright without the *0.85 modifier
     strokeWeight(5-5*(i/num)); //line gets correspondingly narrower as it gets tighter and closer to the centre
     stroke(R*0.95, G*0.95, B*0.95);   
     myArc(centreX, centreY, angle, x, y, offset);
     float newX = centreX + ((x-centreX)*cos(angle)-(y-centreY)*sin(angle));
     float newY = centreY + ((y-centreY)*cos(angle)+(x-centreX)*sin(angle)); 
     x = newX;
     y = newY;
     centreX = (x + (centreX*tightness))/(tightness+1);
     centreY = (y + (centreY*tightness))/(tightness+1);
     }
  }else{
    degrees++;
    centreX = mouseX + 280; //to make it roughly follow your pointer
    centreY = mouseY -500;       //TODO: needs adjusting    
    //Calculate centre based on starting point, then reverse engineer starting point inputs for given desired centre?       
    G = 20;
    B = 0;  
    rateChangeB = 0.3;
    rateChangeG = 0.75;
    rateChangeR = 0.95;
  }
  
  if (preset != 7){
  
  //float prev = 0;
  
  float oldR = R, oldG = G, oldB = B;

  //refactor?

  for(int i=0; i<num ; i++){
     //fill(R+rateChangeR*((255-R)/num*i), G+rateChangeG*((255 - G)/num*i), B+rateChangeB*((255 - B)/num)*i); 
     fill(R+=rateChangeR*(255/num), G+=rateChangeG*(255/num), B+=rateChangeB*(255/num));
     //System.out.println(G);
     //System.out.println(G-prev);
     //System.out.println(oldG+rateChangeG*((255 - 0)/num)*i);
     //prev = G;

     strokeWeight(5-5*(i/num)); //line gets correspondingly narrower as it gets tighter and closer to the centre
     stroke(oldR+rateChangeR*((255-0)/num*i), oldG+rateChangeG*((255 - 0)/num*i), oldB+rateChangeB*((255 - 0)/num)*i); 
     //above line is optional/personal preference - makes curved border of each wedge the same colour as its wedge
     myArc(centreX, centreY, angle, x, y, offset);
     float newX = centreX + ((x-centreX)*cos(angle)-(y-centreY)*sin(angle));
     float newY = centreY + ((y-centreY)*cos(angle)+(x-centreX)*sin(angle)); 
     x = newX;
     y = newY;
     //Combine and replace the above 4 lines into the 2 below for elliptical weirdness
     // x = centreX + ((x-centreX)*cos(angle)-(y-centreY)*sin(angle));
     // y = centreY + ((y-centreY)*cos(angle)+(x-centreX)*sin(angle)); 
     centreX = (x + (centreX*tightness))/(tightness+1);
     centreY = (y + (centreY*tightness))/(tightness+1);
    }
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
  
  //centred for default window:
  spiral(3000, 1000, 7);
  
  //centred for 1920x1080 fullscreen executable application
  //spiral(3200, 1180, 0);
  //whichever one you're using, 
  //make sure you have the corresponding centreX centreY values in spiral
  
  //style parameter 0 reserved for showing a cycle of styles, 
}
