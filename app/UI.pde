class UI {
  
  int currentStage = 0;
  String[] stages = { "intro", "code", "keyboard", "correct", "error" };
  
  String header = "";
  String footer = "";
  
  TextLine welcomeMessage;
  Button startButton;
 
  UI() {
    
    fill(0,255,0);
    textFont(ledFont);
    textAlign(CENTER, TOP);
    
    noFill();
    stroke(0,255,0);
    strokeWeight(2);
    
    welcomeMessage = new TextLine();
    startButton = new Button();
    
  }
  
  void show() {
    
    render();
    //filter(BLUR, 10);
    //render();
    
  }
  
  TextLine welcomeMessage(String text) {
    welcomeMessage.setText(text);
    return welcomeMessage;
  }
  
  private void render() {
    
    switch(currentStage) {
      case 0:
        welcomeMessage.type();
        startButton.display();
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
  
}