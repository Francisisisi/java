//carrot variables
int numCarrots = 10;
float [] carrotX = new float[numCarrots];
float [] carrotY = new float[numCarrots];
float [] carrotValue = new float[numCarrots];
float [] carrotDist = new float[numCarrots];
boolean [] spicy = new boolean[numCarrots];

//rabbit variables
int rabbitX;
int rabbitY;
int speed = 10;
float winDis = dist(rabbitX, rabbitY, 0, 650);
color rabbitFaceColour = color(255);

//acidRain variables
int numRain = 15;
float [] rainSpeed = new float[numRain];
float [] rainSize = new float[numRain];
float [] xRain = new float[numRain];
float [] yRain = new float[numRain];
float [] rainDist = new float[numRain];
color [] rainColour = new color[numRain];
boolean [] acid = new boolean[numRain];

//Other variables
int livesCount;
int scoreCount;
int state = 1;
boolean runGame;
boolean endScreen;


void setup() {
  size(1200, 700);
  rabbitX = 125;
  rabbitY = 350;
  initialCarrots(numCarrots);
  initialAcidRain(xRain, yRain, numRain);
    
//Initial lives and score
  livesCount = 1;
  scoreCount = 0;  
  
  runGame = true;
  endScreen = false;
}


void draw() {
  if(runGame == true) {
  drawBackground();
  rabbitMovement();
  drawCarrots(carrotX, carrotY);
  drawRabbit(rabbitX, rabbitY);
  carrotCollision();
  drawAcidRain(xRain, yRain, numRain);
  state = pathwayStates(rabbitX, rabbitY);
  pathwayChange((dist(rabbitX, rabbitY, width, 350)), (dist(rabbitX, rabbitY, 0, 450)), (dist(rabbitX, rabbitY, width, 550)));
  }
  
  livesScoreText();  
  winLose();
  
}//draw CCB


void winLose() {
  if(livesCount <= 0) {
    runGame = false; //Disables any background functions
    endScreen = true; //Enables loseScreen to run
    if(endScreen == true) {
      loseScreen();
    }
  }
  winDis = (dist(rabbitX, rabbitY, 0, 650));
  if(winDis < 15) {
    runGame = false; //Disables any background functions
    endScreen = true; //Enables winScreen to run
    if(endScreen == true) {
      winScreen();
    }
  }
}


void initialAcidRain(float[] xRain, float[] yRain, int numRain) { //Populates rain array variables
  for(int i = 0; i < numRain; i++){
    xRain[i] = random(0, 1200);
    yRain[i] = random(-100, 0);
    rainSize[i] = random(25, 40);
    rainSpeed[i] = random(1, 5);
    rainColour[i] = color(random(255), random(255), random(255));
  }
}


void initialCarrots(int numCarrots) {
  for(int i = 0; i < numCarrots; i++){
    carrotValue[i] = random(-6, 5);
    carrotX[i] = (int) random(0, width) + carrotValue[i];
    carrotY[i] = (int) random(300, height) + carrotValue[i];
    if(carrotValue[i] < 0) {
      spicy[i] = true;
    } else {
      spicy[i] = false;
    }
  }
}


void drawBackground(){
 noStroke();
 fill(145, 210, 225);//sky
  rect(0, 0, 1200, 300);
 fill(120, 165, 115);
  rect(0, 300, 1200, 100); //pathway 1
  rect(0, 500, 1200, 100); //pathway 3
 fill(180, 165, 130);
  rect(0, 400, 1200, 100); //pathway 2
  rect(0, 600, 1200, 100); //pathway 4
 fill(255, 225, 0);
  circle(width, 0, 200);
}


void drawCarrots(float[] carrotX, float[] carrotY) {
  for(int i = 0; i < numCarrots; i++) {
    fill(40, 185, 40);
    triangle(carrotX[i] + 25, carrotY[i] + 17, carrotX[i] + 15, carrotY[i] - 30, carrotX[i] + 35, carrotY[i] - 30);
    triangle(carrotX[i] + 25, carrotY[i] + 17, carrotX[i] + 10, carrotY[i] - 20, carrotX[i] + 40, carrotY[i] - 20);
    fill(255, 165, 50);
    quad(carrotX[i], carrotY[i], carrotX[i] + 50, carrotY[i], carrotX[i] + 35, carrotY[i] + 35, carrotX[i] + 15, carrotY[i] + 35);
  }
}


void carrotCollision() {
  for(int i = 0; i < carrotDist.length; i++) {
  carrotDist[i] = dist(rabbitX, rabbitY, carrotX[i], carrotY[i]);
    if(carrotDist[i] < 25) {
      carrotX[i] += 2000;
      if(carrotValue[i] >= 0) {
      scoreCount += abs(carrotValue[i]);
      rabbitFaceColour = color(255, 255, 255);
      } else if(spicy[i] == true && carrotDist[i] < 25) {
        livesCount -= 1;
        rabbitFaceColour = color(255, 0, 0);
      }
    }
  }
}
  

void rabbitMovement() {
  if (keyPressed) {
    //Pathway 1
    if(keyCode == UP && state == 1){  
      if(rabbitY > 310){
        rabbitY -= speed;
      }
    }
    
    if(keyCode == DOWN && state == 1){
      if(rabbitY < 390){
        rabbitY += speed;
      }
    }
    
    if(keyCode == LEFT && state == 1){
      if(rabbitX > 0){
        rabbitX -= speed;
      }
    }
    
    if(keyCode == RIGHT && state == 1){
      if(rabbitX < width){
        rabbitX += speed;
      }
    }
    
    //Pathway 2
    if(keyCode == UP && state == 2){  
      if(rabbitY > 410){
        rabbitY -= speed;
      }
    }
    
    if(keyCode == DOWN && state == 2){
      if(rabbitY < 490){
        rabbitY += speed;
      }
    }
    
    if(keyCode == LEFT && state == 2){
      if(rabbitX > 0){
        rabbitX -= speed;
      }
    }
    
    if(keyCode == RIGHT && state == 2){
      if(rabbitX < width){
        rabbitX += speed;
      }
    }
    
    //Pathway 3 
    if(keyCode == UP && state == 3){  
      if(rabbitY > 510){
        rabbitY -= speed;
      }
    }
    
    if(keyCode == DOWN && state == 3){
      if(rabbitY < 590){
        rabbitY += speed;
      }
    }
    
    if(keyCode == LEFT && state == 3){
      if(rabbitX > 0){
        rabbitX -= speed;
      }
    }
    
    if(keyCode == RIGHT && state == 3){
      if(rabbitX < width){
        rabbitX += speed;
      }
    }
    
    //Pathway 4
    if(keyCode == UP && state == 4){  
      if(rabbitY > 610){
        rabbitY -= speed;
      }
    }
    
    if(keyCode == DOWN && state == 4){
      if(rabbitY < 690){
        rabbitY += speed;
      }
    }
    
    if(keyCode == LEFT && state == 4){
      if(rabbitX > 0){
        rabbitX -= speed;
      }
    }
    
    if(keyCode == RIGHT && state == 4){
      if(rabbitX < width){
        rabbitX += speed;
      }
    }
  }
}


void drawAcidRain(float[] xRain, float[] yRain, int numRain) { //Draws rain using populated rain array variables
  for(int i = 0; i < numRain; i++){
    fill(rainColour[i]);
    ellipse(xRain[i], yRain[i], rainSize[i] - 5, rainSize[i] + 5);
  }
  updateAcidRain(xRain, yRain, numRain);
}



void updateAcidRain(float[] xRain, float[] yRain, int numRain) {
  for(int i = 0; i < numRain; i++) {
    yRain[i] += rainSpeed[i];
    rainDist[i] = dist(xRain[i], yRain[i], rabbitX, rabbitY - 160);
    if(yRain[i] > height){
      yRain[i] = random(-100, 0);
      xRain[i] = random(0, 1200);
    }
    if(rainDist[i] < 20) {
      yRain[i] = random(-100, 0);
      xRain[i] = random(0, 1200);
      acid[i] = true;
        if(acid[i] == true) {
        livesCount -= 1;
        }
    }
  }
}


void livesScoreText(){
textSize(30);
  fill(255);
  text("Score: " + scoreCount, 30, 50); 
  text("Lives: " + livesCount, 30, 80);
}


void winScreen() {
  discoScreen();
  textSize(100);
  fill(255, 255, 0);
  text("You won!", width/2 - 200, height/2 - 75); 
  textSize(30);
  text("Final score: " + scoreCount, width/2 - 90, height/2);
  text("Lives left was: " + livesCount, width/2 - 105, height/2 + 50);
  text("Press r to restart", width/2 - 110, height/2 + 100);
  if(keyPressed && key == 'r') {
    setup();
  }
}


void loseScreen() {
  discoScreen();
  fill(0);
  rectMode(CENTER);
  rect(width/2, height/2, 700, 400);
  textSize(50);
  fill(255, 255, 0);
  text("Out of lives! You lost :(", width/2 - 250, height/2 - 75); 
  textSize(30);
  text("Final score: " + scoreCount, width/2 - 90, height/2);
  text("Lives left was: " + livesCount, width/2 - 105, height/2 + 50);
  text("Press r to restart", width/2 - 110, height/2 + 100);
  if(keyPressed && key == 'r') {
    setup();
  }
}

  
void discoScreen() {
  background(0);
  for(int x = 50; x < width; x += 50){
    for(int y = 50; y < height; y += 50){
      fill(random(255), random(255), random(255));
      rectMode(CENTER);
      square(x, y, 40);
    }
  }
  fill(0);
  rectMode(CENTER);
  rect(width/2, height/2, 700, 400);
}


void drawRabbit(int rabbitX, int rabbitY) {
  //Rabbits ears
  fill(255);
  stroke(0);
  ellipse(rabbitX + 30, rabbitY - 190, 40, 80); //right ear outer
  ellipse(rabbitX - 30, rabbitY - 190, 40, 80); //left ear outer
  fill(247, 184, 184); // pink fill color
  ellipse(rabbitX + 30, rabbitY - 190, 25, 50); //right ear inner
  ellipse(rabbitX - 30, rabbitY - 190, 25, 50); //left ear innter
  
  //rabbits back leg
  fill(255);
  ellipse(rabbitX - 30, rabbitY - 5, 70, 20); //foot
  
  //rabbits back arm
  ellipse(rabbitX, rabbitY - 30, 20, 70); //arm
  ellipse(rabbitX + 6, rabbitY, 30, 20); //foot
 
  //rabbit's tail
  fill(255);
  ellipse(rabbitX - 105, rabbitY - 50, 30, 30);
  
  // rabbit's body
  fill(255);
  ellipse(rabbitX - 45, rabbitY - 50, 120, 90);
  
  //rabbit's head
  fill(rabbitFaceColour);
  ellipse(rabbitX, rabbitY - 130, 80, 100);

  //rabbits whiskers
  line(rabbitX + 5, rabbitY - 110, rabbitX - 30, rabbitY - 100);
  line(rabbitX + 8, rabbitY - 115, rabbitX - 30, rabbitY - 110);
  line(rabbitX + 8, rabbitY - 105, rabbitX - 25, rabbitY - 85);
  line(rabbitX + 40, rabbitY - 110, rabbitX + 60, rabbitY - 100);
  line(rabbitX + 43, rabbitY - 115, rabbitX + 60, rabbitY - 110);
  line(rabbitX + 43, rabbitY - 105, rabbitX + 60, rabbitY - 85);

  // rabbit's eyes
  fill(255); // dark brown fill color
  ellipse(rabbitX + 10, rabbitY - 135, 20, 30); //left eye
  ellipse(rabbitX + 40, rabbitY - 135, 20, 30); //right eye
  fill(62, 45, 31); // white fill color
  ellipse(rabbitX + 13, rabbitY - 135, 10, 20); //left pupil
  ellipse(rabbitX + 43, rabbitY - 135, 10, 20); //right pupil
  
  // rabbit's nose and mouth
  fill(255, 130, 130); // light pink fill color
  ellipse(rabbitX + 25, rabbitY - 110, 20, 14);
  stroke(62, 45, 31); // dark brown stroke color
  strokeWeight(1);
  line(rabbitX + 10, rabbitY -100, rabbitX + 35, rabbitY -100);
  fill(255);
  rect(rabbitX + 13, rabbitY -100, 8, 10);
  rect(rabbitX + 23, rabbitY -100, 8, 10);
  
  //rabbits front leg
  fill(255);
  ellipse(rabbitX - 55, rabbitY, 70, 20); //foot
  ellipse(rabbitX - 70, rabbitY - 35, 80, 75); //thigh

  //rabbits front arm
  ellipse(rabbitX - 6, rabbitY - 30, 20, 70); //arm
  ellipse(rabbitX, rabbitY, 30, 20); //foot
}


int pathwayStates(int rabbitX, int rabbitY) {
  if(rabbitX < width && rabbitX > 0 && rabbitY < 400 && rabbitY > 300){
     state = 1;     
   }else if (rabbitX < width && rabbitX > 0 && rabbitY < 500 && rabbitY > 400){
     state = 2;
   }else if (rabbitX < width && rabbitX > 0 && rabbitY < 600 && rabbitY > 500){
     state = 3;
   }else if (rabbitX < width && rabbitX > 0 && rabbitY < 700 && rabbitY > 600){
     state = 4;
   }
   return state;
}


void pathwayChange(float pathway1Dis, float pathway2Dis, float pathway3Dis) {
  if(pathway1Dis < 15) {
    rabbitY = 450;
    rabbitX = width;
  }
  if(pathway2Dis < 15) {
    rabbitY = 550;
    rabbitX = 0;
  }
  if(pathway3Dis < 15) {
    rabbitY = 650;
    rabbitX = width;
  }
}
