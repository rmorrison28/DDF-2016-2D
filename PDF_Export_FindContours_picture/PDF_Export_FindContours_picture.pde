/*
DDF 2016
 finds contours in a picture according to brightness and exports as PDF
 requires the OPENCV for Processing library installed
 move mouse to change the threshold
 click mouse to save contour as PDF
 press as many times as you want, you get a numbered PDF
 */


import gab.opencv.*;
import processing.pdf.*;
PImage src;
OpenCV opencv;
int count = 0;
ArrayList<Contour> contours;

void setup() {
  size(1200, 700);
}

void draw() {
  background (0);
  fill(255);
  if (mousePressed) {                                         // click mouse to start recording PDF
    beginRecord(PDF, "countour"+count++ +".pdf"); 
    noFill();                                                 // we want the PDF with outlines but no fill otherwise we will have double lines in VW or AI
  }

  src = loadImage("test.jpg");                                
  opencv = new OpenCV(this, src);
  opencv.gray();                                               // turn our pic to grayscale
  opencv.blur(5);                                              // blur it to smooth the details
  opencv.threshold(mouseX);                                     // turn to b&w in a threshold of the mouseX
                               
  contours = opencv.findContours();                             // tell opencv to find the contours and return as an array list

  for (Contour thisContour : contours) {                           // visit all elements of the array list "contour" naming each one as "thisContour"
    stroke(0);
    thisContour.draw();
  }
  endRecord();
}