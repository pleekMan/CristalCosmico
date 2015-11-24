class CosmicCrystal {

  //OSCILLATE CRYSTAL'S COLORS, INSTEAD OF TRIGGERING THEM

  PGraphics surface;
  PVector position;
  PVector velocity;
  PVector size;
  PVector rotation;
  PVector rotationVelocity;


  SimpleOscillator osc1;

  CosmicCrystal() {
    surface = createGraphics(1000, 1000);
    size = new PVector(surface.width * 0.7, surface.height, surface.width * 4);
    position = new PVector(0,0, -8000);
    velocity = new PVector(0, 0, 1);
    rotation = new PVector(0,0,0);
    rotationVelocity = new PVector(0,0,0);

    osc1 = new SimpleOscillator(SimpleOscillator.RAMP, 12000);
    osc1.start();
  }

  void update() {

    osc1.update();

    if (osc1.isFinished())refreshSurface();

    if (position.z > 2000)position.z = -7000;
  }

  void render() {

    //drawCrystal2D();
    float brightness = osc1.getValueInverted();
    tint(255, brightness * 255);
    drawCrystal3D();
  }

  void refreshSurface() {
    
    surface.beginDraw();
    //crystalSurface.background(0);
    //surface.blendMode(BLEND);
    //surface.fill(0, 2);
    //surface.rect(0, 0, surface.width, surface.height);


    surface.blendMode(BLEND);
    surface.fill(0);
    surface.rect(0, 0, surface.width, surface.height);

    surface.blendMode(SCREEN);

    surface.noStroke();
    for (int i=0; i<10;i++) {
      surface.fill(random(255), random(255), random(255));
       
      surface.beginShape();
       for (int j=0; j<3;j++) {
       surface.vertex(random(surface.width), random(surface.height));
       }


      surface.endShape();

    }
    surface.endDraw();

    //image(surface,0,0);
  }

  void drawCrystal3D() {
    
    pushMatrix();
    //rotateZ()
    
    //position.z = map(mouseX, width, 0, 500, -7000);
    position.add(velocity);
    noStroke();
    //textureMode(NORMAL);

    // CRYSTAL ROMBOID 3D
    beginShape();
    texture(surface);
    vertex(position.x, position.y - (size.y * 0.5), position.z, 0.5, 0.2);
    vertex(position.x + (size.x * 0.5), position.y, position.z, 0.8, 0.5);
    vertex(position.x, position.y, position.z + (size.z * 0.5), 0.5, 0.5);  
    endShape(CLOSE);

    beginShape();
    texture(surface);
    vertex(position.x, position.y, position.z + (size.z * 0.5), 0.5, 0.5);
    vertex(position.x + (size.x * 0.5), position.y, position.z, 0.8, 0.5);
    vertex(position.x, position.y + (size.y * 0.5), position.z, 0.5, 0.8);
    endShape(CLOSE);

    beginShape();
    texture(surface);
    vertex(position.x - (size.x * 0.5), position.y, position.z, 0.2, 0.5);
    vertex(position.x, position.y, position.z + (size.z * 0.5), 0.5, 0.5);
    vertex(position.x, position.y + (size.y * 0.5), position.z, 0.5, 0.8);
    endShape(CLOSE);


    beginShape();
    texture(surface);
    vertex(position.x, position.y - (size.y * 0.5), position.z, 0.5, 0.2);
    vertex(position.x, position.y, position.z + (size.z * 0.5), 0.5, 0.5);
    vertex(position.x - (size.x * 0.5), position.y, position.z, 0.2, 0.5);
    endShape(CLOSE);
    
    popMatrix();
  }

  void drawCrystal2D() {

    //position.z = map(mouseY, height, 0, 500, -7000);
    position.add(velocity);

    noStroke();
    textureMode(NORMAL);

    // CRYSTAL ROMBOID
    beginShape();
    texture(surface);
    vertex(position.x, position.y - (size.y * 0.5), position.z, 0.5, 0.25);
    vertex(position.x + (size.x * 0.5), position.y, position.z, 0.75, 0.5);
    vertex(position.x, position.y + (size.y * 0.5), position.z, 0.5, 0.75);
    vertex(position.x - (size.x * 0.5), position.y, position.z, 0.25, 0.5);
    endShape(CLOSE);


    // CRYSTAL HIGHLIGHTS
    blendMode(ADD);
    // BRIGHT SIDE
    fill(255, 127);
    beginShape();
    vertex(position.x, position.y - (size.y * 0.5), position.z + 1);
    vertex(position.x + (size.x * 0.5), position.y, position.z + 1);
    vertex(position.x, position.y, position.z);
    endShape(CLOSE);

    // NOT SO BRIGHT SIDES
    fill(127, 127);
    beginShape();
    vertex(position.x, position.y, position.z);
    vertex(position.x + (size.x * 0.5), position.y, position.z, 0.75, 0.5);
    vertex(position.x, position.y + (size.y * 0.5), position.z, 0.5, 0.75);
    endShape(CLOSE);
    beginShape();
    vertex(position.x, position.y - (size.y * 0.5), position.z + 1);
    vertex(position.x, position.y, position.z);
    vertex(position.x - (size.x * 0.5), position.y, position.z, 0.25, 0.5);
    endShape(CLOSE);

    blendMode(BLEND);
  }

  public void setVelocity(PVector newVel) {
    velocity.set(newVel);
  }
  public void setPosition(PVector newPos) {
    position.set(newPos);
  }
  public void setRefreshRate(int rateInMillis) {
    osc1.setDuration(rateInMillis);
  }
  public void triggerRefresh() {
    osc1.start();
  }
  
  public void setImage(PImage _image){
    surface.beginDraw();
    surface.image(_image,0,0,surface.width, surface.height);
    surface.endDraw();
  }

}
