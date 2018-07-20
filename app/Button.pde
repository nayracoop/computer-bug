class Button {
  
  float x = 0;
  float y = 0;
  float fontSize = 90;
  String text = "";
  
  float lineHiehgt = 1.25;
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
  
  void display() {
    
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
  
  void autoSize() {
    width = -1;
    height = -1;
  }
  
  boolean isTouched() {
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