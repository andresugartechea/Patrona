/*
Name: Andres Ugartechea
Date: Dec 13, 2021
Title: Patrona
Description: Final Project for Decoding Nature class

*/

//library for video
import processing.video.*;
Capture cam; //webcam


//image selection
PImage front_img;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
int img_numb = 1;

//horitontal and vertical image strips
float sp_vert = 1;
float sp_hor = 1;

//equal distortion of the hue values of the image
int color_explosion = 0;//int(random(-10,10));
int color_explosion2 = 0;//int(random(-10,10));

//borders
int right_b = 0;
int down_b = 0;
int left_b = 0;
int upper_b = 0;
int shift = 100;

//r,g,b values divided by brightness/darkness
int darkest = 51;
int dark = 102;
int neutral = 153;
int bright = 204;
int brightest = 255;


//keyPressed
int display = 1;
int effect = 1;


////////

void setup(){
  size(1920, 1080);
  
  front_img = loadImage("front_img.png");
  img1 = loadImage("image"+1+".png");
  img2 = loadImage("image"+2+".png");
  img3 = loadImage("image"+3+".png");
  img4 = loadImage("image"+4+".png");
  
 
  //turn on webcam
  cam = new Capture(this, width, height);
  cam.start();
  
  
}

void draw() {
  background(0);
  
  color_explosion = int(map(mouseX,0,width, 1,20));
  color_explosion2 = int(map(mouseY,0,height, 1,5));

  loadPixels();
  
  //first_layer();
  if (effect==1){
    cam_eff();
  }
  else if (effect==2){
    background_eff();
  }
 

  
  if (display == 1){
      front_img();
  }
  
  updatePixels();


} 



void front_img(){
  front_img.loadPixels(); 
  //for reading all the pixels from the image
  for (int x = left_b; x < width-right_b; x += sp_vert){
    for (int y = upper_b; y < height-down_b; y += sp_hor){
      
      //displays image with margins
      int loc = x+y*width;

      
      //calls and separates r,g,b values of the image
      float r = red(front_img.pixels[loc]);
      float g = green(front_img.pixels[loc]);
      float b = blue(front_img.pixels[loc]);
  
   
      //changes hue
      if ((darkest<r) || (darkest<g) || (darkest<b)) {
        if (color_explosion2==2){
          r = r*0.5;
        }
        else if (color_explosion2==3){
          g = g*0.5;
        }
        else if (color_explosion2==4){
          b = b*0.5;
        }
        pixels[loc] = color(r, g, b);
      }
        
      //darkest parts
      else if ((r==1) || (g==1) || (b==1)) {

        b = b*color_explosion2;
        pixels[loc] = color(r, g, b)*color_explosion2;
      }
    }  
  }
}


void keyPressed() {
  if (key==' '){
    display = -display;
  }

  if (key == CODED) {
    
    //to change the effect
    if (keyCode == RIGHT) {
      if (effect<2){
        effect+=1;
      }
      else{
        effect=1;
      }
    }
    else if (keyCode == LEFT) {
      if (effect>1){
        effect-=1;
      }
      else{
        effect=2;
      }
    }
    
    
    ///to change image in background_eff
    if (effect==2){
      if ((keyCode == DOWN)) {
        if (img_numb<4){
          img_numb+=1;
        }
        else{
          img_numb=1;
        }
      }
      else if (keyCode == UP) {
        if (img_numb>1){
          img_numb-=1;
        }
        else{
          img_numb=4;
        }
      }
    }
    
    
  }
  
  
}

///EFFECTS

void cam_eff(){
  
  if (cam.available()){
    cam.read();
  }
  
  //Mirror image
  scale(-1,1);
  image(cam,-width,0);
  
  loadPixels();
  for (int x = 0; x < width; x += 1){
    for (int y = 0; y < height; y += 1){
      
      //displays image with margins
      int loc = x+y*width;
      
      //distorts image changing the hue values randomly
      pixels[loc] = pixels[loc]*color_explosion;
    }
  }
  updatePixels();
}


void background_eff(){
  if (img_numb ==1){
    img1.loadPixels();
    
    //for reading all the pixels from the image
    for (int x = left_b; x < width-right_b; x += sp_vert){ 
      for (int y = upper_b; y < height-down_b; y += sp_hor){
  
        //displays image with margins
        int loc = x+y*width;
        
        //distorts image changing the hue values randomly
        pixels[loc] = img1.pixels[loc]*color_explosion;
        
      }
    }
  }
  
  //changing the hue according to mouseY position
  else if (img_numb ==2){
    img2.loadPixels();
    for (int x = left_b; x < width-right_b; x += sp_vert){ 
      for (int y = upper_b; y < height-down_b; y += sp_hor){
        int loc = x+y*width;
        pixels[loc] = img2.pixels[loc]*color_explosion;      
      }
    }    
  }
  else if (img_numb ==3){
    img3.loadPixels();
    for (int x = left_b; x < width-right_b; x += sp_vert){ 
      for (int y = upper_b; y < height-down_b; y += sp_hor){
        int loc = x+y*width;
        pixels[loc] = img3.pixels[loc]*color_explosion;      
      }
    } 
  }
  else if (img_numb ==4){
    img4.loadPixels();
    for (int x = left_b; x < width-right_b; x += sp_vert){ 
      for (int y = upper_b; y < height-down_b; y += sp_hor){
        int loc = x+y*width;
        pixels[loc] = img4.pixels[loc]*color_explosion;      
      }
    } 
  }
}
