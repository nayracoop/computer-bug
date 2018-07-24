/* Fear Factor: Computer bug v0 */
/* @author nayra.coop */

import android.os.Bundle;
import android.view.WindowManager;
import android.view.View;

boolean DEV_MODE = false; 

int codeLength = 9;
int codeDuration = 4;
int maxAttempts = 3;

PFont  ledFont;
UI cb;

void setup() {
  
  //size(1280,800);
  orientation(LANDSCAPE);
  background(0);
  
  
  ledFont = createFont("led_counter-7.ttf", 96);
  textFont(ledFont);
  
  cb = new UI(codeLength, codeDuration, maxAttempts);
  
  cb.header = "************  FEAR FACTOR Access Terminal  ************";
  cb.footer = "*** WARNING ** Unauthorized Use Prohibited ** WARNING ***";
  cb.welcomeMessage.text = "Please press START to begin.";
  cb.startButton.text = "START";
  cb.directions.text = "Please record the following security\nverification code:";
  cb.numpadDirections.text = "Enter the security verification code.";
  cb.correctMessage.text = "CORRECT\nLOCK DEACTIVATED";
  cb.errorMessage.text = "***************\n*****ERROR*****\n***************";
  
  cb.start();
  
  if(!DEV_MODE) {
    getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
  }

}

void draw() {
  
  //background(0);
  smoothClear();
  
  cb.show();
  //filter(BLUR, 6);
  //ui.show();
  
}

void smoothClear() {
  //blendMode(SUBTRACT);
  fill(0,60);
  noStroke();
  rect(width/2,height/2,width,height);
  fill(0,255,0);
  stroke(0,255,0);
  noFill();
  //blendMode(BLEND);
}

void touchStarted() {
  cb.triggerInteractions();
}