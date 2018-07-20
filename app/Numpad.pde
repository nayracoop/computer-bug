class Numpad {
  
  int keyWidth = 160;
  int keyHeight = 110;
  String[] keys = { "E\nN\nT\nE\nR", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Clr", "0", "Del" };
  Button[] buttons = new Button[keys.length];
  
  String input = "";
  
  Numpad() {
    
    float x = width/2 - 1.5*keyWidth;
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
        buttons[i].width = keyWidth*0.75;
        buttons[i].height = 4*keyHeight;
        buttons[i].x = x + 3*keyWidth;
        buttons[i].y = y + 1.5*keyHeight;
      }
    }
    
  }
  
  void display() {
    
    for(int i = 0; i < buttons.length; i++) {
      buttons[i].display();
    }
    
  }
  
  String touch() {
    for(int i = 0; i < buttons.length; i++) {
      if(buttons[i].isTouched()) {
        return buttons[i].text;
      }
    }
    return "";
  }
  
  
}