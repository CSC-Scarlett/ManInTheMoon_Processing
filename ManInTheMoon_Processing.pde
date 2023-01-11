import processing.sound.*; // sound library import

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// Global Variables ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Scene control
float scene = -1;


// Chang'e animation sprites
PImage character; //current Chang'e frame
PImage charWalk[] = new PImage[8]; //0 and 4 stationary, 0-3 right facing, 4-7 left facing
// PImage charCrouch[] = new PImage[4];
// PImage charJump[] = new PImage[];


//movement control
int locationX = 50;
int locationY = 400;
int speedY = 0;
int frame = 0;
boolean jumping = false;
boolean crouching = false;
boolean move = false;
boolean bully = false;
boolean facingRight = true;

// Game Mechanics
float timer = 0;
boolean clock = false;
boolean inSchool = false;
boolean paused = false;
boolean sceneChange = false;
/*

 // Monster sprite (only one design)
 PImage mon; // current monster frame
 //PImage monWalk[] = new PImage[8]; */

// Scene animation
int frontX = 0;
int backX = 0;
int relativeX;

// Backgrounds
PImage OS;
PImage OS_Start;
PImage OS_Settings;
PImage OS_Instruct;
PImage OS_Dev;

PImage startWhite;
PImage startGlow;

PImage Back;
PImage Back_S;

PImage Instructions;
PImage Settings;
PImage Dev;
PImage Dev_Start;
PImage Dev_S1;
PImage Dev_S2;
PImage Dev_S3;
PImage Dev_End;

PImage pause;
PImage black;

PImage B_Fore; 
PImage B_Back;
PImage S_Fore;
PImage S_Back;
PImage H_Fore;
PImage H_Back;
PImage X1;
PImage X_Back;
PImage X_Fore;

/*
// Props
 PImage note;
 PImage bus;
 PImage door1;
 PImage door2;
 */
PImage clock1;
PImage clock2;
PImage clock3;
PImage NL_1; // nightlight (purple light, okay to walk through; will kill monster)
PImage NL_2;
PImage ML_1; // moonlight (not okay to walk through; will kill monster and also YOU)
PImage ML_2;

// Music
boolean play1 = false;
SoundFile OS_Music;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// Prelims /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(800, 800); //my fav line of code #2
  background(255);

  frameRate(1000);

  // Start screen
  startWhite = loadImage("START_White.png");
  startGlow = loadImage("START_Glow.png");

  // Opening screen
  OS = loadImage("OS.PNG");
  OS_Start = loadImage("OS_Start.PNG");
  OS_Settings = loadImage("OS_Settings.PNG");
  OS_Instruct = loadImage("OS_Instruct.PNG");
  OS_Dev = loadImage("OS_Dev.PNG");
  OS_Music = new SoundFile(this, "ElevatorMusic.wav");

  Back = loadImage("BACK_white.png");
  Back_S = loadImage("BACK_Red.png");

  Instructions = loadImage("Instructions.png");

  Settings = loadImage("Settings.png");

  Dev = loadImage("DEV.png");
  Dev_Start = loadImage("DEV_Start.png");
  Dev_S1 = loadImage("DEV_S1.png");
  Dev_S2 = loadImage("DEV_S2.png");
  Dev_S3 = loadImage("DEV_S3.png");
  Dev_End = loadImage("DEV_End.png");

  // Character Animation
  charWalk[0] = loadImage("CHAR_walk1R.PNG");
  charWalk[1] = loadImage("CHAR_walk2R.PNG");
  charWalk[2] = loadImage("CHAR_walk3R.PNG");
  charWalk[3] = loadImage("CHAR_walk4R.PNG");

  charWalk[4] = loadImage("CHAR_walk1L.png");
  charWalk[5] = loadImage("CHAR_walk2L.png");
  charWalk[6] = loadImage("CHAR_walk3L.png");
  charWalk[7] = loadImage("CHAR_walk4L.png");

  character = charWalk[0];
  
  pause = loadImage("Pause.PNG");
  black = loadImage("black.PNG");

  // Bus stop + school cameo\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  B_Back = loadImage("B_BACK.PNG");
  B_Fore = loadImage("B_FORE1.png");

  // School
  S_Back = loadImage("TEMP_School.png");
  S_Fore = loadImage("TEMP_School.png");
  H_Back = loadImage("TEMP_Hallway.png");
  H_Fore = loadImage("TEMP_Hallway.png");
  
  clock1 = loadImage("clock full.png");
  clock2 = loadImage("TEMP_Settings.png");
  clock3 = loadImage("TEMP_Settings.png");

  // Xanadu
  X1 = loadImage("hallway door alone.png");
  X_Back = loadImage("X_BACK.png");
  X_Fore = loadImage("X_FORE.PNG");
  NL_1 = loadImage("nightlight1.PNG");
  NL_2 = loadImage("nightlight2.PNG");
  ML_1 = loadImage("moonlight1.PNG");
  ML_2 = loadImage("moonlight2.PNG");

  /* if (play1 == true) {
    OS_Music.loop();
    play1 = false;
  } */
} //end setup

/* if (game == true) {
 if (v <= 1 && v>0) {
 lobbyMusic.amp(v);
 v -= 0.1;
 } if (v <= 0) {
 lobbyMusic.stop();
 v = 1.0;
 gameMusic.amp(v);
 gameMusic.loop();
 //}
 game = false;
 }
 if (game == false && lobby == false) {
 if (v<= 1 && v>0) {
 gameMusic.amp(v);
 v -= 0.1;
 } else if (v <= 0) {
 gameMusic.stop();
 v = 1.0;
 }
 }
 
 if (gameStop == true) {
 if (v>0 && v <= 1.0) {
 gameMusic.amp(v);
 v -= 0.01;
 }
 if (v <= 0.0) {
 gameMusic.stop();
 gameStop = false;
 }
 }*/


void draw() {
  play1 = true;
  if (play1) {
    OS_Music.play();
    OS_Music.loop();
    play1 = false;
  }
  relativeX = abs(frontX) + locationX;
  //////////////////////////////////////////////// scene -1 ////////////////////////////////////////////////
  if (scene == -1) { // start screen
    if (mouseX >= 540 && mouseX <= 730 && mouseY >= 650 && mouseY <= 730)
      image(startGlow, 0, 0, 800, 800);
    else
    image(startWhite, 0, 0, 800, 800);
  }
  //////////////////////////////////////////////// scene 0 ////////////////////////////////////////////////
  else if (scene == 0) { // OS screen
    if (mouseX >= 475 && mouseX <= 530 && mouseY >= 275 && mouseY <= 305)
      image(OS_Start, 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 550 && mouseY >= 310 && mouseY <= 345)
      image(OS_Settings, 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 580 && mouseY >= 360 && mouseY <= 390)
      image(OS_Instruct, 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 565 && mouseY >= 395 && mouseY <= 425)
      image(OS_Dev, 0, 0, 800, 800);
    else
      image(OS, 0, 0, 800, 800);
  }
  //////////////////////////////////////////////// scene -2 ////////////////////////////////////////////////
  else if (scene == -2) { // game settings
    image(Settings, 0, 0, 800, 800);
    image(Back, 0, 0, 800, 800);
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      image(Back_S, 0, 0, 800, 800);
    else
    image(Back, 0, 0, 800, 800);
  }
  //////////////////////////////////////////////// scene -3 ////////////////////////////////////////////////
  else if (scene == -3) { // instructions
     image(Instructions, 0, 0, 800, 800);
     image(Back, 0, 0, 800, 800);
     if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
       image(Back_S, 0, 0, 800, 800);
     else
       image(Back, 0, 0, 800, 800);
  }
  //////////////////////////////////////////////// scene -4 ////////////////////////////////////////////////
  else if (scene == -4) { // Dev menu
    image(Dev, 0, 0, 800, 800);
    if (mouseX >= 130 && mouseX <= 335 && mouseY >= 210 && mouseY <= 280)
      image(Dev_Start, 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 295 && mouseY <= 355)
      image(Dev_S1, 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 375 && mouseY <= 435)
      image(Dev_S2, 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 450 && mouseY <= 510)
      image(Dev_S3, 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 540 && mouseY <= 600)
      image(Dev_End, 0, 0, 800, 800);
    else
      image(Dev, 0, 0, 800, 800);
  
    image(Back, 0, 0, 800, 800);
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      image(Back_S, 0, 0, 800, 800);
    else
      image(Back, 0, 0, 800, 800);
  }
  /////////////////////////////////////////////// bus stop /////////////////////////////////////////////////
  else if (scene == 1) {
    if (relativeX >= 2060 && relativeX <= 2400)
      B_Fore = loadImage("B_FORE_Bench.PNG");
    if (relativeX >= 1770 && relativeX <=1890)
      B_Fore = loadImage("B_FORE_Garbage.PNG");
    if (relativeX >= 1895 && relativeX <= 2050)
      B_Fore = loadImage("B_FORE_Sign.PNG");
    else
      B_Fore = loadImage("B_FORE1.png");
    display(B_Fore, B_Back, 3020, 2004);
  }
//////////////////////////////////////////////// school 1 ////////////////////////////////////////////////
  else if (scene == 2) {
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    if (!inSchool)
      display(S_Fore, S_Back, 2500, 2500);
    else{
      display(H_Fore, H_Back, 2500, 2500);
      while (clock) {
        timer = timer + 0.001;
        if (timer == 1)
          image(clock1, 0, 0, 800, 800);
        if (timer == 2)
          image(clock2, 0, 0, 800, 800);
        if (timer == 3)
          image(clock3, 0, 0, 800, 800);
        if (timer == 3.5) {
          clock = false;
          break;
        }
      } //end while
    }// end else
    sceneChange = false;
  }
  //////////////////////////////////////////////// xanadu1 ////////////////////////////////////////////////
  else if (scene == 2.5) {
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    display(X1, black, 3222, 2000);
  }
  //////////////////////////////////////////////// xanadu ////////////////////////////////////////////////
  else if (scene == 3) {
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    display(X_Fore, X_Back, 4330, 2454);
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////
  else if (scene == 4) {
   
  } 
}


void mousePressed() {
  println(mouseX + " " + mouseY);

  if (scene == 0) {
    if (mouseX >= 475 && mouseX <= 530 && mouseY >= 275 && mouseY <= 305) //Start
      scene = 1;
    else if (mouseX >= 475 && mouseX <= 550 && mouseY >= 310 && mouseY <= 345) // Settings
      scene = -2;
    else if (mouseX >= 475 && mouseX <= 580 && mouseY >= 360 && mouseY <= 390) // Instructions
      scene = -3;
    else if (mouseX >= 475 && mouseX <= 565 && mouseY >= 395 && mouseY <= 425) // Developer mode
      scene = -4;
  } // end loadingScreen mousePressed

  if (scene == -1) { //start button
    if (mouseX >= 540 && mouseX <= 730 && mouseY >= 650 && mouseY <= 730)
      scene = 0;
  } // end startScreen

  if (scene == -2 || scene == -3 || scene == -4) { //back button
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      scene = 0;
  }

  if (scene == -4) { //Dev menu
    if (mouseX >= 130 && mouseX <= 335 && mouseY >= 210 && mouseY <= 280)
      scene = -1;
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 295 && mouseY <= 355)
      scene = 1;
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 375 && mouseY <= 435)
      scene = 2;
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 450 && mouseY <= 510)
      scene = 3;
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 540 && mouseY <= 600)
      scene = 4;
  }
  if (scene >= 1){
    if (mouseX >= 20 && mouseX <= 90 && mouseY >= 20 && mouseY <= 90){ //pause button
      paused = !paused;
    }
  }
  
  if (scene == 2.5) {
    if (mouseX >= 417 && mouseX <= 660 && mouseY >= 160 && mouseY <= 610) {
      scene = 3;
      locationX = 50;
      backX = 0;
      frontX = 0;
    }
  }
}//end mousePressed


void mouseReleased() {
}//end mouseReleased

void keyPressed() {
  if (!paused){
    if (key == 'd') {
      move = true;
      facingRight = true;
    } else if (key == 'a') {
      move = true;
      facingRight = false;
    } else if (key == ' ' && jumping == false) {
      jumping = true;
      speedY = -40;
      crouching = false;
    } else if (key == 'q') {
      bully = true;
    } else if (key == CODED) {
      if (keyCode == CONTROL) {
        if (jumping == false) {
          crouching = !crouching;
        }
      } // end keyCode
    }
  }
  
  if (key == 'p') {
    scene = 2.5;
  }

  // 'e' key for interaction
  // 'q' key to hit
}//end keyPressed

void keyReleased() {
  frame = 0;
  if (key == 'd' || key == 'a')
    move = false;
}//end keyReleased


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// Movement /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void walking() {
  if (facingRight == true) {
    switch(frame) {
    case 0:
      character = charWalk[0];
      break;
    case 5:
      character = charWalk[1];
      break;
    case 10:
      character = charWalk[2];
      break;
    case 15:
      character = charWalk[3];
      break;
    }
  } else if (facingRight == false) {
    switch(frame) {
    case 0:
      character = charWalk[4];
      break;
    case 5:
      character = charWalk[5];
      break;
    case 10:
      character = charWalk[6];
      break;
    case 15:
      character = charWalk[7];
      break;
    }
  }
}//end walking

/*
void crouching() {
 if (crouching == true) {
 if (facingRight == true) {
 switch(frame) {
 case 0:
 character = character4R;
 break;
 case 10:
 character = character5R;
 break;
 }
 }
 if (facingRight == false) {
 switch(frame) {
 case 0:
 character = character4L;
 break;
 case 10:
 character = character5L;
 break;
 }
 }
 }
 }//end of crouching
 */
void jumping() { //WITH HELP FROM MS. WIEBE CS10 (Modified)
  locationY += speedY;
  if (jumping == true) {
    speedY += 4;
  }
  if (speedY >= 44) {
    speedY = 0;
    locationY = 400;
    jumping = false;
  }
}//end jumping


void moving() {
  if (move == true) {
    if (facingRight == true)
      locationX += 8;
    if (facingRight == false)
      locationX -= 8;
    frame++;
    if (frame == 20 && crouching == false) {
      frame = 5;
    } else if (frame == 20 && crouching == true) {
      frame = 0;
    }
  }
  if (crouching == false)
    walking();
  //crouching();
  jumping();
}//end moving


void bullying() {
} //end bullying! 👨

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// story //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void display(PImage foreground, PImage background, int foreLength, int backLength) {
  //println(relativeX);
  image(background, backX, 0, backLength, 800);
  image(foreground, frontX, 0, foreLength, 800);
  moving();
  image(character, locationX, locationY, 270, 270);
  if (locationX <= -90 && frontX >= 0) { //very very edge left
    locationX = -90;
  } else if (locationX >= 400 && frontX > -(foreLength-800) && move == true) { //fake edge right
    frontX -= 10;
    backX -= 2;
    locationX = 400;
  } else if (locationX <= 235 && frontX < 0 && move == true) { //fake edge left
    frontX += 10;
    backX += 2;
    locationX = 235;
  } else if (locationX >= 620) { //very very edge right
    locationX = 620;
  }
  if (!paused){
    if (mouseX >= 20 && mouseX <= 90 && mouseY >= 20 && mouseY <= 90)
      pause = loadImage("Pause_Glow.PNG");
    else
      pause = loadImage("Pause.PNG");
  }
  if (paused){
    tint(255, 127);
    image(black, 0, 0, 800, 800);
    tint(255, 255);
  }
  image(pause, 20, 20, 70, 70);
}//end display

/* void light(int foreLength, int backLength) {
  float light1 = random(1, 10);
  if (light1 >= 5)
    image(NL_1, 0, 0);
  else 
    image(NL_2, 0, 0);
     
  float light2 = random(1, 10);
  if (light1 >= 5)
    image(ML_1, 0, 0);
  else 
    image(ML_2, 0, 0);
} */
