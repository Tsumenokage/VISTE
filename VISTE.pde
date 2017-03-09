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
import java.util.*;

/**
* Papart variable
*/
Papart papart;

/**
* Pvector with contains A4 dimensions in mm //<>//
*/
PVector A4BoardSize = new PVector(297, 210);   //  29.7 * 21cm

/**
* Pvector with contains A3 dimensions in mm
*/
PVector A3BoardSize = new PVector(420, 297);   //  42 * 29.7 cm



PShape bot;
float ratioX;
float ratioY;

displayMap map;

/**
 * Initialization function
 */
public void setup()
{
  papart = Papart.projection(this); //Papart in projection mode
  papart.loadTouchInput(); 
  papart.loadSketches(); 
  papart.startTracking(); 
  bot = loadShape(sketchPath() + "/data/map.svg"); 
  map = new displayMap();

}

/**
* Define the settings of the software
*/
void settings()
{
  fullScreen(P2D);
}

/**
* We use this function as an event to launch the checkPosition function of displayMap
*/ 
void mouseClicked()
{
 map.checkPosition();
}