class Ray {

  PVector startPos;
  PVector endPos;

  float animPos;

  SimpleOscillator timer;

  Ray(SimpleOscillator _timer) {

    timer = _timer;

    startPos = new PVector();
    endPos = new PVector();

    animPos = 0f;
  }

  public void update() {

    timer.update();
    animPos = timer.getValueZeroToOne();
  }

  public void render() {

    fill(255);
    stroke(255);

    line(startPos.x, startPos.y, startPos.z, endPos.x, endPos.y, endPos.z);

    for (int i=0; i<3;i++) {

      float localAnimPos = animPos + (0.3 * i);
      localAnimPos = localAnimPos - floor(localAnimPos); // LOOP 

      float x = lerp(startPos.x, endPos.x, localAnimPos);
      float y = lerp(startPos.y, endPos.y, localAnimPos);
      float z = lerp(startPos.z, endPos.z, localAnimPos);

      pushMatrix();

      translate(x, y, z);
      ellipse(0,0,5,5);
      //sphere(5);

      //text(x + " : " + y + " : " + z, 30, 0);
      //text(localAnimPos, 30, 30);
      //text(animPos, 30, 60);


      popMatrix();
    }
  }

  public void setPositions(PVector start, PVector end) {
    startPos.set(start);
    endPos.set(end);
  }

  public void start() {
    timer.start();
  }
}
