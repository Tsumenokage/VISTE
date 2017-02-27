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

Papart papart;

PVector A4BoardSize = new PVector(297, 210);   //  21 * 29.7 cm
PVector A3BoardSize = new PVector(420, 297);   //  21 * 29.7 cm

public void setup()
{
  papart = Papart.projection(this);
  papart.loadTouchInput();
  papart.loadSketches();
  papart.startTracking();
}

void settings()
{
  size(640,480,P3D); 
}