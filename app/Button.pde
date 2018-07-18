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
  
  int value;
 
  Button() {
    
  }
  
  Button(String _text) {
    text = _text;
  }
  
  void display() {
    
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    textLeading(fontSize);
    text(text, x, y);
    
    float w = (width > 0) ? width : textWidth(text)+2*padding;
    float h = (height > 0) ? height : fontSize*lineHiehgt;
    
    rectMode(CENTER);
    rect(x, y, w, h);
    
  }
  
  void autoSize() {
    width = -1;
    height = -1;
  }
  
  boolean isTouched() {
    float[] rect = getRect();
    for (int i = 0; i < touches.length; i++) if(touches[i].x > rect[0] && touches[i].x < rect[0] + rect[2] && touches[i].y > rect[1] && touches[i].y < rect[1] + rect[3]) return true;
    return false;
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