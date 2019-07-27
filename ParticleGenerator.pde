import controlP5.*;

int particle_num = 500;
ParticlesController controller;

ControlP5 cp5;
boolean bVisible = true;
String propertyFilePath = "property.json";

import processing.pdf.*;
 
boolean recording;
PGraphicsPDF pdf;

boolean bDrawScope = true;

void setup()
{
    background(255);
    size(800, 800);

    controller = new ParticlesController();
    controller.init(particle_num);
    controller.setPos();
    setGUI();

    cp5.saveProperties(propertyFilePath);
}

void draw() {
   background(255);
   controller.draw();
   if(bDrawScope) controller.drawScope();
}

void setGUI() {
    cp5 = new ControlP5(this);
    cp5.addSlider("Particle Num")
        .setLabel("Particle Num")
        .setColorLabel(0)
        .setPosition(20,20)
        .setSize(200, 20)
        .setRange(10, 2000)
        .setValue(200);
    cp5.addSlider("ParticleRadius")
        .setLabel("Particle Radius")
        .setColorLabel(0)
        .setPosition(20,40)
        .setSize(200, 20)
        .setRange(3, 50)
        .setValue(10);    
    cp5.addSlider("ParticleGray")
        .setLabel("Particle Gray")
        .setColorLabel(0)
        .setPosition(20,60)
        .setSize(200, 20)
        .setRange(0, 255)
        .setValue(130);    
    cp5.addSlider("ParticleAlpha")
        .setLabel("Particle Alpha")
        .setColorLabel(0)
        .setPosition(20,80)
        .setSize(200, 20)
        .setRange(0, 255)
        .setValue(130); 
    cp5.addSlider("Rect Margin")
        .setLabel("Rect Margin")
        .setColorLabel(0)
        .setPosition(20, 100)
        .setSize(200, 20)
        .setRange(3, 350)
        .setValue(100);
    cp5.addSlider("Ellipse Radius")
        .setLabel("Ellipse Radius")
        .setColorLabel(0)
        .setPosition(20, 120)
        .setSize(200, 20)
        .setRange(50, 500)
        .setValue(300);
    cp5.addSlider("distance thresh")
        .setLabel("Distance Thresh")
        .setColorLabel(0)
        .setPosition(20, 140)
        .setSize(200, 20)
        .setRange(0, 50)
        .setValue(0);
    cp5.addToggle("RectOrEllipse")
        .setLabel("Rect or Ellipse")
        .setColorLabel(0)
        .setPosition(20, 160)
        .setValue(true)
        .setSize(40, 20)
        .setMode(ControlP5.SWITCH);
}

void controlEvent(ControlEvent theEvent){
    if(theEvent.isController()){
        String event_name = theEvent.getController().getName();
        float event_value = theEvent.getController().getValue();
        print("control event from : " + event_name);
        println(", value : " + event_value);
        
        if(event_name == "Particle Num"){
            particle_num = int(event_value);
            controller.init(particle_num);
        }
        else if(event_name == "ParticleRadius"){
            controller.setParticleRadius(int(event_value));
        }
        else if(event_name == "ParticleGray") {
            controller.setParticleGray(int(event_value));
        }
        else if(event_name == "ParticleAlpha") {
            controller.setParticleAlpha(int(event_value));
        }
        else if(event_name == "Rect Margin") {
            controller.setRectMargin(int(event_value));
        }
        else if(event_name == "Ellipse Radius") {
            controller.setEllipseRadius(int(event_value));
        }
        else if(event_name == "distance thresh") {
            controller.setDistanceThresh(event_value);
        }
        else if(event_name == "RectOrEllipse") {
            controller.setMode(int(event_value));
        }
        
        controller.setPos();
    }
}

void resetAllSettings() {
    particle_num = 500;
    controller.setParticleRadius(10);
    controller.setParticleGray(130);
    controller.setParticleAlpha(130);
    controller.setRectMargin(100);
    controller.setEllipseRadius(350);
    controller.setDistanceThresh(0);

    cp5.loadProperties(propertyFilePath);
}

void keyPressed() {
  if (key == 's') {
    if (recording) {
      endRecord();
      println("Recording stopped.");
      recording = false;
    } else {
      String filename = "PDF/Particles-"+str(day()) + str(hour())+str(minute())+str(second())+".pdf";
      pdf = (PGraphicsPDF) createGraphics(width, height, PDF, filename);
      beginRecord(pdf);
      println("Recording started.");
      recording = true;
    }
  } else if (key == 'q') {
    if (recording) {
      endRecord();
    }
  }
  else if (key == 'g') {
      bVisible = !bVisible;
      cp5.setVisible(bVisible);
  }
  else if (key == 't') {
      bDrawScope = !bDrawScope;
  }
  else if (key == 'r') {
      resetAllSettings();
  }
}
