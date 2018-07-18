class TextLine {
  
  int n = 0;
  int t = millis();
  int tCursor = millis(); 
  int cadence = 60;
  int cadenceOffset = 0;
  int delay = 0;
  String text = "";
  String line = "";
  
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
    
    textAlign(LEFT, TOP);
    textSize(56);
    
    if(n < text.length() && millis()-t > cadence+cadenceOffset && (typing && millis()>delay)) {
      t = tCursor = millis();
      cadenceOffset = (text.charAt(n) == ' ') ? 60 : 0;
      line += text.charAt(n++);
    }
    
    text(((millis()-t)%500>250) ? line : line + '|', 30, 140);
    if(!ended && n >= text.length()) ended = true;

  }
  
  void clean() {
    line = "";
    n = 0;
  }
  
}