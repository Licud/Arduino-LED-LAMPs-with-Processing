import processing.serial.*; // Import the  Serial library
Serial myPort;   // Name the serial port

// Intial variable declarations
int lampOne = 0;
int lampTwo = 0;
int xCoord1 = 55;
int xCoord2 = 340;
int colourBoxesWidth = 70; 
int colourBoxesHeight = 50; 
int optionBoxesWidth = 80; 
int optionBoxesHeight = 20; 
int colourArrayLampOne[] = new int [3]; 
int colourArrayPreviewLampOne[] = new int [3]; 
int colourArrayLampTwo[] = new int [3];
int colourArrayPreviewLampTwo[] = new int [3];
int lampOneIdentifier = 0;
int lampTwoIdentifier = 0;
boolean r1Select = false, g1Select = false, b1Select = false;
boolean r2Select = false, g2Select = false, b2Select = false;
PFont myFont; // Name the font object
String comPort = "COM5"; // Specify here the com port to be used

// Setup - Setup the GUI objects that won't be changed.
//=====================================================

void setup(){
  myPort = new Serial(this, comPort, 9600); // Give the Serial port details
  myFont = loadFont("Arial-BoldMT-12.vlw"); // Load the font
  textFont(myFont); // Specify the loaded font to be used.
  size(500, 500); // Set initial size of the main window.
  background(0); // Set the background colour of the main window.
  fill(255);
  rect(10, 10, 480, 480);
  rect(25, 30, 450, 225); // DMX 1 Control  Rectangle
  rect(25, 260, 450, 225); // DMX 2 Control Rectangle
  
  frameRate(60); // Specify the framerate here
  
// Rectangles that act as buttons for the program options
  
  rect(xCoord2, 80, optionBoxesWidth, optionBoxesHeight); // DMX 1 Manual Button
  rect(xCoord2, 110, optionBoxesWidth, optionBoxesHeight); // DMX 1 Manual Stop Button  
  rect(xCoord2, 160, optionBoxesWidth, optionBoxesHeight); // DMX 1 Auto Fade button
  rect(xCoord2, 190, optionBoxesWidth, optionBoxesHeight); // DMX 1 Auto change button
  rect(xCoord2, 220, optionBoxesWidth, optionBoxesHeight); // DMX 1 Auto RGB butoon
  
  rect(xCoord2, 310, optionBoxesWidth, optionBoxesHeight); // DMX 2 Manual Button
  rect(xCoord2, 340, optionBoxesWidth, optionBoxesHeight); // DMX 2 Manual Stop Button  
  rect(xCoord2, 390, optionBoxesWidth, optionBoxesHeight); // DMX 2 Auto Fade button
  rect(xCoord2, 420, optionBoxesWidth, optionBoxesHeight); // DMX 2 Auto change button
  rect(xCoord2, 450, optionBoxesWidth, optionBoxesHeight); // DMX 2 Auto RGB butoon
  
// Rectangles that allows the user to pick a colour (Manual mode).
  
  fill(255, 0, 0); // DMX 1 Red Rect
  rect(xCoord1, 75, colourBoxesWidth, colourBoxesHeight);

  fill(255, 0, 0); // DMX 2 Red Rect
  rect(xCoord1, 305, colourBoxesWidth, colourBoxesHeight);
  
  fill(0, 255, 0); // DMX 1 Green Rect
  rect(145, 75, colourBoxesWidth, colourBoxesHeight);
  
  fill(0, 255, 0); // DMX 2 Green Rect
  rect(145, 305, colourBoxesWidth, colourBoxesHeight);
  
  fill(0, 0, 255); // DMx 1 Blue  Rect
  rect(235, 75, colourBoxesWidth, colourBoxesHeight);
  
  fill(0, 0, 255); // DMx 1 Blue  Rect
  rect(235, 305, colourBoxesWidth, colourBoxesHeight);

// Texts for the GUI

  fill(0);
  text("DMX Control Panel", 18, 25);
  text("Lamp 1", 30, 45);     //DMX 1
  text("Red", xCoord1, 70);   //DMX 1
  text("Red", xCoord1, 300);  // DMX 2
  text("Green", 145, 70);     //DMX 1
  text("Green", 145, 300);    // DMX 2
  text("Blue", 235, 70);      //DMX 1
  text("Blue", 235, 300);     //DMX 2
  text("Manual Mode", xCoord2, 70); //DMX 1
  text("Manual Mode", xCoord2, 300); //DMX 2
  text("Manual", 360, 95);    //DMX 1
  text("Manual", 360, 325);   //DMX 2
  text("Stop", 365, 125);     //DMX 1
  text("Stop", 365, 355);     //DMX 2
  text("Automatic Mode", xCoord2, 150); //DMX 1
  text("Automatic Mode", xCoord2, 380); //DMX 2
  text("Auto-Fade", 353, 175);   //DMX 1
  text("Auto-Fade", 353, 405);   //DMX 2
  text("Auto-Change", 345, 205); //DMX 1
  text("Auto-Change", 345, 435); //DMX 2
  text("Auto-RGB", 353, 235);    //DMX 1
  text("Auto-RGB", 353, 465);    //DMX 1
  text("Lamp 2", 30, 275);       //DMX 2
  text("Adjust Brightness/Speed:", xCoord1, 155); //DMX 1
  text("Adjust Brightness/Speed:", xCoord1, 385); //DMX 2
  text("Preview:", xCoord1, 220); //DMX 1
  text("Preview:", xCoord1, 450); //DMX 2
}

// Draw method - include the objects that dynamically changes and the methods that require being called on a loop
//===============================================================================================================

void draw(){
  fill(colourArrayLampOne[0], colourArrayLampOne[1], colourArrayLampOne[2]);
  rect(xCoord1, 160, 256, 20); // Lamp 1 Colour Brightness
  
  fill(colourArrayLampTwo[0], colourArrayLampTwo[1], colourArrayLampTwo[2]);
  rect(xCoord1, 390, 256, 20); // Lamp 2 Colour Brightness
  
  fill(0);
  text(String.valueOf(lampOne), 110, 220); // Text value of current lamp one brightness / speed.
  text(String.valueOf(lampTwo), 110, 450); // text value of current lamp two brightness / speed.
  
  stroke(0);
  
  fill(colourArrayPreviewLampOne[0], colourArrayPreviewLampOne[1], colourArrayPreviewLampOne[2]);
  rect(150, 200, 100, 30); // Lamp 1 Colour Preview
  
  fill(colourArrayPreviewLampTwo[0], colourArrayPreviewLampTwo[1], colourArrayPreviewLampTwo[2]);
  rect(150, 430, 100, 30); // Lamp 2 Colour Preview
  
  stroke(255); // Apply white stroke to the lines below
  
  // Lines to indicate the location of the brightness/speed
  line(xCoord1 + lampOne,160,xCoord1 + lampOne,180); 
  line(xCoord1 + lampTwo,390,xCoord1 + lampTwo,410);
  
  // Method calls
 // sendLampOneValues(lampOneIdentifier); 
 // sendLampTwoValues(lampTwoIdentifier);
}

// Method to specify a rectangle location
// ======================================

boolean boxClickConfirmation (int xPosition, int yPosition, int width, int height){
    if (mouseX >= xPosition && mouseX <= xPosition+width && 
      mouseY >= yPosition && mouseY <= yPosition+height) {
    return true;
  } else {
    return false;
  }
}

// Method to specify that the brightness/speed bar is  being clicked
//==================================================================

boolean brightnessBoxClickConfirmation (int xPosition, int yPosition, int width, int height){
    if (mouseX >= xPosition && mouseX <= xPosition + 255 && 
      mouseY >= yPosition && mouseY <= yPosition+height) {
    return true;
  } else {
    return false;
  }
}

// mousePressed that allows the program to know what to do whenever a mouse is pressed
//====================================================================================

void mousePressed(){
  // Lamp 1, Red Box
  if(boxClickConfirmation(xCoord1, 75 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampOne(255, 0, 0); // Set the brightness bar to red
    r1Select = true; g1Select = false; b1Select = false; 
  }
  // Lamp 1, Green Box
  if(boxClickConfirmation(145, 75 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampOne(0, 255, 0); // Set the brightness bar to green.
    r1Select = false; g1Select = true; b1Select = false;
  }
  // Lamp 1, Blue Box
  if(boxClickConfirmation(235, 75 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampOne(0, 0, 255); // Set the brightness bar to blue.
    r1Select = false; g1Select = false; b1Select = true;
  }
  // Lamp 1, Manual Option
  if(boxClickConfirmation(xCoord2, 80, optionBoxesWidth, optionBoxesHeight) == true){
    lampOneIdentifier = 1;
  }
  // Lamp 1, Stop Option
  if(boxClickConfirmation(xCoord2, 110, optionBoxesWidth, optionBoxesHeight) == true){
    lampOneIdentifier = 0;
  }
  // Lamp 1, Auto-Fade Option
  if(boxClickConfirmation(xCoord2, 160, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampOne(0, 0, 0);
    setPreviewColourLampOne(0, 0);
    lampOneIdentifier = 2;
  }
  // Lamp 1, Auto-Change Option
  if(boxClickConfirmation(xCoord2, 190, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampOne(0, 0, 0);
    setPreviewColourLampOne(0, 0);
    lampOneIdentifier = 3;
  } 
  // Lamp 1, Auto-RGB Option
  if(boxClickConfirmation(xCoord2, 220, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampOne(0, 0, 0);
    setPreviewColourLampOne(0, 0);
    lampOneIdentifier = 4;
  }
  // Lamp 1, Brightness/Speed
  if(brightnessBoxClickConfirmation(xCoord1, 160, 256, 30) == true){
    
    lampOne = mouseX - xCoord1;
    
    if(r1Select == true){
      colourArrayLampOne[0] = lampOne;
      setPreviewColourLampOne(1, lampOne);
    }
    else if(g1Select == true){
      colourArrayLampOne[1] = lampOne;
      setPreviewColourLampOne(2, lampOne);
    }
    else if(b1Select == true){
      colourArrayLampOne[2] = lampOne;
      setPreviewColourLampOne(3, lampOne);
    }
  }
  
//========================================================================================

  // Lamp 2, Red Box
  if(boxClickConfirmation(xCoord1, 305 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampTwo(255, 0, 0); // Set the brightness bar to blue.
    r2Select = true; g2Select = false; b2Select = false;
  }
  // Lamp 2, Green Box
  if(boxClickConfirmation(145, 305 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampTwo(0, 255, 0); // Set the brightness bar to blue.
    r2Select = false; g2Select = true; b2Select = false;
  }
  // Lamp 2, Blue Box
  if(boxClickConfirmation(235, 305 ,colourBoxesWidth, colourBoxesHeight) == true){
    setManualColourLampTwo(0, 0, 255); // Set the brightness bar to blue.
    r2Select = false; g2Select = false; b2Select = true;
  }
  // Lamp 2, Manual Option
  if(boxClickConfirmation(xCoord2, 310, optionBoxesWidth, optionBoxesHeight) == true){
    lampTwoIdentifier = 1;
  }
  // Lamp 2, Stop Option
  if(boxClickConfirmation(xCoord2, 340, optionBoxesWidth, optionBoxesHeight) == true){
    lampTwoIdentifier = 0;
  }
  // Lamp 2, Auto-Fade Option
  if(boxClickConfirmation(xCoord2, 390, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampTwo(0, 0, 0);
    setPreviewColourLampTwo(0, 0); 
    lampTwoIdentifier = 2;
  }
  // Lamp 2, Auto-Change Option
  if(boxClickConfirmation(xCoord2, 420, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampTwo(0, 0, 0);
    setPreviewColourLampTwo(0, 0);
    lampTwoIdentifier = 3;
  }
  // Lamp 2, Auto-RGB Option
  if(boxClickConfirmation(xCoord2, 450, optionBoxesWidth, optionBoxesHeight) == true){
    r2Select = false; g2Select = false; b2Select = false;
    setManualColourLampTwo(0, 0, 0);
    setPreviewColourLampTwo(0, 0);
    lampTwoIdentifier = 4;
  }
  // Lamp 2, Brightness/Speed
  if(brightnessBoxClickConfirmation(xCoord1, 390, 256, 30) == true){
    lampTwo = mouseX - xCoord1;
    
    if(r2Select == true){
      colourArrayLampTwo[0] = lampTwo;
      setPreviewColourLampTwo(1, lampTwo);
    }
    else if(g2Select == true){
      colourArrayLampTwo[1] = lampTwo;
      setPreviewColourLampTwo(2, lampTwo);
    }
    else if(b2Select == true){
      colourArrayLampTwo[2] = lampTwo;
      setPreviewColourLampTwo(3, lampTwo);
    }
  }
}

// Methods to set the array colours
//================================

void setManualColourLampOne(int redColour, int greenColour, int blueColour){
  colourArrayLampOne[0] = redColour;
  colourArrayLampOne[1] = greenColour;
  colourArrayLampOne[2] = blueColour;
}

void setManualColourLampTwo(int redColour, int greenColour, int blueColour){
  colourArrayLampTwo[0] = redColour;
  colourArrayLampTwo[1] = greenColour;
  colourArrayLampTwo[2] = blueColour;
}

// Methods to set the array colours
//================================

void setPreviewColourLampOne(int id, int value){
  if (id == 1){
    colourArrayPreviewLampOne[0] = value;
  }
  else if (id == 2){
    colourArrayPreviewLampOne[1] = value;
  }
  else if (id == 3){
    colourArrayPreviewLampOne[2] = value;
  }
  else{
    colourArrayPreviewLampOne[0] = value;
    colourArrayPreviewLampOne[1] = value;
    colourArrayPreviewLampOne[2] = value;
  }
}

void setPreviewColourLampTwo(int id, int value){
  if (id == 1){
    colourArrayPreviewLampTwo[0] = value;
  }
  else if (id == 2){
    colourArrayPreviewLampTwo[1] = value;
  }
  else if (id == 3){
    colourArrayPreviewLampTwo[2] = value;
  }
  else{
    colourArrayPreviewLampTwo[0] = 0;
    colourArrayPreviewLampTwo[1] = 0;
    colourArrayPreviewLampTwo[2] = 0;
  }
}

// Method to set the DMX channel
//==============================

void setDmxChannel(int channel, int value) {
  myPort.write( str(channel) + "c" + str(value) + "w" );
}

// Method to identify and send values to the lamps
//================================================

void sendLampOneValues(int value){
  switch(value){
    case 0: 
      stopLampOne();
    break;
    
    case 1: 
      setDmxChannel(1, 32);
      setDmxChannel(2, colourArrayPreviewLampOne[0]);
      setDmxChannel(3, colourArrayPreviewLampOne[1]);
      setDmxChannel(4, colourArrayPreviewLampOne[2]);
    break;
    
    case 2: 
      setDmxChannel(1, 70);
      setDmxChannel(2, lampOne);
    break;
    case 3:
      setDmxChannel(1, 130);
      setDmxChannel(2, lampOne);
    break;
    
    case 4: 
      setDmxChannel(1, 200);
      setDmxChannel(2, lampOne);
    break;
    
    default:
      stopLampOne();
    break;
  }
}

void sendLampTwoValues(int value){
  switch(value){

    case 0: 
      stopLampTwo();
    break;
    
    case 1: 
      setDmxChannel(6, 32);
      setDmxChannel(7, colourArrayPreviewLampTwo[0]);
      setDmxChannel(8, colourArrayPreviewLampTwo[1]);
      setDmxChannel(9, colourArrayPreviewLampTwo[2]);
    break;
    
    case 2: 
      setDmxChannel(6, 70);
      setDmxChannel(7, lampTwo);
    break;
    case 3:
      setDmxChannel(6, 130);
      setDmxChannel(7, lampTwo);
    break;
    
    case 4: 
      setDmxChannel(6, 200);
      setDmxChannel(7, lampTwo);
    break;
    
    default:
      stopLampTwo();
    break;
  }
}

// Methods to stop the lamps

void stopLampOne(){
  setDmxChannel(1, 32);
  setDmxChannel(2, 0);
  setDmxChannel(3, 0);
  setDmxChannel(4, 0);
}

void stopLampTwo(){
  setDmxChannel(6, 32);
  setDmxChannel(7, 0);
  setDmxChannel(8, 0);
  setDmxChannel(9, 0);
}
