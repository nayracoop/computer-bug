class UI {
  
  int currentStage = 0;
  String[] stages = { "intro", "code", "keyboard", "correct", "error" };
  
  String header = "";
  String footer = "";
  
  int codeDuration = 5;
  
  TextLine welcomeMessage;
  Button startButton;
  
  TextLine directions;
  TextLine code;
  TextLine clock;
  
  TextLine numpadDirections;
  TextLine inputCode;
  Numpad numpad;
 
  UI() {
    
    fill(0,255,0);
    textFont(ledFont);
    textAlign(CENTER, TOP);
    
    noFill();
    stroke(0,255,0);
    strokeWeight(2);
    
    welcomeMessage = new TextLine();
    startButton = new Button();
    
    directions = new TextLine();
    //directions.rate = 40;
    
    code = new TextLine("625698441");
    code.x = width/2;
    code.y = height/2;
    code.align(CENTER);
    code.fontSize = 130;
    code.rate = 0;
    code.cursor = false;
    
    clock = new TextLine();
    clock.x = width/2;
    clock.y = height*0.75;
    clock.align(CENTER);
    clock.fontSize = 130;
    clock.rate = 1000;
    clock.cursor = false;
    
    numpadDirections = new TextLine();
    numpadDirections.rate = 15;
    numpadDirections.y = 100;
    numpadDirections.cursor = false;
    
    inputCode = new TextLine();
    inputCode.y = 200;
    inputCode.align(CENTER);
    inputCode.fontSize = 90;
    
    numpad = new Numpad();
    
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
  
  void triggerInteractions() {
    
    switch(currentStage) {
      case 0:
        if(startButton.isTouched()) {
          currentStage = 1;
          directions.play(250);
        }
      break;
      case 2:
        println(numpad.touch());
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
        if(clock.ended) {
          currentStage = 2;
          numpadDirections.play(250);
          inputCode.play(250);
        }
      break;
      case 2:
        numpadDirections.type();
        inputCode.type();
        numpad.display();
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