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
  
  color textColor = color(0,255,0);
  
  TextLine() {
     
  }
  
  TextLine(String _text) {
    text = _text;
  }
  
  void setText(String _text) {
    text = _text;
    clean();
  }
  
  void play() {
    typing = true;
    ended = false;
    delay = 0;
  }
  
  void play(int _delay) {
    play();
    delay = millis() + _delay;
  }
  
  void pause() {
    typing = false;
  }
  
  void type() {
    
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
  
  void backSpace() {
    if(text.length() > 0) {
      text = text.substring(0, text.length()-1);
      if(line.length() > text.length()) {
        line = text;
        n = text.length();
      }
    }
  }
  
  void align(int a) {
    align = valign = a;
  }
  
  void align(int h, int v) {
    align = h;
    valign = v;
  }
  
  float getWidth() {
    textSize(fontSize);
    return textWidth(text);
  }
  
  void clean() {
    ended = typing = false;
    line = "";
    n = 0;
  }
  
  void reset() {
    text = "";
    clean();
  }
}