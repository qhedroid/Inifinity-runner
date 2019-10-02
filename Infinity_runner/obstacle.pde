import java.util.Random;

class Obstacle {

  private boolean spawned = false;
  private int typeIndex; 
  private PImage[] obstacleImages = new PImage[4];
  private int[] obstacleWidths = {50, 60, 80, 100};
  private int[] obstacleHeights = {100, 50, 100, 60};
  private float x;
  private int y; 
  private int w = 50;
  private int h = 50;

  private float spawnX = width + 100;
  private float respawnX = -100;
  private float resetX;

  Obstacle(float x) {
    this.x = x;
    resetX = x;

    typeIndex = (int) random(obstacleImages.length);
    w = obstacleWidths[typeIndex];
    h = obstacleHeights[typeIndex];
    obstacleImages[0] = loadImage("bush1.png");
    obstacleImages[1] = loadImage("bush2.png");
    obstacleImages[2] = loadImage("bush3.png");
    obstacleImages[3] = loadImage("lavaPool1.png");
  }
  public void move() {
    if (x<respawnX) {
      spawned = false;
    } else {
      x-=spawnCalculator.speed;
    }
  }

  public boolean isHit(float playerY, float playerH, float playerW) {
    int playerX = 50;
    this.y = height-this.h-groundOffset;

    if (this.x < playerX+playerW  && this.x > playerX && playerY+playerH > this.y) {
      return true;
    } else if (this.x+this.w < playerX+playerW  && this.x+this.w > playerX && playerY+playerH > this.y) {
      return true;
    }
    return false;
  }

  public void draw() {
    image(obstacleImages[typeIndex], x, height-h-groundOffset, w, h);
    if (spawned) {
      this.move();
    } else {
      if (spawnCalculator.canSpawn()) {
        spawn();
        spawned = true;
        spawnCalculator.justSpawned();
      }
    }
  }

  private void spawn() {
    typeIndex = (int) random(obstacleImages.length);
    w = obstacleWidths[typeIndex];
    h = obstacleHeights[typeIndex];
    x = spawnX;
  }

  public float getX() {
    return x;
  }
  public int getHeight() {
    return h;
  }
  public int getWidth() {
    return w;
  }
  public void reset() {
    this.x = resetX;
  }
}
