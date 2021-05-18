PImage bg, fish, upperBadCat, lowerBadCat, myCat, lose, win, restart;
final float FISH_W = 100;
final float FISH_H = 100;
final float BADCAT_INIT_X = 160;
final float BADCAT_INIT_Y = -140;
final float BADCAT_W = 150;
final float BADCAT_H = 430;
final float SPACE = 220;
final float MYCAT_X = 1080;
final float MYCAT_Y = 280;
final float MYCAT_W = 220;
final float MYCAT_H = 150;
final float RESTART_W = 100;
final float RESTART_H = 100;

final int GAME_RUN = 0;
final int GAME_LOSE = 1;
final int GAME_WIN = 2;
int gameState = 0; 

float fishX, fishY;
final float A = 50; 


void setup()
{
  size(1280,755);
  bg = loadImage("img/bg.png");
  fish = loadImage("img/fish.png");
  upperBadCat = loadImage("img/upperBadCat.png");
  lowerBadCat = loadImage("img/lowerBadCat.png");  
  myCat = loadImage("img/myCat.png");
  lose = loadImage("img/lose.png");
  win = loadImage("img/win.png");
  restart = loadImage("img/restart.png");
}

void draw()
{
  switch(gameState) {
    case GAME_RUN:
        image(bg, 0, 0, 1280, 755);
        
        //move fish 
        fishX = mouseX-FISH_W/2;
        fishY = mouseY-FISH_H/2;
        if(fishX < 0 ){
          fishX = 0;
        } else if(fishX > width - FISH_W) {
          fishX = width - FISH_W;
        }
        if(fishY < 0) {
          fishY = 0;
        } else if(fishY > height - FISH_H) {
          fishY = height - FISH_H;
        }
        // show fish
        image(fish, fishX, fishY,FISH_W, FISH_H);
     

        // show 12 bad cats
        for(int i = 0; i < 6; i++) {
          image(upperBadCat, BADCAT_INIT_X + i*BADCAT_W , BADCAT_INIT_Y);
          image(lowerBadCat, BADCAT_INIT_X + i*BADCAT_W , BADCAT_INIT_Y + SPACE + BADCAT_H);
        }
        
        // show white cat
        image(myCat, MYCAT_X, MYCAT_Y);
        if(fishX + FISH_W > MYCAT_X && fishX < MYCAT_X + MYCAT_W
           && fishY < MYCAT_Y + MYCAT_H && fishY + FISH_H > MYCAT_Y){
          gameState = GAME_WIN;
        }
        
        // crash detection
        for(int i=0; i<6; i++){
          if(fishX + FISH_W > BADCAT_INIT_X + i*BADCAT_W && fishX < BADCAT_INIT_X + (i+1)*BADCAT_W
             && fishY < BADCAT_INIT_Y + BADCAT_H){
            gameState = GAME_LOSE;
          }
          if(fishX + FISH_W > BADCAT_INIT_X + i*BADCAT_W && fishX < BADCAT_INIT_X + (i+1)*BADCAT_W
             && fishY + FISH_H > BADCAT_INIT_Y + BADCAT_H + SPACE){
            gameState = GAME_LOSE;
          }
        }
   
        break;
  
      case GAME_LOSE:
        image(lose, 0, 0);
        image(restart, 0, 0, RESTART_W, RESTART_H);
        if(mousePressed == true) {
          
          if(mouseX < RESTART_W && mouseY < RESTART_H) {
            gameState = GAME_RUN;
          }          
          
        }
        break;
        
      case GAME_WIN:
        image(win, 0, 0);
        image(restart, 0, 0, RESTART_W, RESTART_H);
        if(mousePressed == true) {
          
          if(mouseX < RESTART_W && mouseY < RESTART_H) {
            gameState = GAME_RUN;
          }              
          
        }
        break;

  }
}
