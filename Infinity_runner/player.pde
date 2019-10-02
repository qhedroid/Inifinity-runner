class player {
  public boolean jumping=false;
  private float verticalSpeed;
    private final float gravity=0.9;

  private float h = 100;
  private float levelHeight = 500-h-35;
  private float y = levelHeight;
  private float w = 50;

  PImage adventurerRun;
  PImage [] sprite = new PImage[6];
  {
    for (int i = 0; i < 6; i=i+1) {
      sprite[i] = loadImage("adventurerRun" + i + ".png");
    }
  }

  public void draw() {
    fill(0);
    image(adventurerRun, 50, y, w, h);
    gravity();
  }

  public void jump() {
    if (!jumping) {
      jumping = true;
      verticalSpeed = -18;
      PImage adventurerJump;
      PImage [] sprite = new PImage[4];
      {
        for (int i = 0; i < 4; i=i+1) {
          sprite[i] = loadImage("adventurerJump" + i + ".png");
        }
      }
    }
  }

  private void gravity() {

    if (jumping) {
      verticalSpeed += gravity;
      y += verticalSpeed;
    }
    if (jumping && y > levelHeight) { 
      jumping = false;
      y = levelHeight;
      verticalSpeed = 0;
    }
  }
  public float getY() {
    return y;
  }
  public float getH() {
    return h;
  }
  public float getW() {
    return w;
  }
}
