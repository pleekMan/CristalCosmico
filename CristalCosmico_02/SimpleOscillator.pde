public class SimpleOscillator {

  public final static int SINE = 0;
  public final static int COSINE = 1;
  public final static int TANGENT = 2;
  public final static int RAMP = 3;

  int type;
  Timer timer;

  float waveValue;
  float value;

  public SimpleOscillator(int _type, int duration) {
    type = 0;
    type = _type;

    timer = new Timer();
    timer.setDuration(duration); // IN MILLISECONDS
  }


  public void update() {

    waveValue = map(timer.getCurrentTime(), 0, timer.getTotalTime(), 0, TWO_PI);
    //text("WaveValue: " + waveValue, 20, 60);

    switch(type) {
    case SINE:
      value = sin(waveValue);
      break;
    case COSINE:
      value = cos(waveValue);
      break;
    case TANGENT:
      value = tan(waveValue);
      break;
    case RAMP:
      value = map(waveValue, 0, TWO_PI, 0, 1);
      break;
    default:
      break;
    }
  }

  public float getValue() {
    return value;
  }
  public float getValueInRange(float _min, float _max) {
    return map(value, -PI, PI, _min, _max);
  }

  public float getValueSign() {
    return Math.signum(value);
  }
  public float getValueZeroToOne() {
    return type != RAMP ? (value + 1) * 0.5 : value;
  }

  public float getValueInverted() {
    if (type == RAMP) {
      return 1 - value;
    } 
    else {
      return value*-1;
    }
  }

  public void start() {
    timer.start();
  }

  public void setDuration(int _duration) {
    timer.setDuration(_duration);
  }
  public void setDurationInSeconds(float _duration) {
    timer.setDuration((int)(_duration * 1000));
  }
  public void setType(int _type) {
    type = _type;
  }

  public boolean isFinished() {
    return timer.isFinished();
  }
}  


///////////////////////////////////
////////// TIMER CLASS - MODIFIED ---------------------

public class Timer {

  int savedTime;
  int totalTime;
  int currentTime;
  Timer() {
    totalTime = 0;
  }

  public void setDuration(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  public void start() {
    savedTime = millis();
  }

  public boolean isFinished() {
    if (currentTime > totalTime) {
      start();
      return true;
    } 
    else {
      return false;
    }
  }

  public int getTotalTime() {
    return totalTime;
  }

  public int getCurrentTime() {
    currentTime = millis() - savedTime;
    isFinished();
    return currentTime;
  }
}
