import processing.serial.*;
import java.util.ArrayList;

Serial myPort;
int hammyX, hammyY;
boolean buttonPressed = false;
boolean lastButtonState = false;  

boolean gameStarted = false;  
int timer = 60 * 1000;  // 1 min
int startTime;
boolean gameOver = false;

int spawnInterval = 1000;  // spawn 1s
int lastSpawnTime;

int analogMax = 4095;  // joystick analog max
int canvasSizeX = 800;
int canvasSizeY = 600;
int potVal = 0;  //value for potVal (did not end up using)

int maxFoods = 10;  // max food allowed on screen at once
ArrayList<Food> foods = new ArrayList<Food>();  // food objs (position and image)

int score = 0;  

float joystickSensitivity = 0.035;  // sensitivity for joystick

// hammy images and food images
PImage hammyChew, hammyEat, broccoliImage;
PImage[] foodImages = new PImage[8];  // store 8 food photos

void setup() {
  size(800, 600);  // Screen size

  // Load the images
  hammyChew = loadImage("pet-chew.png");
  hammyEat = loadImage("pet-eat.png");
  broccoliImage = loadImage("broccoli.png");
  
  // load 8 food imgs
  for (int i = 0; i < 8; i++) {
    foodImages[i] = loadImage("food" + (i + 1) + ".png");
  }

  // arduino serial port
  printArray(Serial.list());  // print list of available ports
  String portName = Serial.list()[3];  
  println("Connecting to: " + portName);
  myPort = new Serial(this, portName, 115200);  //  arduino baud rate: 115200

  // hammy initial pos
  hammyX = width / 2;
  hammyY = height / 2;

  textAlign(CENTER, CENTER);
  textSize(32);

  // start with 3 food on screen
  for (int i = 0; i < 3; i++) {
    spawnFood();
  }

  lastSpawnTime = millis();  // initial last spawn time
}

void draw() {
  background(200, 230, 255);  // blue sky background

  if (!gameStarted) {
    // start screen
    fill(0);
    text("Today is Hammy's cheat day!", width / 2, height / 2 - 160);  
    text("Help Hammy eat as much as he can", width / 2, height / 2 - 120);
    text("before he goes back to his gym bro diet!", width / 2, height / 2 - 80);
    text("Press the Button to Start", width / 2, height / 2);
    text("Use Joystick to Control Hammy", width / 2, height / 2 + 60);
    text("Press Button to Open His Mouth to Eat", width / 2, height / 2 + 100);

    //button press
    if (buttonPressed && !lastButtonState) {  // check button pressed not held
      println("Button pressed to start the game.");
      gameStarted = true;
      startTime = millis();  // Record the start time
    }

  } else if (gameStarted && !gameOver) {
    // Game is running
    int timeRemaining = timer - (millis() - startTime);  // time left calc

    if (timeRemaining <= 0) {
      gameOver = true;  // end game
    } else {
      // time left
      fill(0);
      text("Time: " + nf(timeRemaining / 1000, 2) + "s", width / 2, 50);

      //hammy png
      if (buttonPressed) {
        // hammy open mouth when button true
        image(hammyEat, hammyX - hammyEat.width, hammyY - hammyEat.height, hammyEat.width * 1.5, hammyEat.height * 1.5);
      } else {
        // hammy chew when button false
        image(hammyChew, hammyX - hammyChew.width, hammyY - hammyChew.height, hammyChew.width * 1.5, hammyChew.height * 1.5);
      }

      // food spawns every 1s 
      if (millis() - lastSpawnTime > spawnInterval) {
        // Randomly spawn 1 or 2 new food items (up to maxFoods limit)
        int newFoods = int(random(1, 2));  // Randomly generate 1 or 2
        for (int i = 0; i < newFoods && foods.size() < maxFoods; i++) {
          spawnFood();
        }
        lastSpawnTime = millis();  // reset last spawn time
      }

      checkFoods();

      if (buttonPressed) {
        eatFood();
      }
      
      //score display
      fill(0);
      text("Score: " + score, width / 2, 100);
    }

  } else if (gameOver) {
    // end screen
    fill(0);
    text("Time's Up!", width / 2, height / 2 - 40);
    text("Final Score: " + score, width / 2, height / 2);
    text("Press the button to play again", width / 2, height / 2 + 40);

    if (buttonPressed && !lastButtonState) {
      println("Button pressed to restart the game.");
      resetGame();  // reset game if button pressed
    }
  }


  lastButtonState = buttonPressed;
}

// spawn new food at random position with random food image
void spawnFood() {
  PImage foodImage = foodImages[int(random(0, 8))];  
  // 20% chance the food will be broccoli
  if (random(1) < 0.2) {
    foodImage = broccoliImage;
  } else {
    foodImage = foodImages[int(random(0, 8))];
  }
  
  Food newFood = new Food(random(50, width - 50), random(50, height - 50), foodImage);
  foods.add(newFood);  
}

// check and draw all food items
void checkFoods() {
  for (Food food : foods) {
    food.display();  
  }
}

// eat food if hammy close enough

// eat food if hammy close enough
void eatFood() {
  for (int i = foods.size() - 1; i >= 0; i--) {
    Food food = foods.get(i);
    if (dist(hammyX, hammyY, food.x, food.y) < 40) {  // if hammy close enough to eat
      foods.remove(i);  
      
      // Check if the eaten food is broccoli
      if (food.img == broccoliImage) {
        score--;  // Deduct a point if it's broccoli
      } else {
        score++;  // Increase score for regular food
      }

      // spawn 1-2 new food items after hammy eats
      int newFoods = int(random(1, 3));  
      for (int j = 0; j < newFoods && foods.size() < maxFoods; j++) {
        spawnFood(); 
      }
    }
  }
}


// reset game
void resetGame() {
  score = 0;  
  gameStarted = false;
  gameOver = false;
  spawnInterval = 1000;  
  foods.clear();  
  lastSpawnTime = millis();  

  for (int i = 0; i < 3; i++) {
    spawnFood();
  }
}

void serialEvent(Serial myPort) {
  // read serial data from arduino
  String data = myPort.readStringUntil('\n');
  if (data != null) {
    data = trim(data);
    String[] values = split(data, ',');

    // check for 5 values
    if (values.length == 5) {
      try {
        // parse joystick and button
        int xInput = int(values[0]);
        int yInput = int(values[1]);
        int zInput = int(values[2]); 
        int buttonState = int(values[3]);  
        potVal = int(values[4]);  

        // reduce sens by scaling joystick input
        hammyX += int((map(xInput, 0, analogMax, -canvasSizeX, canvasSizeX)) * joystickSensitivity);
        hammyY += int((map(yInput, 0, analogMax, -canvasSizeY, canvasSizeY)) * joystickSensitivity);

        // hammy stay in screen
        hammyX = constrain(hammyX, 0, width);
        hammyY = constrain(hammyY, 0, height);

        buttonPressed = (buttonState == 0 || zInput == 0);  

        //debug
        println("Button State: " + buttonPressed);
        println("Potentiometer Value: " + potVal);

      } catch (NumberFormatException e) {
        println("Error parsing values: " + e.getMessage());
      }
    } else {
      println("Incorrect data format. Expected 5 values, got: " + values.length); //check if info being processed properly
    }
  }
}

// store position and image of each food
class Food {
  float x, y;
  PImage img;

  Food(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    this.img = img;
  }

//scale food img
  void display() {

    image(img, x - 25, y - 25, 50, 50);  
  }
}
