
# Hammy’s Cheat Day

## About

### Description
Hammy’s Cheat Day is an interactive game where you guide Hammy, a very fit hamster, through his cheat day, munching on all the junk food he can before he’s back to his diet. With a joystick, you control Hammy’s movement across the screen, aiming to eat as much food as possible within a one-minute time limit. Hammy’s mouth opens when you press the button, allowing him to “eat” food. Points are added when Hammy eats regular food, but be careful! Eating broccoli deducts points.

### Tags

	•	Interactive Art
	•	Game Design
	•	Arduino
	•	Joystick Control
	•	Virtual Pet

### More Info
Read more on the blog!
https://gusty-tail-7d3.notion.site/Hammy-s-Cheat-Day-11c5621b054b80d39bd1f9b17f515c7d?pvs=74

## Preview

(GIF/video of gameplay to showcase the joystick control, Hammy’s animations, and point system)

## File Structure

 /arduino

	•	arduino.ino: Arduino code
  /game
  
 	•	game.pde: The main game code for Processing
	•	pet-chew.png, pet-eat.png: Images for Hammy’s animations
 	•	pet-happy.png, pet-sad.png, pet.png: Unused Images for Hammy’s animations
	•	broccoli.png, food1.png to food8.png: Images for food items
  /enclosure design

	•	Bottom Button Piece.stl: stl file for Bottom of Button Enclosure (3D Printed)
 	•	Bottom Joystick.stl: stl file for Bottom of Joystick Enclosure (3D Printed)
	•	Joystick Top.stl: stl file for Top of Button Enclosure (3D Printed)
	•	Top Button Piece.stl: stl file for Top of Button Enclosure (3D Printed)

README.txt: Project readme
mod2diagram.fzz: Fritzing Diagram of Circuit


## Installation & Setup

	1.	Hardware Setup
		•	Connect a joystick and button to your ESP32, following the wiring diagrams in mod2diagram.fzz file.
		•	Ensure the ESP32’s USB cable is connected to your computer.
	2.	Software Requirements
		•	Arduino IDE for uploading the serial communication code to the ESP32.
		•	Processing IDE for running the game’s graphical interface.
	3.	Upload Arduino Code
		•	Load the arduino_code.ino file onto your ESP32 using the Arduino IDE. This code sends joystick and button data to Processing.
	4.	Run the Processing Game
		•	Open main.pde in Processing and ensure the correct serial port is set in the code.
		•	Run the game and control Hammy using the joystick and button.

## Gameplay

### Objective
Control Hammy using the joystick, pressing the button to open his mouth and eat food. Avoid broccoli, as it will deduct points.
	2.	Scoring
	•	Regular food: +1 point
	•	Broccoli: -1 point
	3.	Time Limit
You have one minute to help Hammy eat as much as he can!

## Additional Documentation

See the blog post linked above for more in-depth project insights and information!
