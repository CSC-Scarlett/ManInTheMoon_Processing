import processing.sound.*; // sound library import

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// Global Variables ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Scene control
float scene = -1;
float sceneNum = 0;

//aesthetics :)))))))))))))))))))))))))))))))))))))))))000
PFont subtitle;

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
boolean clicked1 = false;
boolean clicked2 = false;
boolean clicked3 = false;
boolean clickedT1 = false;
boolean clickedT2 = false;
boolean text2half = false;

// Game Mechanics
float timer = 0;
boolean clock = false;
boolean inSchool = false;
boolean paused = false;
boolean sceneChange = false;
boolean goodEnd = false;
boolean badEnd1 = false; // Death from monster
boolean badEnd2 = false; // Death from lights
boolean light = true;

 // Monster sprite (only one design)
 PImage monster; // current monster frame
 PImage monWalk[] = new PImage[4];

// Scene animation
int frontX = 0;
int backX = 0;
int relativeX;
int transparency = 0;

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

//Pause menu
PImage pause;
PImage pause_S;
PImage black;
PImage PM;
PImage PM_Return;
PImage PM_Instructions;
PImage PM_Settings;

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
  
  subtitle = createFont("Arial Narrow", 25);

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
  
  // Monster Animation
  monWalk[0] = loadImage("TEMP_Settings.png");
  monWalk[1] = loadImage("TEMP_Dev.png");
  
  monWalk[2] = loadImage("TEMP_Settings.png");
  monWalk[3] = loadImage("TEMP_Dev.png");
  
  monster = monWalk[0];
  
  pause = loadImage("Pause.PNG");
  black = loadImage("black.PNG");
  PM = loadImage("PM.PNG");
  PM_Return = loadImage("PM_Return.PNG");
  PM_Instructions = loadImage("PM_Instructions.PNG");
  PM_Settings = loadImage("PM_Settings.PNG");

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
  X_Fore = loadImage("X_FORE.png");
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
  relativeX = abs(frontX) + mouseX;
  
  textFont(subtitle);
  textSize(25);
  fill(245, 202, 122);
  //////////////////////////////////////////////// scene -1 ////////////////////////////////////////////////
  if (scene == -1) { // start screen
    //text("ur mom", 200, 200);
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
    sceneNum = 1;
    if (relativeX >= 1955 && relativeX <= 2085 && mouseY >= 465 && mouseY <= 610){
      B_Fore = loadImage("B_FORE_Garbage.PNG");
      text("garbage", (relativeX-frontX), 440);
    } else if (relativeX >= 2090 && relativeX <= 2235 && mouseY >= 240 && mouseY <= 610){
      B_Fore = loadImage("B_FORE_Sign.PNG");
    } else if (relativeX >= 2260 && relativeX <= 2615 && mouseY >= 450 && mouseY <= 610){
      B_Fore = loadImage("B_FORE_Bench.PNG");
    } else
      B_Fore = loadImage("B_FORE1.png");
    display(B_Fore, B_Back, 3020, 2006);
    if (clicked1 == true){
       timer += 0.1;
       text("you", 250, 740);
       if (timer >= 3){
         timer = 0;
         clicked1 = false;
       }
     }
     if (clicked2 == true) {
       timer += 0.1;
       text("wait for the bus!", 250, 740);
       if (timer >= 5) {
         timer = 0;
         clicked2 = false;
       }
     }
     if (clicked3 == true) {
       timer += 0.1;
       text("you're now waiting!", 250, 740);
       if (timer >= 5) {
         timer = -0.5;
         clicked3 = false;
         clickedT1 = true;
       }
     }
     if (clickedT1 == true) {
       timer += 0.1;
       text("the bus is here!", 250, 740);
       if (timer >= 4) {
         timer = -0.5;
         clickedT1 = false;
         clickedT2 = true;
       }
     }
     if (clickedT2 == true) {
       timer += 0.1;
       text("it looks a bit strange though...", 250, 740);
       if (timer >= 4) {
         timer = -0.5;
         clickedT2 = false;
         text2half = true;
         scene = 2.5;
         backX = 0;
         frontX = 0;
         locationX = 50;
       }
     } 
  }//end scene 1
//////////////////////////////////////////////// school 1 ////////////////////////////////////////////////
  else if (scene == 2) {
    sceneNum = 2;
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
  }//end scene 2
  //////////////////////////////////////////////// xanadu1 ////////////////////////////////////////////////
  else if (scene == 2.5) { 
    sceneNum = 2.5;
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    display(X1, black, 3222, 2000);
    if (text2half == true) {
      text("oh no! where are you?", 240, 740);
      if (scene == 3) {
        text2half = false;
      }
    }
  }
  //////////////////////////////////////////////// xanadu ////////////////////////////////////////////////
  else if (scene == 3) { 
    sceneNum = 3;
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    display(X_Fore, X_Back, 4330, 2454);
    timer += 0.1;
    if (light) {
      light(4330);
      /* if (relativeX >= 1498 && relativeX <= 1714) {
        scene = 5;
      } */
    }
  }
  /////////////////////////////////////////////// end1 /////////////////////////////////////////////////
  else if (scene == 4) { // good end (you escape!)
    
  } 
  /////////////////////////////////////////////// end2 /////////////////////////////////////////////////
  else if (scene == 5) { // bad end (you died O_O)
    text();
  }
}



void mousePressed() {
  println(mouseX + " " + mouseY);
  println(relativeX + " " + mouseY); 
  
  if (scene == 3) {
    println(relativeX);
    println(frontX);
  }

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
      scene = sceneNum;
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
      scene = 5;
  }
  if (scene >= 1){
    if (mouseX >= 20 && mouseX <= 90 && mouseY >= 20 && mouseY <= 90){ //pause button
      paused = !paused;
    }
  }
  
  if (scene == 1){
    if (relativeX >= 1955 && relativeX <= 2085 && mouseY >= 465 && mouseY <= 610)
      clicked1 = true;
    else if (relativeX >= 2090 && relativeX <= 2235 && mouseY >= 240 && mouseY <= 610)
      clicked2 = true;
    else if (relativeX >= 2260 && relativeX <= 2615 && mouseY >= 450 && mouseY <= 610)
      clicked3 = true;
  }
  
  if (scene == 2.5) {
    if (mouseX >= 417 && mouseX <= 660 && mouseY >= 160 && mouseY <= 610) {
      scene = 3;
      locationX = 50;
      backX = 0;
      frontX = 0;
    }
  }
  
  if (paused) {
    if (mouseX >= 235 && mouseX <= 545){
      if (mouseY >= 195 && mouseY <= 285){
        scene = 0;
        backX = 0;
        frontX = 0;
        locationX = 50;
        paused = false;
      }
      else if (mouseY >= 320 && mouseY <= 410)
        scene = -3;
      else if (mouseY >= 440 && mouseY <= 535)
        scene = -2;
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
    if (mouseX >= 235 && mouseX <= 545){
      if (mouseY >= 195 && mouseY <= 285)
        image(PM_Return, 0, 0, 800, 800);
      else if (mouseY >= 320 && mouseY <= 410)
        image(PM_Instructions, 0, 0, 800, 800);
      else if (mouseY >= 440 && mouseY <= 535)
        image(PM_Settings, 0, 0, 800, 800);
      else
        image(PM, 0, 0, 800, 800);
    }
    else
      image(PM, 0, 0, 800, 800);
  }
  image(pause, 20, 20, 70, 70);
} //end display





void light(int foreLength) {
  boolean NL1 = false;
  boolean NL2 = false;
  boolean ML1 = false;
  boolean ML2 = false;
  
  float random1 = random(1,10);
  if (random1 <= 5) {
    NL1 = true;
  }
  
  int lights[] = {0, 1, 2, 3, 4, 5};
  int random = (int)random(lights.length);
  println(lights[random]);
  
  if (lights[random] <= 1) {
    ML2 = true;
  } else if (lights[random] > 1 && lights[random] <= 3) {
    NL2 = true;
  }
  
  if (NL1) 
    image(NL_1, frontX, 0, foreLength, 800);
  if (NL2) 
    image(NL_2, frontX, 0, foreLength, 800);
  if (ML1) 
    image(ML_1, frontX, 0, foreLength, 800);
  if (ML2) 
    image(ML_2, frontX, 0, foreLength, 800);
     
  
  /* float light1 = random(1, 10);
  if (light1 >= 5)
    image(NL_1, 0, 0);
  else 
    image(NL_2, 0, 0);
       
  float light2 = random(1, 10);
  if (light2 >= 5)
    image(ML_1, 0, 0);
  else 
    image(ML_2, 0, 0); */
    
} //end light

void text() {
  float textNum = random(1,5);
  background(0);
  if (textNum <= 1) {
    text("found you.", 400, 400);
    println("1");
  } else if (textNum <= 2 && textNum > 1) {
    text("he saw you", 400, 400);
    println("2");
  } else if (textNum <= 3 && textNum > 2) {
    text("i see you.", 400, 400);
    println("3");
  } else if (textNum <= 4 && textNum > 3) {
    text("you can't hide", 400, 400);
    println("4");
  } else if (textNum <= 5 && textNum > 4) {
    text("run.", 400, 400);
    println("5");
  }
  noLoop();
  
}



void transition(){
  image(black, 0, 0, 800, 800);
  if (transparency < 255)
    transparency += 5;
  else if (transparency == 255){
    scene++;
    
  }
    /*if (transition == true) {
      image(black, 0, 0);
      tint(255, transparency);
      do {
        transparency += 5;
        println(transparency);
      } while (transparency<=255);
      load = true;
      do {
        transparency -= 5;
      } while (transparency>=0);
      transition = false;
    }*/
  } //end transition
