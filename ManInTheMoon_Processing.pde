import processing.sound.*; // sound library import

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// Global Variables ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Scene control
float scene = -1;
float sceneNum = 0;
float loadScene = -1;

// Aesthetics
PFont subtitle;
PImage black;

// Chang'e animation sprites
PImage character; //current Chang'e frame
PImage charWalk[] = new PImage[8]; //0 and 4 stationary, 0-3 right facing, 4-7 left facing

// Monster sprite (only one design)
PImage monster; // current monster frame
PImage monWalk[] = new PImage[4]; //0-1 right facing, 1-2 left facing

// Sprite control
boolean jumping = false;
boolean move = false;
//boolean bully = false;
boolean facingRight = true;
int locationX = 50;
int locationY = 400;
int speedY = 0;
int frame = 0;
int char_relativeX; //Chang'e
int monLocationY = -300;
int mon_relativeX = 0;
int monFrame;

// Environment animation
boolean text2half = false;
boolean clicked[] = {false, false, false, false, false};
int frontX = 0;
int backX = 0;
int transparency = 0;
int M_relativeX; //mouse

// Game logic
float timer = 0;
float timerlight = 0;
boolean clock = false;
boolean inSchool = false;
boolean paused = false;
boolean sceneChange = false;
boolean ending[] = {false, false, false}; //0 is good ending, 1 is death from monster, 2 is death from lights
boolean light = true;
boolean fadeIn = false;
boolean randomizeText = false;

// Backgrounds
PImage OS[] = new PImage[6]; //opening screen
/*
0: neutral
1: Start
2: Settings
3: Instructions
4: Developer
5: Quit
*/

PImage Dev[] = new PImage[6]; //developer menu
/*
0: neutral
1: START
2: Scene 1 (bus stop)
3: Scene 2 (school WIP)
4: Scene 3 (xanadu)
5: END
*/

PImage PM[] = new PImage[4]; //pause menu
/*
0: neutral
1: Return to menu
2: Instructions
3: Settings
*/

PImage fore[] = new PImage[5]; //foreground
PImage back[] = new PImage[5]; //background
/*
0: bus stop
1: school
2: school hallway
3: dark hallway
4: xanadu
*/

PImage lights[] = new PImage[4];
/*
0: nightlight 1 (purple light, okay to walk through; will kill monster)
1: nightlight 2
2: moonlight 1 (not okay to walk through; will kill monster and also YOU)
3: moonlight 2
*/

PImage startWhite;
PImage startGlow;

PImage Back;
PImage Back_S;

PImage pause;
PImage pause_S;

PImage Instructions;
PImage Settings;


// Props
PImage clock1;
PImage clock2;
PImage clock3;
//PImage note;
//PImage bus;
//PImage door1;
//PImage door2;

// Music
//boolean play1 = false;
//SoundFile OS_Music;

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
  OS[0] = loadImage("OS.PNG");
  OS[1] = loadImage("OS_Start.PNG");
  OS[2] = loadImage("OS_Settings.PNG");
  OS[3] = loadImage("OS_Instruct.PNG");
  OS[4] = loadImage("OS_Dev.PNG");
  OS[5] = loadImage("OS_Quit.PNG");
  //OS_Music = new SoundFile(this, "ElevatorMusic.wav");

  Back = loadImage("BACK_white.PNG");
  Back_S = loadImage("BACK_Red.PNG");

  Instructions = loadImage("Instructions.png");

  Settings = loadImage("Settings.png");

  Dev[0] = loadImage("DEV.png");
  Dev[1] = loadImage("DEV_Start.png");
  Dev[2] = loadImage("DEV_S1.png");
  Dev[3] = loadImage("DEV_S2.png");
  Dev[4] = loadImage("DEV_S3.png");
  Dev[5] = loadImage("DEV_End.png");

  // Character Animation
  charWalk[0] = loadImage("CHAR_walk1R.PNG");
  charWalk[1] = loadImage("CHAR_walk2R.PNG");
  charWalk[2] = loadImage("CHAR_walk3R.PNG");
  charWalk[3] = loadImage("CHAR_walk4R.PNG");
  charWalk[4] = loadImage("CHAR_walk1L.PNG");
  charWalk[5] = loadImage("CHAR_walk2L.PNG");
  charWalk[6] = loadImage("CHAR_walk3L.PNG");
  charWalk[7] = loadImage("CHAR_walk4L.PNG");
  character = charWalk[0];
  
  // Monster Animation
  monWalk[0] = loadImage("Monster1R.png");
  monWalk[1] = loadImage("Monster2R.png");
  monWalk[2] = loadImage("Monster1L.png");
  monWalk[3] = loadImage("Monster2L.png");
  monster = monWalk[0];
  
  pause = loadImage("Pause.PNG");
  black = loadImage("black.PNG");
  PM[0] = loadImage("PM.PNG");
  PM[1] = loadImage("PM_Return.PNG");
  PM[2] = loadImage("PM_Instructions.PNG");
  PM[3] = loadImage("PM_Settings.PNG");

  // Bus stop + school cameo\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  back[0] = loadImage("B_BACK.PNG");
  fore[0] = loadImage("B_FORE1.png");

  // School
  back[1] = loadImage("TEMP_School.png");
  fore[1] = loadImage("TEMP_School.png");
  back[2] = loadImage("TEMP_Hallway.png");
  fore[2] = loadImage("TEMP_Hallway.png");
  
  clock1 = loadImage("clock full.png");
  clock2 = loadImage("TEMP_Settings.png");
  clock3 = loadImage("TEMP_Settings.png");

  // Xanadu
  fore[3] = loadImage("hallway door alone.PNG");
  back[3] = loadImage("black.PNG");
  back[4] = loadImage("X_BACK.png");
  fore[4] = loadImage("X_FORE.PNG");
  lights[0] = loadImage("nightlight1.PNG");
  lights[1] = loadImage("nightlight2.PNG");
  lights[2] = loadImage("moonlight1.PNG");
  lights[3] = loadImage("moonlight2.PNG");

  /* if (play1 == true) {
    OS_Music.loop();
    play1 = false;
  } */
} //end setup


void draw() {
  /*play1 = true;
  if (play1) {
    OS_Music.play();
    OS_Music.loop();
    play1 = false;
  }*/
  M_relativeX = abs(frontX) + mouseX;
  char_relativeX = abs(frontX) + locationX;
  
  textFont(subtitle);
  textSize(25);
  fill(245, 202, 122);
  
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
      image(OS[1], 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 550 && mouseY >= 310 && mouseY <= 345)
      image(OS[2], 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 580 && mouseY >= 360 && mouseY <= 390)
      image(OS[3], 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 565 && mouseY >= 395 && mouseY <= 425)
      image(OS[4], 0, 0, 800, 800);
    else if (mouseX >= 475 && mouseX <= 530 && mouseY >= 435 && mouseY <= 470)
        image(OS[5], 0, 0, 800, 800);
    else
      image(OS[0], 0, 0, 800, 800);
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
    if (mouseX >= 130 && mouseX <= 335 && mouseY >= 210 && mouseY <= 280)
      image(Dev[1], 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 295 && mouseY <= 355)
      image(Dev[2], 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 375 && mouseY <= 435)
      image(Dev[3], 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 450 && mouseY <= 510)
      image(Dev[4], 0, 0, 800, 800);
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 540 && mouseY <= 600)
      image(Dev[5], 0, 0, 800, 800);
    else
      image(Dev[0], 0, 0, 800, 800);
  
    image(Back, 0, 0, 800, 800);
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      image(Back_S, 0, 0, 800, 800);
    else
      image(Back, 0, 0, 800, 800);
  }
  /////////////////////////////////////////////// bus stop /////////////////////////////////////////////////
  else if (scene == 1) {
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Jen
    sceneNum = 1;
    if (M_relativeX >= 1955 && M_relativeX <= 2085 && mouseY >= 465 && mouseY <= 610){
      fore[0] = loadImage("B_FORE_Garbage.PNG");
      text("garbage", (M_relativeX-frontX), 440);
    } else if (M_relativeX >= 2090 && M_relativeX <= 2235 && mouseY >= 240 && mouseY <= 610){
      fore[0] = loadImage("B_FORE_Sign.PNG");
    } else if (M_relativeX >= 2260 && M_relativeX <= 2615 && mouseY >= 450 && mouseY <= 610){
      fore[0] = loadImage("B_FORE_Bench.PNG");
    } else
      fore[0] = loadImage("B_FORE1.png");
    display(fore[0], back[0], 3020, 2006);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Dorothy
    if (clicked[0] == true){
       timer += 0.1;
       text("stinky", 250, 740);
       if (timer >= 3){
         timer = 0;
         clicked[0] = false;
       }
     }
     if (clicked[1] == true) {
       timer += 0.1;
       text("wait for the bus!", 250, 740);
       if (timer >= 5) {
         timer = 0;
         clicked[1] = false;
       }
     }
     if (clicked[2] == true) {
       timer += 0.1;
       text("you're now waiting!", 250, 740);
       if (timer >= 5) {
         timer = -0.5;
         clicked[2] = false;
         clicked[3] = true;
       }
     }
     if (clicked[3] == true) {
       timer += 0.1;
       text("the bus is here!", 250, 740);
       if (timer >= 4) {
         timer = -0.5;
         clicked[3] = false;
         clicked[4] = true;
       }
     }
     if (clicked[4] == true) {
       timer += 0.1;
       text("it looks a bit strange though...", 250, 740);
       if (timer >= 4) {
         timer = -0.5;
         clicked[4] = false;
         text2half = true;
         scene = 2.5;
         backX = 0;
         frontX = 0;
         locationX = 50;
       }
     }
     if (!clicked[0] && !clicked[1] && !clicked[2] && clicked[3])
       timer = 0;
  }//end scene 1
//////////////////////////////////////////////// school 1 ////////////////////////////////////////////////
  else if (scene == 2) {
    sceneNum = 2;
    if (sceneChange) {
      locationX = 50;
      sceneChange = false;
    }
    if (!inSchool)
      display(fore[1], back[1], 2500, 2500);
    else{
      display(fore[2], back[2], 2500, 2500);
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
    display(fore[3], back[3], 3222, 2000);
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
    display(fore[4], back[4], 4330, 2454);
    timer += 0.1;
    if (light) {
      light(4330); 
    }
    if (char_relativeX >= 4000)
      scene = 4;
  } 
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  /////////////////////////////////////////////// end1 /////////////////////////////////////////////////
  else if (scene == 4) { // good end (you escape!)
    background(0);
    textAlign(CENTER, CENTER);
    text("...What is this place?", 400, 400);
  } 
  /////////////////////////////////////////////// end2 /////////////////////////////////////////////////
  else if (scene == 5) { // bad end (you died O_O)
    endScreen();
  }
  transition(loadScene);
}//end draw



void mousePressed() {
  //println(mouseX + " " + mouseY);
  //println(M_relativeX + " " + mouseY); 
  
  if (scene == 3) {
    //println(M_relativeX);
    //println(frontX);
  }

  if (scene == 0) {
    if (mouseX >= 475 && mouseX <= 530 && mouseY >= 275 && mouseY <= 305) //Start
      loadScene = 1;
    else if (mouseX >= 475 && mouseX <= 550 && mouseY >= 310 && mouseY <= 345) // Settings
      loadScene = -2;
    else if (mouseX >= 475 && mouseX <= 580 && mouseY >= 360 && mouseY <= 390) // Instructions
      loadScene = -3;
    else if (mouseX >= 475 && mouseX <= 565 && mouseY >= 395 && mouseY <= 425) // Developer mode
      loadScene = -4;
    else if (mouseX >= 475 && mouseX <= 530 && mouseY >= 435 && mouseY <= 470) //quit
        exit(); //Processing reference: https://processing.org/reference/exit_.html
  } // end loadingScreen mousePressed

  if (scene == -1) { //start button
    if (mouseX >= 540 && mouseX <= 730 && mouseY >= 650 && mouseY <= 730)
      loadScene = 0;
  } // end startScreen

  if (scene == -2 || scene == -3 || scene == -4 || scene == 4 || scene == 5) { //back button
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      loadScene = sceneNum;
  }

  if (scene == -4) { //Dev menu
    if (mouseX >= 130 && mouseX <= 335 && mouseY >= 210 && mouseY <= 280)
      loadScene = -1;
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 295 && mouseY <= 355)
      loadScene = 1;
    else if (mouseX >= 130 && mouseX <= 270 && mouseY >= 375 && mouseY <= 435)
      loadScene = 2;
    else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 450 && mouseY <= 510){
      loadScene = 3;
      mon_relativeX = 0;
    } else if (mouseX >= 130 && mouseX <= 275 && mouseY >= 540 && mouseY <= 600)
      loadScene = 5;
  }
  if (scene >= 1){
    if (mouseX >= 20 && mouseX <= 90 && mouseY >= 20 && mouseY <= 90){ //pause button
      paused = !paused;
    }
  }
  
  if (scene == 1){
    if (M_relativeX >= 1955 && M_relativeX <= 2085 && mouseY >= 465 && mouseY <= 610)
      clicked[0] = true;
    else if (M_relativeX >= 2090 && M_relativeX <= 2235 && mouseY >= 240 && mouseY <= 610)
      clicked[1] = true;
    else if (M_relativeX >= 2260 && M_relativeX <= 2615 && mouseY >= 450 && mouseY <= 610)
      clicked[2] = true;
  }
  
  if (scene == 2.5) {
    if (mouseX >= 417 && mouseX <= 660 && mouseY >= 160 && mouseY <= 610) {
      loadScene = 3;
      locationX = 50;
      backX = 0;
      frontX = 0;
    }
  }
  
  if (paused) {
    if (mouseX >= 235 && mouseX <= 545){
      if (mouseY >= 195 && mouseY <= 285){
        loadScene = 0;
        backX = 0;
        frontX = 0;
        locationX = 50;
        paused = false;
      }
      else if (mouseY >= 320 && mouseY <= 410)
        loadScene = -3;
      else if (mouseY >= 440 && mouseY <= 535)
        loadScene = -2;
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
    } /*else if (key == 'q') {
      bully = true;
    }*/
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

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Jen
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
    if (frame == 20) {
      frame = 5;
    } /*else if (frame == 20) {
      frame = 0;
    }*/
  }
  walking();
  //crouching();
  jumping();
}//end moving
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

void bullying() {
} //end bullying! 👨

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// story //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Jen
void display(PImage foreground, PImage background, int foreLength, int backLength) {
  //println(M_relativeX);
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
  if (scene == 3){
    monster();
    image(monster, (mon_relativeX + frontX), monLocationY, 300, 300);
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
        image(PM[1], 0, 0, 800, 800);
      else if (mouseY >= 320 && mouseY <= 410)
        image(PM[2], 0, 0, 800, 800);
      else if (mouseY >= 440 && mouseY <= 535)
        image(PM[3], 0, 0, 800, 800);
      else
        image(PM[0], 0, 0, 800, 800);
    }
    else
      image(PM[0], 0, 0, 800, 800);
  }
  image(pause, 20, 20, 70, 70);
} //end display
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Dorothy
void light(int foreLength) {
  boolean lightb[] = { false, false, false, false };
  boolean swch1;
  
  float random1 = random(1,10);
  if (random1 <= 5) {
    lightb[0] = true;
  }
  
  //int lights[] = {0, 1, 2, 3, 4, 5};
  // int random = (int)random(0, 1);
  timerlight += 0.1;
  
  if (timer%10 <= 5) {
    swch1 = true;
  } if (timer%10 > 5) {
    swch1 = false;
  } else 
    swch1 = true;
  
  if(swch1 == true) {
    lightb[3] = false;
    lightb[1] = true;
    //println("purple");
  } else {
    lightb[3] = true;
    lightb[1] = false;
    if (char_relativeX >= 1498 && char_relativeX <= 1714) {
        scene = 5;
        sceneNum = 0;
        randomizeText = true;
    }
    //println("not purple");
  }
  
  if (lightb[0]) 
    image(lights[0], frontX, 0, foreLength, 800);
  if (lightb[1]) 
    image(lights[1], frontX, 0, foreLength, 800);
  if (lightb[2]) 
    image(lights[2], frontX, 0, foreLength, 800);
  if (lightb[3]) 
    image(lights[3], frontX, 0, foreLength, 800);


} //end light

void endScreen() {
  int textNum = 0;
  if (randomizeText){
    textNum = int(random(1,5));
    randomizeText = false;
  }
  background(0);
  textAlign(CENTER, CENTER); //Processing reference: https://processing.org/reference/textAlign_.html
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
  //noLoop();
  if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
    image(Back_S, 0, 0, 800, 800);
  else
    image(Back, 0, 0, 800, 800);
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Jen
void transition(float nextScene){
  if (loadScene != -100){
    do{
      if (transparency < 255 && fadeIn == false){
        transparency += 5;
        println(transparency);
      }
      else if (transparency == 255){
        scene = nextScene;
        fadeIn = true;
      }
      if (transparency > 0 && fadeIn == true){
        transparency -= 5;
        println(transparency);
      }
      if (transparency == 0 && fadeIn == true){
        transparency = 0;
        fadeIn = false;
        loadScene = -100;
        println("end");
      }
    }while(transparency != 0 && fadeIn == false);
    tint(255, transparency);
    image(black, 0, 0, 800, 800);
    tint(255, 255);
  }//end big if
} //end transition


void monster(){
  println(char_relativeX);
  //println(mon_relativeX);
  if (char_relativeX >= 500 && mon_relativeX == 0){
    mon_relativeX = char_relativeX;
  }
  else if (mon_relativeX != 0 && !paused){
    if (monLocationY <= 370){
      monLocationY += 10;
    }
  //animation
    if (mon_relativeX < char_relativeX) {
      mon_relativeX += 5;
      monFrame++;
      switch(monFrame) {
      case 0:
        monster = monWalk[0];
        break;
      case 5:
        monster = monWalk[1];
        break;
      case 10:
        monFrame = 0;
        break;
      }
    } else if (mon_relativeX > char_relativeX) {
      mon_relativeX -= 5;
      monFrame++;
      switch(monFrame) {
      case 0:
        monster = monWalk[2];
        break;
      case 5:
        monster = monWalk[3];
        break;
      case 10:
        monFrame = 0;
        break;
      }
    }
//character collision
    if (locationY <= (monLocationY + 20) && locationY >= (monLocationY - 150)){
      if (char_relativeX >= (mon_relativeX - 50) && char_relativeX <= (mon_relativeX + 50)){
        scene = 5;
        sceneNum = 0;
        randomizeText = true;
      }
    }
//trapped in light
    if (mon_relativeX >= 1525) {
      mon_relativeX = 1525;
    }
  }//end else if
}// end monster
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
