 //<>//
float movingZ;
PGraphics crystalSurface;
PVector crystalPosition;
PVector crystalSize;

PVector[] stars;
PVector starPosOffset;

int lastTapBeat;
int beat;

void setup() {
  size(800, 800, P3D);
  textureMode(NORMAL);
  smooth();


  movingZ = 0;
  beat = 240;
  lastTapBeat = 1;

  crystalSurface = createGraphics(1000, 1000);
  crystalSize = new PVector(crystalSurface.width * 0.7, crystalSurface.height, crystalSurface.width * 4);
  crystalPosition = new PVector(width * 0.5, height * 0.5, 0);

  stars = new PVector[100];
  for (int i=0; i<stars.length;i++) {
    stars[i] = new PVector(random(-(width * 2), (width * 2)), random(-(height * 2), (height * 2)), random(-5000));
  }
  starPosOffset = new PVector(random(-100, 100), random(-100, 100), random(-100, 100));
}

void draw() {
  background(0);

  /*
  beginCamera();
   camera();
   rotateY(map(mouseX,0,width,-PI, PI));
   translate(0,0,200);
   endCamera();
   */

  //linesInTheBack();
  starsInTheBack();


  crystalSurface.beginDraw();
  //crystalSurface.background(0);
  crystalSurface.blendMode(BLEND);
  crystalSurface.fill(0, 5);
  crystalSurface.rect(0, 0, crystalSurface.width, crystalSurface.height);

  if (frameCount % beat == 0) {
    crystalSurface.blendMode(ADD);

    crystalSurface.noStroke();
    for (int i=0; i<10;i++) {
      crystalSurface.fill(random(255), random(255), random(255));
      crystalSurface.beginShape();
      for (int j=0; j<3;j++) {
        crystalSurface.vertex(random(crystalSurface.width), random(crystalSurface.height));
      }
      crystalSurface.endShape();
    }
  }
  crystalSurface.endDraw();



  //drawCrystal();
  drawCrystal3D();

  //translate(0,0,10);
  //image(crystalSurface,width * 0.5,height*0.5);

  text(frameRate, 20, 20);
}

void drawCrystal() {

  crystalPosition.z = map(mouseY, height, 0, 500, -7000);

  noStroke();
  textureMode(NORMAL);

  // CRYSTAL ROMBOID
  beginShape();
  texture(crystalSurface);
  vertex(crystalPosition.x, crystalPosition.y - (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.25);
  vertex(crystalPosition.x + (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.75, 0.5);
  vertex(crystalPosition.x, crystalPosition.y + (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.75);
  vertex(crystalPosition.x - (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.25, 0.5);
  endShape(CLOSE);


  // CRYSTAL HIGHLIGHTS
  blendMode(ADD);
  // BRIGHT SIDE
  fill(255, 127);
  beginShape();
  vertex(crystalPosition.x, crystalPosition.y - (crystalSize.y * 0.5), crystalPosition.z + 1);
  vertex(crystalPosition.x + (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z + 1);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z);
  endShape(CLOSE);

  // NOT SO BRIGHT SIDES
  fill(127, 127);
  beginShape();
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z);
  vertex(crystalPosition.x + (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.75, 0.5);
  vertex(crystalPosition.x, crystalPosition.y + (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.75);
  endShape(CLOSE);
  beginShape();
  vertex(crystalPosition.x, crystalPosition.y - (crystalSize.y * 0.5), crystalPosition.z + 1);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z);
  vertex(crystalPosition.x - (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.25, 0.5);
  endShape(CLOSE);

  blendMode(BLEND);
}

void drawCrystal3D() {

  crystalPosition.z = map(mouseX, width, 0, 500, -7000);


  noStroke();
  //textureMode(NORMAL);

  // CRYSTAL ROMBOID 3D
  beginShape();
  texture(crystalSurface);
  vertex(crystalPosition.x, crystalPosition.y - (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.2);
  vertex(crystalPosition.x + (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.8, 0.5);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z + (crystalSize.z * 0.5), 0.5, 0.5);  
  endShape(CLOSE);

  beginShape();
  texture(crystalSurface);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z + (crystalSize.z * 0.5), 0.5, 0.5);
  vertex(crystalPosition.x + (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.8, 0.5);
  vertex(crystalPosition.x, crystalPosition.y + (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.8);
  endShape(CLOSE);

  beginShape();
  texture(crystalSurface);
  vertex(crystalPosition.x - (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.2, 0.5);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z + (crystalSize.z * 0.5), 0.5, 0.5);
  vertex(crystalPosition.x, crystalPosition.y + (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.8);
  endShape(CLOSE);


  beginShape();
  texture(crystalSurface);
  vertex(crystalPosition.x, crystalPosition.y - (crystalSize.y * 0.5), crystalPosition.z, 0.5, 0.2);
  vertex(crystalPosition.x, crystalPosition.y, crystalPosition.z + (crystalSize.z * 0.5), 0.5, 0.5);
  vertex(crystalPosition.x - (crystalSize.x * 0.5), crystalPosition.y, crystalPosition.z, 0.2, 0.5);
  endShape(CLOSE);
}

void linesInTheBack() {
  float lineX = 0;
  stroke(127);

  while (lineX < width * 2) {
    lineX += 20;
    line(lineX, 0, 0, lineX);
  }
}

void starsInTheBack() {

  // IT BEHAVES WEIRDLY, BUT IT'S A NICE ERROR

  fill(255);
  stroke(255);

  for (int i=0; i<stars.length; i++) {

    float x = lerp(stars[i].x, stars[i].x + starPosOffset.x, float(beat) / ((frameCount % beat) + 0.01));
    float y = lerp(stars[i].y, stars[i].y + starPosOffset.y, float(beat) / ((frameCount % beat) + 0.01));
    float z = lerp(stars[i].z, stars[i].z + starPosOffset.z, float(beat) / ((frameCount % beat) + 0.01));

    if (frameCount % beat == 0) {
      starPosOffset.set(random(-1000, 1000), random(-1000, 1000), random(-1000, 1000));
      stars[i].set(starPosOffset);
    }

    pushMatrix();
    translate(x, y, z);
    ellipse(0, 0, 5, 5);
    popMatrix();
    line(x, y, z, stars[i].x, stars[i].y, stars[i].z);
  }
}

void keyPressed() {

  if (key == 't' || key == 'T') {
    //something to tempo the shit
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
