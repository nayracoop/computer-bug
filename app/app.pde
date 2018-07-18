/* Fear Factor: Computer bug v0 */
/* @author nayra.coop */

import android.os.Bundle;
import android.view.WindowManager;
import android.view.View;

boolean DEV_MODE = true; 

PFont  ledFont;
UI ui;

void setup() {
  
  //size(1280,800);
  orientation(LANDSCAPE);
  background(0);
  
  
  ledFont = createFont("led_counter-7.ttf", 96);
  
  ui = new UI();
  ui.header = "************  FEAR FACTOR Access Terminal  ************";
  ui.footer = "*** WARNING ** Unauthorized Use Prohibited ** WARNING ***";
  ui.welcomeMessage("Please press START to begin").play(1500);
  ui.startButton.text = "START";
  
  ui.startButton.x = width/2;
  ui.startButton.y = height*0.6;
  
  
  if(!DEV_MODE) {
    // Mantener pantalla encendida
    getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
  }

}

void draw() {
  
  background(0);
  //smoothClear();
  
  ui.show();
  //filter(BLUR, 6);
  //ui.show();
  
  
   
  
}

void smoothClear() {
  blendMode(SUBTRACT);
  rectMode(CORNER);
  fill(1);
  rect(0,0,width,height);
  blendMode(BLEND);
}

void touchStarted() {

  if(ui.startButton.isTouched()) ui.currentStage++;

}