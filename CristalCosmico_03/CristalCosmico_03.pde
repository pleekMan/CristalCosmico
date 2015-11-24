 //<>//
import processing.video.*;

PVector[] stars;
PVector starPosOffset;
boolean enableShootingStars;

int lastTapBeat;
int beat;

CosmicCrystal crystal;
ArrayList<CosmicCrystal> tunnelCrystals;
int tunnelCrystalDisplayCount;

ArrayList<Ray> lightRays;
SimpleOscillator raysTimer;

float harpNoise;
float harpNoiseIncrement;

Movie organicColor;

void setup() {
  //size(800, 800, P3D);
  size(800, 800, P3D);

  textureMode(NORMAL);
  smooth();
  frame.setBackground(new java.awt.Color(0, 0, 0));

  beat = 360;
  lastTapBeat = 1;

  organicColor = new Movie(this, "organicColors.mov");
  organicColor.loop();

  // MAIN CRYSTAL
  crystal = new CosmicCrystal();
  crystal.setVelocity(new PVector(0, 0, 1));
  crystal.setRefreshRate(7000);

  //SHOOTING STARS
  enableShootingStars = false;
  stars = new PVector[150];
  for (int i=0; i<stars.length;i++) {
    //stars[i] = new PVector(random(-(width * 2), (width * 2)), random(-(height * 2), (height * 2)), random(-5000));
        stars[i] = new PVector(random(width), random(height), random(-5000));
  
}
  starPosOffset = new PVector(random(-100, 100), random(-100, 100), random(-100, 100));

  // OTHER CRYSTALS
  tunnelCrystals = new ArrayList<CosmicCrystal>();
  for (int i=0; i< 5; i++) {
    CosmicCrystal newTunnelCrystal = new CosmicCrystal();
    newTunnelCrystal.setVelocity(new PVector(0, 0, random(10, 30)));
    newTunnelCrystal.setRefreshRate(1000);
    tunnelCrystals.add(newTunnelCrystal);
  }
  tunnelCrystalDisplayCount = 0;

  // LIGHT RAYS
  raysTimer = new SimpleOscillator(SimpleOscillator.RAMP, int(random(3000, 20000)));
  lightRays = new ArrayList<Ray>();
  for (int i=0; i<50; i++) {
    Ray newLightRay = new Ray(raysTimer);

    PVector start = new PVector(random(-500, 500), random(-500, 500), 200);
    PVector end = new PVector(0, 0, -5000);

    newLightRay.setPositions(start, end);
    newLightRay.start();

    lightRays.add(newLightRay);
  }

  harpNoise = random(1);
  harpNoiseIncrement = 0.005;
}

void draw() {
  background(0);

  //lights();
  //float dirLightX = map(mouseX,0,width,-500,500);
  //float dirLightY = map(mouseY,0,height,-500,500);  

  ambientLight(255, 255, 255);
  directionalLight(random(255), random(255), random(255), -1.5, 0.8, 1);

  /*
  beginCamera();
   camera();
   rotateY(map(mouseX,0,width,-PI, PI));
   translate(0,0,200);
   endCamera();
   */

  /*
  hint(DISABLE_DEPTH_TEST);
   tint(255,127);
   image(organicColor,0,0,width,height);
   hint(ENABLE_DEPTH_TEST);
   */

  //linesInTheBack();
  if(enableShootingStars)starsInTheBack();

  pushMatrix();
  translate(width * 0.5, height * 0.5);

  // MAIN CRYSTAL
  //crystal.setImage(organicColor.get());
  crystal.update();
  crystal.render();

  // TUNNEL CRYSTALS
  for (int i=0; i<tunnelCrystalDisplayCount; i++) {
    tunnelCrystals.get(i).update();
    tunnelCrystals.get(i).render();
  }

  // LIGHT RAYS [FUGUE STATE]
  /*
  for (int i=0; i<lightRays.size(); i++) {
   lightRays.get(i).update();
   lightRays.get(i).render();
   }
   */

  //LIGHT RAYS [HARP STATE]
  float raySeparation = 1000.0 / lightRays.size();

  float posY = map(noise(harpNoise), 0, 1, -500, 500);
  PVector start = new PVector(-500, posY, 200);
  PVector end = new PVector(-500, posY, -5000);
  lightRays.get(0).setPositions(start, end);

  for (int i=lightRays.size()  - 1; i > 0; i--) {
    float posX = (raySeparation * i) - 500;
    PVector localStart = new PVector(posX, lightRays.get(i-1).startPos.y, lightRays.get(i-1).startPos.z);    
    PVector localEnd = new PVector(posX, lightRays.get(i-1).endPos.y, lightRays.get(i-1).endPos.z);    

    lightRays.get(i).setPositions(localStart, localEnd);
  }
  for (int i=0; i<lightRays.size(); i++) {
    lightRays.get(i).update();
    lightRays.get(i).render();
  }

  harpNoise += harpNoiseIncrement;

  popMatrix();

  //text(frameRate, 20, 20);
}

void movieEvent(Movie m) {
  m.read();
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

    float x = lerp(stars[i].x, stars[i].x + starPosOffset.x, float(beat) / ((frameCount % beat)));
    float y = lerp(stars[i].y, stars[i].y + starPosOffset.y, float(beat) / ((frameCount % beat)));
    float z = lerp(stars[i].z, stars[i].z + starPosOffset.z, float(beat) / ((frameCount % beat)));

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

  if (key == 'd' || key == 'd') {
    if (tunnelCrystalDisplayCount > 0) tunnelCrystalDisplayCount--;
    //println(tunnelCrystalDisplayCount);
  }
  if (key == 'c' || key == 'C') {
    if (tunnelCrystalDisplayCount < tunnelCrystals.size()-1) tunnelCrystalDisplayCount++;
    //println(tunnelCrystalDisplayCount);
  }

  if (key == 'q' || key == 'Q') {
    crystal.setVelocity(new PVector(0, 0, 0));
  }
  if (key == 'a' || key == 'A') {
    crystal.setVelocity(new PVector(0, 0, 1));
  }

  if (key == 'z' || key == 'Z') {
    crystal.setVelocity(new PVector(0, 0, 20));
  }

  if (key == 'g' || key == 'G') {
    enableShootingStars = !enableShootingStars;
  }

  if (key == ' ') {
    crystal.triggerRefresh();
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
