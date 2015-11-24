import processing.video.*; //<>//

PVector[] stars;
PVector starPosOffset;

int lastTapBeat;
int beat;

CosmicCrystal crystal;
ArrayList<CosmicCrystal> tunnelCrystals;
int tunnelCrystalDisplayCount;

Movie organicColor; 

void setup() {
  size(800,800, P3D);
  textureMode(NORMAL);
  smooth();
  frame.setBackground(new java.awt.Color(0, 0, 0));

  beat = 360;
  lastTapBeat = 1;
 
  organicColor = new Movie(this, "organicColors.mov");
  organicColor.loop();

  crystal = new CosmicCrystal();
  crystal.setVelocity(new PVector(0, 0, 1));
  crystal.setRefreshRate(5000);

  stars = new PVector[100];
  for (int i=0; i<stars.length;i++) {
    stars[i] = new PVector(random(-(width * 2), (width * 2)), random(-(height * 2), (height * 2)), random(-5000));
  }
  starPosOffset = new PVector(random(-100, 100), random(-100, 100), random(-100, 100));

  tunnelCrystals = new ArrayList<CosmicCrystal>();
  for (int i=0; i< 5; i++) {
    CosmicCrystal newTunnelCrystal = new CosmicCrystal();
    newTunnelCrystal.setVelocity(new PVector(0, 0, random(10, 30)));
    newTunnelCrystal.setRefreshRate(300);
    tunnelCrystals.add(newTunnelCrystal);
  }
  tunnelCrystalDisplayCount = 0;

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
  starsInTheBack();

  //crystal.setImage(organicColor.get());
  crystal.update();
  crystal.render();

  for (int i=0; i<tunnelCrystalDisplayCount; i++) {
    tunnelCrystals.get(i).update();
    tunnelCrystals.get(i).render();
  }

  text(frameRate, 20, 20);
  
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

  if (key == 'c' || key == 'C') {
    if(tunnelCrystalDisplayCount < tunnelCrystals.size()-1) tunnelCrystalDisplayCount++;
    //println(tunnelCrystalDisplayCount);  
}

  if (key == 'q' || key == 'Q') {
    crystal.setVelocity(new PVector(0, 0, 0.2));
  }

  if (key == 'a' || key == 'a') {
    crystal.setVelocity(new PVector(0, 0, 20));
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
