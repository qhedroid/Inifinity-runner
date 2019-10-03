boolean gameStarted = false;
boolean gameEnded = false;
int score = 0;
int hiscore;
boolean newHiscore = false;
PFont scoreFont;
PFont titleFont;
PFont subtitleFont;

player p;

int environmentDensity = 8;
cloud[] clouds = new cloud[environmentDensity];
mountain[] mountains = new mountain[environmentDensity];
Obstacle[] obstacles= new Obstacle[2];
public int groundOffset = 35;
public static float startSpeed;
public static float speedIncrement;

void setup() {
  size(1500, 500);

  p = new player();
  //hiscore = parseInt(loadStrings("hiscore.txt")[0]);
  //print(hiscore);

  obstacles[0] = new Obstacle(width + 1000);
  obstacles[1] = new Obstacle(width + 1700);

  scoreFont = createFont("Georgia", 48, true);
  titleFont = createFont("Georgia", 100, true);
  subtitleFont = createFont("Georgia", 60, true);

  for (int i=0; i<environmentDensity; i++) {
    clouds[i] = new cloud();
    mountains[i] = new mountain();
  }
}

void draw() {
  background(#31A7FF);

  fill(218, 229, 4, 200);
  rect(50, 50, 100, 100);
  fill(229, 172, 4);
  rect(65, 65, 70, 70);
  fill(229, 124, 4);
  rect(75, 75, 50, 50);

  noStroke();
  fill(#00AD2F);
  rect(0, 350, width, height-350);

  for (int i=0; i<environmentDensity; i++) {
    clouds[i].draw();
    mountains[i].draw();
  }
  if (gameStarted) {
    spawnCalculator.speedCalculatorTick();
    p.draw();

    for (Obstacle ob : obstacles) {
      ob.draw();

      if (ob.isHit(p.getY(), p.getH(), p.getW())) {
        endGame();
      }
    }
    if (gameEnded) {
      fill(255, 200, 200, 200);
      rect(0, 0, width, height);
      fill(255, 50, 50);
      textFont(titleFont);
      text("GAME OVER", 200, 200);
      textFont(subtitleFont);
      text("Press [r] to play again.", 200, 300);
      if (newHiscore) {
        text("[New Best!]", 600, 180);
        saveStrings("hiscore.txt", new String[] {String.format("%d", hiscore)});
      }
    } else {
      score++;
      if (score > hiscore) {
        newHiscore = true;
        hiscore = score;
      }
    }


    fill(0);
    textFont(scoreFont);
    if (score<hiscore) {
      text("Score:  "+score, 1200, 40);
      text("Best:    "+hiscore, 1200, 80);
    } else {
      text("Best:    "+score, 1200, 40);
    }
  } else {
    fill(255);
    textFont(titleFont);
    text("Infinity Runner", 200, 200);
    for (int i=0; i<10; i++) {
      fill(255, 255, 255, 255-20*i);
      text(".", 450+20*(i+1), 200);
    }
    textFont(subtitleFont);
    text("Press [r] to start.", 200, 300);
  }
}

void endGame() {
  gameEnded = true;
  spawnCalculator.stopObjects();

  for (cloud c : clouds) {
    c.stop();
  }
}

void keyPressed() {
  if (key==' ') {
    if (!p.jumping && !gameEnded) {
      p.jump();
    }
  } else if (key == 'r') {
    if (!gameStarted) {
      spawnCalculator.startObjects();
      gameStarted = true;
    }
    if (gameEnded) {
      score=0;
      newHiscore = false;
      gameEnded = false;
      spawnCalculator.restartObjects();
      for (Obstacle ob : obstacles) {
        ob.reset();
      }

      for (cloud c : clouds) {
        c.start();
      }
    }
  } else if (key == 'p') {
    hiscore = 0;
  } else if (key == 'o') {
    spawnCalculator.toggleSpawning();
  }
}
