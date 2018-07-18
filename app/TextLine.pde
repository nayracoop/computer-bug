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
  String text = "";
  String line = "";
  
  int align = LEFT;
  int valign = TOP;
  
  boolean cursor = true;
  boolean typing = false;
  boolean ended = false;
  
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
    
    textAlign(align, valign);
    textSize(fontSize);
    
    if(n < text.length() && millis()-t > rate+rateOffset && (typing && millis()>delay)) {
      t = tCursor = millis();
      rateOffset = (text.charAt(n) == ' ') ? 2*rate : 0;
      line += text.charAt(n++);
    }
    
    text(((millis()-t)%700>350 || !cursor) ? line : line + '|', x, y);
    if(!ended && n >= text.length() && millis()-t > rate) ended = true;

  }
  
  void align(int a) {
    align = valign = a;
  }
  
  void align(int h, int v) {
    align = h;
    valign = v;
  }
  
  void clean() {
    line = "";
    n = 0;
  }
  
}