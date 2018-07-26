package coop.nayra.computerbug;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import android.os.Bundle; 
import android.view.WindowManager; 
import android.view.View; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class app extends PApplet {

/* Fear Factor: Computer bug v0 */
/* @author nayra.coop */





boolean DEV_MODE = false; 

int codeLength = 9;
int codeDuration = 4;
int maxAttempts = 1;

PFont  ledFont;
UI cb;

public void setup() {
  
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
}

public void draw() {
  
  //background(0);
  smoothClear();
  
  cb.show();
  //filter(BLUR, 6);
  //ui.show();
  
}

public void smoothClear() {
  //blendMode(SUBTRACT);
  fill(0,60);
  noStroke();
  rect(width/2,height/2,width,height);
  fill(0,255,0);
  stroke(0,255,0);
  noFill();
  //blendMode(BLEND);
}

public void touchStarted() {
  cb.triggerInteractions();
}
class Button {
  
  float x = 0;
  float y = 0;
  float fontSize = 90;
  String text = "";
  
  float lineHiehgt = 1.25f;
  float padding = 30;
  float touchArea = 60;
  
  float width = -1;
  float height = -1;
  
  boolean isTouched = false;
  int touchTime = millis();
 
  Button() {
    
  }
  
  Button(String _text) {
    text = _text;
  }
  
  public void display() {
    
    if(isTouched && millis()-touchTime > 100) isTouched = false;
    
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    textLeading(fontSize);
    
    float w = (width > 0) ? width : textWidth(text)+2*padding;
    float h = (height > 0) ? height : fontSize*lineHiehgt;
    
    if(isTouched) fill(0,255,0); 
    rectMode(CENTER);
    rect(x, y, w, h);
    
    if(isTouched) fill(0);
    text(text, x, y);
    
    if(isTouched) {
      fill(0,255,0);
      noFill();
      if(millis()-touchTime > 100) isTouched = false;
    }
    
  }
  
  public void autoSize() {
    width = -1;
    height = -1;
  }
  
  public boolean isTouched() {
    float[] rect = getRect();
    isTouched = false;
    touchTime = millis();
    for (int i = 0; i < touches.length; i++) if(touches[i].x > rect[0] && touches[i].x < rect[0] + rect[2] && touches[i].y > rect[1] && touches[i].y < rect[1] + rect[3]) isTouched = true;
    return isTouched;
  }
  
  private float[] getRect() {
    textSize(fontSize);
    float w = (width > 0) ? width : textWidth(text)+2*padding;
    float h = (height > 0) ? height : fontSize*lineHiehgt;
    float[] rect = new float[4];
    rect[2] = w+touchArea;
    rect[3] = h+touchArea;
    rect[0] = x-rect[2]/2;
    rect[1] = y-rect[3]/2;
    return rect;
  }
  
}
class Numpad {
  
  int keyWidth = 160;
  int keyHeight = 110;
  String[] keys = { "E\nN\nT\nE\nR", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Clr", "0", "Del" };
  Button[] buttons = new Button[keys.length];
  
  String input = "";
  
  Numpad() {
    
    float x = width/2 - 1.5f*keyWidth;
    float y = 330;
    for(int i = 0; i < keys.length; i++) {
      buttons[i] = new Button(keys[i]);
      buttons[i].fontSize = 82;
      buttons[i].touchArea = 0;
      if(i > 0) {
        buttons[i].width = keyWidth;
        buttons[i].height = keyHeight;
        buttons[i].x = x + (keyWidth*((i-1)%3));
        buttons[i].y = y;
        
        if(i%3 == 0 && i > 1) {
          y += keyHeight;
        }
      } else {
        buttons[i].width = keyWidth*0.75f;
        buttons[i].height = 4*keyHeight;
        buttons[i].x = x + 3*keyWidth;
        buttons[i].y = y + 1.5f*keyHeight;
      }
    }
    
  }
  
  public void display() {
    
    for(int i = 0; i < buttons.length; i++) {
      buttons[i].display();
    }
    
  }
  
  public String touch() {
    for(int i = 0; i < buttons.length; i++) {
      if(buttons[i].isTouched()) {
        return buttons[i].text;
      }
    }
    return "";
  }
  
  
}
class TextLine {
  
  float x = 30;
  float y = 120;
  int n = 0;
  int t = millis();
  int tCursor = millis(); 
  int rate = 60;
  int rateOffset = 0;
  int delay = 0;
  float fontSize = 56;
  float textLeading = -1;
  String text = "";
  String line = "";
  
  int align = LEFT;
  int valign = TOP;
  
  boolean cursor = true;
  boolean typing = false;
  boolean ended = false;
  
  int textColor = color(0,255,0);
  
  TextLine() {
     
  }
  
  TextLine(String _text) {
    text = _text;
  }
  
  public void setText(String _text) {
    text = _text;
    clean();
  }
  
  public void play() {
    typing = true;
    ended = false;
    delay = 0;
  }
  
  public void play(int _delay) {
    play();
    delay = millis() + _delay;
  }
  
  public void pause() {
    typing = false;
  }
  
  public void type() {
    
    fill(textColor);
    textAlign(align, valign);
    textSize(fontSize);
    if(textLeading > 0) textLeading(textLeading);
    
    if(n < text.length() && millis()-t > rate+rateOffset && (typing && millis()>delay)) {
      t = tCursor = millis();
      rateOffset = (text.charAt(n) == ' ') ? 2*rate : 0;
      line += text.charAt(n++);
    }
    
    text(((millis()-t)%700>300 || !cursor) ? line : line + '|', x, y);
    if(!ended && n >= text.length() && millis()-t > rate) ended = true;
    
    fill(0,255,0);
    noFill();

  }
  
  public void backSpace() {
    if(text.length() > 0) {
      text = text.substring(0, text.length()-1);
      if(line.length() > text.length()) {
        line = text;
        n = text.length();
      }
    }
  }
  
  public void align(int a) {
    align = valign = a;
  }
  
  public void align(int h, int v) {
    align = h;
    valign = v;
  }
  
  public float getWidth() {
    textSize(fontSize);
    return textWidth(text);
  }
  
  public void clean() {
    ended = typing = false;
    line = "";
    n = 0;
  }
  
  public void reset() {
    text = "";
    clean();
  }
}
class UI {
  
  int currentStage = 0;
  String[] stages = { "intro", "code", "numpad", "success", "error" };
  
  String header = "";
  String footer = "";
  
  int codeDuration = 5;
  int codeLength = 9;
  int maxAttempts = 3;
  int attempts = 0;
  
  TextLine welcomeMessage;
  Button startButton;
  
  TextLine directions;
  TextLine code;
  TextLine clock;
  
  TextLine numpadDirections;
  TextLine inputCode;
  Numpad numpad;
  
  TextLine correctMessage;
  TextLine errorMessage;
  
  int timeOut = 0;
  int timeStamp = 0;
 
  UI(int _codeLength, int _codeDuration, int _maxAttempts) {
    
    codeLength = _codeLength;
    codeDuration = _codeDuration;
    maxAttempts = _maxAttempts;
    
    welcomeMessage = new TextLine();
    
    startButton = new Button();
    startButton.x = width/2;
    startButton.y = height*0.6f;
  
    directions = new TextLine();
    
    code = new TextLine("1234");
    code.x = width/2;
    code.y = height/2;
    code.align(CENTER);
    code.fontSize = 130;
    code.rate = 0;
    code.cursor = false;
    
    clock = new TextLine();
    clock.x = width/2;
    clock.y = height*0.75f;
    clock.align(CENTER);
    clock.fontSize = 130;
    clock.rate = 1000;
    clock.cursor = false;
    clock.text = ("********************").substring(0, codeDuration-1);
    
    numpadDirections = new TextLine();
    numpadDirections.rate = 15;
    numpadDirections.y = 100;
    numpadDirections.cursor = false;
    
    inputCode = new TextLine();
    inputCode.y = 165;
    //inputCode.align(CENTER);
    inputCode.fontSize = 120;
    inputCode.rate = 0;
    
    numpad = new Numpad();
    
    correctMessage = new TextLine();
    correctMessage.align(CENTER, TOP);
    correctMessage.fontSize = correctMessage.textLeading = 120;
    correctMessage.y = height/2 - 150;
    correctMessage.x = width/2;
    correctMessage.cursor = false;
    
    errorMessage = new TextLine();
    errorMessage.align(CENTER);
    errorMessage.fontSize = errorMessage.textLeading = 120;
    errorMessage.y = height/2;
    errorMessage.x = width/2;
    errorMessage.cursor = false;
    errorMessage.rate = 0;
    errorMessage.textColor = color(255,0,0);
    
    fill(0,255,0);
    textAlign(CENTER, TOP);
    
    noFill();
    stroke(0,255,0);
    strokeWeight(2);

  }
  
  public void start() {
    setStage(0);
  }
  
  public void show() {
    
    render();
    //filter(BLUR, 10);
    //render();
    
  }
  
  public void setStage(int stage) {
    currentStage = stage;
    switch(currentStage) {
      case 0:
        welcomeMessage.clean();
        welcomeMessage.play(500);
      break;
      case 1:
        clock.clean();
        code.clean();
        
        directions.clean();
        directions.rate = (attempts == 0) ? 60 : 15;
        directions.play(250);
      break;
      case 2:
        
        numpadDirections.clean();
        numpadDirections.play(250);
        
        inputCode.text = code.text + "|";
        inputCode.x = width/2 - inputCode.getWidth()/2;
        inputCode.reset();
        inputCode.play(250);
        
        setTimeOut(60000);
      break;
      case 3:
        correctMessage.clean();
        correctMessage.play(250);
        setTimeOut(15000);
      break;
      case 4:
        errorMessage.clean();
        errorMessage.play(250);
        attempts++;
        if(maxAttempts == 1) setTimeOut(15000);
        else setTimeOut((attempts < maxAttempts) ? 2000 : 8000);
      break;
    }
  }
  
  public boolean timesUp() {
    return millis()-timeStamp >= timeOut; 
  }
  
  public void triggerInteractions() {
    
    switch(currentStage) {
      case 0:
        if(startButton.isTouched()) {
          generateCode();
          setStage(1);
          setTimeOut(50);
        }
      break;
      case 2:
        //println(numpad.touch());
        setTimeOut(60000);
        String value = numpad.touch();
        if(value.length() > 0) {
          if(value.charAt(0) >= '0' && value.charAt(0) <= '9') {
            if(inputCode.text.length() < codeLength) inputCode.text += value;
          } else if(value == "Clr") {
            inputCode.reset();
            inputCode.play();
          } else if(value == "Del") inputCode.backSpace();
          else if(inputCode.text.equals(code.text)) setStage(3);
          else setStage(4);
        }
      break;
      case 4:
        if(errorMessage.ended) {
          generateCode();
          setTimeOut(0);
          setStage(1);
        }
      break;
    }
    
  }

  private void render() {
    
    switch(currentStage) {
      case 0:
        welcomeMessage.type();
        startButton.display();
      break;
      case 1:
        directions.type();
        code.type();
        clock.type();
        if(directions.ended && !code.typing) code.play(200);
        if(code.ended && !clock.typing) clock.play(1000);
        if(clock.ended) setStage(2);
        if(!timesUp()) startButton.display();
      break;
      case 2:
        numpadDirections.type();
        inputCode.type();
        numpad.display();
        if(timesUp()) setStage(0);
      break;
      case 3:
        correctMessage.type();
        if(timesUp()) setStage(0);
      break;
      case 4:
        //if(attempts < maxAttempts || (!errorMessage.ended && millis()%1000 > 500)) {
          errorMessage.type();
        //}
        if(timesUp()) setStage((attempts < maxAttempts) ? 1 : 0);
      break;
    }
    
    textSize(38);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    
    /* HEADER */
    text(header, width/2, 40);
    rect(width/2, 40, width-60, 50);
    
    /* FOOTER */
    text(footer, width/2, height-40);
    rect(width/2, height-40, width-60, 50);
    
  }
  
  private void setTimeOut(int time) {
    timeOut = time;
    timeStamp = millis();
  }
  
  private void setTimeOut(float time) {
    timeOut = PApplet.parseInt(time*1000);
    timeStamp = millis();
  }
     
  private void generateCode() {
    code.reset();
    for(int i = 0; i < codeLength; i++) {
       code.text += PApplet.parseChar(PApplet.parseInt(random('0', '9')));
    }
    attempts = 0;
  }
  
}
}
