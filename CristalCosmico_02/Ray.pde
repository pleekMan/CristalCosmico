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


    float animPos = timer.getValueZeroToOne();
    for (int i=0; i<3;i++) {

      float localAnimPos = animPos + (0.2 * i);
      localAnimPos = localAnimPos - floor(localAnimPos);

      float x = lerp(startPos.x, endPos.x, localAnimPos);
      float y = lerp(startPos.y, endPos.y, localAnimPos);
      float z = lerp(startPos.z, endPos.z, localAnimPos);
    }
  }

  public void render() {
    
    
    line(startPos.x, startPos.y, startPos.z, endPos.x, endPos.y, endPos.z);
  }

  public void setPositions(PVector start, PVector end) {
    startPos.set(start);
    endPos.set(end);
  }

  public void start() {
    timer.start();
  }
}
