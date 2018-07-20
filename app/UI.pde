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
    startButton.y = height*0.6;
  
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
    clock.y = height*0.75;
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
  
  void start() {
    setStage(0);
  }
  
  void show() {
    
    render();
    //filter(BLUR, 10);
    //render();
    
  }
  
  void setStage(int stage) {
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
        setTimeOut((attempts < maxAttempts) ? 2000 : 8000);
      break;
    }
  }
  
  boolean timesUp() {
    return millis()-timeStamp >= timeOut; 
  }
  
  void triggerInteractions() {
    
    switch(currentStage) {
      case 0:
        if(startButton.isTouched()) {
          setStage(1);
          generateCode();
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
    timeOut = int(time*1000);
    timeStamp = millis();
  }
     
  private void generateCode() {
    code.reset();
    for(int i = 0; i < codeLength; i++) {
       code.text += char(int(random('0', '9')));
    }
    attempts = 0;
  }
  
}