import fr.inria.papart.depthcam.*;
import fr.inria.papart.depthcam.devices.*;
import fr.inria.papart.depthcam.analysis.*;
import fr.inria.papart.tuio.*;

import fr.inria.papart.apps.*;
import fr.inria.papart.procam.*;
import fr.inria.papart.procam.display.*;
import fr.inria.papart.procam.camera.*;
import fr.inria.papart.calibration.*;
import fr.inria.papart.scanner.*;
import fr.inria.papart.utils.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.multitouch.metaphors.*;
import fr.inria.papart.tracking.*;
import org.bytedeco.javacpp.*;
import processing.opengl.*;
import org.reflections.*;
import toxi.geom.*;

import tech.lity.rea.svgextended.*;

Papart papart;

PVector A4BoardSize = new PVector(297, 210);   //  21 * 29.7 cm
PVector A3BoardSize = new PVector(420, 297);   //  21 * 29.7 cm



PShape bot;
float ratioX;
float ratioY;

displayMap map;

public void setup()
{
  papart = Papart.projection(this);
  papart.loadTouchInput();
  papart.loadSketches();
  papart.startTracking();
  bot = loadShape(sketchPath() + "/data/map.svg");
  ratioX = 3.5433*width/bot.getWidth();
  ratioY = 3.5433*height/bot.getHeight();

}

void settings()
{
  fullScreen(P3D);
}


void mouseClicked()
{
  float distance = 9999999;
  
  PShape[] formes = map.getFormes();
  for(int k = 0;k < formes.length;k++)
  {
    if(formes[k].getKind() == PATH)
    {
      for(int i = 0;i < formes[k].getVertexCount()-1; i++)
      {
        PVector mouse = new PVector(mouseX,mouseY,0);
        PVector S = new PVector(0,0,0);
        PVector newA = new PVector(formes[0].getVertexX(i)*ratioX, formes[0].getVertexY(i)*ratioY);
        PVector newB = new PVector(formes[0].getVertexX(i+1)*ratioX, formes[0].getVertexY(i+1)*ratioY);
        float dist = SquaredDistancePointToLineSegment(newA,newB,mouse,S);
        if(sqrt(dist) < distance)
        {
         distance = sqrt(dist);
        }
      }
    }
    
  }
  println(distance);
}

float SquaredDistancePointToLineSegment(PVector A, PVector B, PVector P, PVector S)
{
  float vx = P.x-A.x,   vy = P.y-A.y;   // v = A->P
  float ux = B.x-A.x,   uy = B.y-A.y;   // u = A->B
  float det = vx*ux + vy*uy; 

  if (det <= 0)
  { // its outside the line segment near A
    S.set(A);
    return vx*vx + vy*vy;
  }
  float len = ux*ux + uy*uy;    // len = u^2
  if (det >= len)
  { // its outside the line segment near B
    S.set(B);
    return sq(B.x-P.x) + sq(B.y-P.y);  
  }
  // its near line segment between A and B
  float ex = ux / sqrt(len);    // e = u / |u^2|
  float ey = uy / sqrt(len);
  float f = ex * vx + ey * vy;  // f = e . v
  S.x = A.x + f * ex;           // S = A + f * e
  S.y = A.y + f * ey;

  return sq(ux*vy-uy*vx) / len;    // (u X v)^2 / len
}