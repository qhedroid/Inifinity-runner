class cloud {
  private float cloudX;
  private float cloudY;
  private float cloudW;
  private float cloudH;

  private float speed = 2;
  private final float defaultSpeed = speed;

  public cloud() {
    cloudX= random(width+100);
    cloudY=random(200);
    cloudW=random(150, 600);
    cloudH=random(50, 100);
  }

  private void move() {
    cloudX-=speed;

    if (cloudX+cloudW<-100) {
      cloudX=width+random(250);
      cloudW=random(150, 600);
      cloudH=random(50, 100);
    }
  }

  public void stop() {
    speed=0;
  }

  public void start() {
    speed=defaultSpeed;
  }

  public void draw() {
    fill(255);
    noStroke();
    ellipse(cloudX, cloudY, cloudW, cloudH);
    ellipse(cloudX+60, cloudY, cloudW, cloudH);
    ellipse(cloudX+120, cloudY, cloudW, cloudH);
    ellipse(cloudX+90, cloudY+40, cloudW, cloudH);
    ellipse(cloudX+30, cloudY+40, cloudW, cloudH);
    ellipse(cloudX+30, cloudY-40, cloudW, cloudH);
    ellipse(cloudX+90, cloudY-40, cloudW, cloudH);
    this.move();
  }
}
