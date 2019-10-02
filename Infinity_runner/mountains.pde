class mountain {
  private float mountainX;
  private float mountainY;
  private float w;
  private float h;

  private float r, g, b;

  public mountain() {
    w = random(50, 200);
    h = random(50, 100);

    mountainX = random(width+100);
    mountainY = height - (120+h);

    r = random(7, 14);
    g = random(100, 255);
    b =0;
  }

  private void move() {
    mountainX-=spawnCalculator.speed;

    //respawn if needed
    if (mountainX+w < -100) {
      mountainX = width + random(250);

      w = random(50, 200);
      h = random(50, 100);
      mountainY = height - (120+h);

      r = random(7, 14);
      g = random(100, 255);
      b =0;
    }
  }

  public void draw() {
    fill(r, g, b);
    noStroke();
    rect(mountainX, mountainY, w, h);
    this.move();
  }
}
