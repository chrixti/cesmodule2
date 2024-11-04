
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

## Preview

(GIF/video of gameplay to showcase the joystick control, Hammy’s animations, and point system)

## File Structure

All files are organized into logical folders:

	•	/code
Contains all code for the project, including:
	•	main.pde: The main game code for Processing
	•	serialComms.pde: Serial communication code for interfacing with Arduino
	•	/assets
	•	/images
	•	pet-chew.png, pet-eat.png: Images for Hammy’s animations
	•	broccoli.png, food1.png to food8.png: Images for food items (each with a white background)
	•	/docs
	•	README.txt: Project readme
	•	blogLink.txt: Contains a link to the blog post for more info
	•	installation_instructions.txt: Additional instructions for setup and installation

## Installation & Setup

	1.	Hardware Setup
	•	Connect a joystick and button to your ESP32, following the wiring diagrams in installation_instructions.txt.
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

	1.	Objective
Control Hammy using the joystick, pressing the button to open his mouth and eat food. Avoid broccoli, as it will deduct points.
	2.	Scoring
	•	Regular food: +1 point
	•	Broccoli: -1 point
	3.	Time Limit
You have one minute to help Hammy eat as much as he can!

## Additional Documentation

See the blog post linked above for more in-depth project insights, additional installation steps, and troubleshooting tips.

