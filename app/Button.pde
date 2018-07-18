class Button {
  
  float x = 0;
  float y = 0;
  float fontSize = 90;
  String text = "";
  
  float lineHiehgt = 1.25;
  float padding = 30;
  float touchArea = 60;
  
  float w = 0;
  float h = 0;
 
  Button() {
    
  }
  
  Button(String _text) {
    text = _text;
  }
  
  void display() {
    
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    text(text, x, y);
    
    rectMode(CENTER);
    rect(x, y, textWidth(text)+2*padding, fontSize*lineHiehgt);
    
  }
  
  boolean isTouched() {
    float[] rect = getRect();
    for (int i = 0; i < touches.length; i++) if(touches[i].x > rect[0] && touches[i].x < rect[0] + rect[2] && touches[i].y > rect[1] && touches[i].y < rect[1] + rect[3]) return true;
    return false;
  }
  
  private float[] getRect() {
    textSize(fontSize);
    float[] rect = new float[4];
    rect[2] = textWidth(text)+2*padding+touchArea;
    rect[3] = fontSize*lineHiehgt+touchArea;
    rect[0] = x-rect[2]/2;
    rect[1] = y-rect[3]/2;
    return rect;
  }
  
}