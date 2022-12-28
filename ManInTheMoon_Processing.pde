import processing.sound.*; // sound library import

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// Global Variables ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Scene control
float scene = -1;
boolean changeScene = false;


// Chang'e animation sprites
PImage character; //current Chang'e frame
PImage character0R, character0L, character1R, character2R, character3R, character1L, character2L, character3L;
PImage walk[] = new PImage[] {character0R, character0L, character1R, character2R, character3R, character1L, character2L, character3L}; //0R and 0L are stationary
// PImage crouch[] = {character4R, character5R, character4L, character5L}; 
// PImage jump[] = { };


//movement control
int locationX = 50;
int locationY = 334;
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

/*

// Monster sprite (only one design)
PImage mon; // current monster frame
//PImage monWalk[] = {mon0R, mon0L, mon1R, mon2R, mon3r, mon1L, mon2L, mon3L}; */

// Scene animation
int frontX;
int backX; 

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


PImage busStop; 
PImage school;
PImage hallway;
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

// Music
boolean play = false;
SoundFile OS_Music;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// Prelims /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(800,800); //my fav line of code #2
  background(255);
  frameRate(4); 

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
  character0R = loadImage("CHAR_walk1L.png");
  character1R = loadImage("CHAR_walk2L.png");
  character2R = loadImage("CHAR_walk3L.png");
  character3R = loadImage("CHAR_walk4L.png");
  
  character0L = loadImage("CHAR_walk1L.png");
  character1L = loadImage("CHAR_walk2L.png");
  character2L = loadImage("CHAR_walk3L.png");
  character3L = loadImage("CHAR_walk4L.png");

  character = character0R;

  // Bus stop + school cameo\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  busStop = loadImage("TEMP_BusStop.png");

  // School
  school = loadImage("TEMP_School.png");
  hallway = loadImage("TEMP_Hallway.png");
  clock1 = loadImage("clock full.png");
  clock2 = loadImage("TEMP_Settings.png");
  clock3 = loadImage("TEMP_Settings.png");

  // Xanadu
  X_Back = loadImage("X_BACK.png");
  X_Fore = loadImage("X_FORE.png");

}

/*  if (lobby == true) {
    lobbyMusic.loop();
    lobby = false;
  }
  if (game == true) {
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

//////////////////////////////////////////////// scene -1 ////////////////////////////////////////////////
  if (scene == -1) {
    startScreen();
  } 
//////////////////////////////////////////////// scene 0 ////////////////////////////////////////////////
  else if (scene == 0) {
    loadingScreen();
    if (play) {
      OS_Music.play();
      OS_Music.loop();
      play = false;
    }
  } 
//////////////////////////////////////////////// scene -2 ////////////////////////////////////////////////
  else if (scene == -2) {
    gameSettings();
  } 
//////////////////////////////////////////////// scene -3 ////////////////////////////////////////////////
  else if (scene == -3) {
    instructions();
  }
//////////////////////////////////////////////// scene -4 ////////////////////////////////////////////////
    else if (scene == -4) {
      devMenu();
    }
////////////////////////////////////////////////////////////////////////////////////////////////
  else if (scene == 1) {
    busStop();
  } 
////////////////////////////////////////////////////////////////////////////////////////////////
  else if (scene == 2) {
    school();
  }
////////////////////////////////////////////////////////////////////////////////////////////////
  else if (scene == 3) {
    xanadu1();
  } 
  ////////////////////////////////////////////////////////////////////////////////////////////////
  /* else if (scene == 4) {
    endScreen();
  } */
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

  if (scene == -1) {
    if (mouseX >= 540 && mouseX <= 730 && mouseY >= 650 && mouseY <= 730)
      scene = 0;
  } // end startScreen

  if (scene == -2 || scene == -3 || scene == -4) {
    if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
      scene = 0;
  }

  if (scene == -4) {
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
  
}//end mousePressed


void mouseReleased() {
  
}//end mouseReleased

void keyPressed() {
  if (key == 'd'){
    move = true;
    facingRight = true;
  }
  else if (key == 'a'){
    move = true;
    facingRight = false;
  }
  else if (key == ' '){
    jumping = true;
  }
  else if (key == 'q') {
      bully = true;
  }
  else if (key == CODED){
    if (keyCode == CONTROL) {
      if (jumping == false){
        crouching = true;
      }
    } // end keyCode
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
      character = character0R;
      break;
    case 5:
      character = character1R;
      break;
    case 10:
      character = character2R;
      break;
    case 15:
      character = character3R;
      break;
    }
  } else if (facingRight == false) {
    switch(frame) {
    case 0:
      character = character0L;
      break;
    case 5:
      character = character1L;
      break;
    case 10:
      character = character2L;
      break;
    case 15:
      character = character3L;
      break;
    }
  }
}//end of walking

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
void jumping() { //WITH HELP FROM MS. WIEBE
  locationY -= speedY;
  if (jumping == true) {
    speedY += 4;
  }
  if (speedY >= 40) {
    speedY = 0;
    locationY = 334;
    jumping = false;
  }
}//end of jumping 


void moving() {
  if (move == true) {
  if (facingRight == true)
    locationX += 10; 
  if (facingRight == false)
    locationX -= 10;
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
}//end of moving


void bullying() {
  
} //end bullying! 👨

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////// start screen //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// scene -1
void startScreen() {
  scene = -1;
 if (mouseX >= 540 && mouseX <= 730 && mouseY >= 650 && mouseY <= 730)
    image(startGlow, 0, 0, 800, 800);
  else 
    image(startWhite, 0, 0, 800, 800);
} 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// settings ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void gameSettings() {
  scene = -2;
  image(Settings, 0, 0, 800, 800);
  image(Back, 0, 0, 800, 800);
  if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
    image(Back_S, 0, 0, 800, 800);
  else 
    image(Back, 0,0,800,800);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////// instructions /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// scene -3

void instructions() {
  scene = -3;
  image(Instructions, 0, 0, 800, 800);
  image(Back, 0, 0, 800, 800);
  if (mouseX >= 50 && mouseX <= 210 && mouseY >= 675 && mouseY <= 755)
    image(Back_S, 0, 0, 800, 800);
  else 
    image(Back, 0,0,800,800);
} 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////// devMenu ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// scene -4
void devMenu() {
  scene = -4;
  image(Dev, 0, 0, 800,800);

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
    image(Back, 0,0,800,800);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////// loadingScreen /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// scene 0

void loadingScreen() {
  
  scene = 0;

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
  
} //end loadingScreen


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// busStop ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// scene 1


void busStop() {
  scene = 1;
  image(busStop, 0, 0, 2500, 800);
  moving();
  image(character, locationX, locationY, 150, 225);
  
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// school /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// scene 2


void school() {
  scene = 2;

  // when character goes into the door, clock = true.
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
  }
} 




////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// xanadu1 ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// scene 3

void xanadu1() {
  scene = 3;
  image(X_Fore, 0, 0, 9910, 800);
  image(X_Back, 0, 0, 9910, 800);
} 
/*

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////// endScreen ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// scene ?

void endScreen() {
  scene = 4;
 } */

//my fav line of code