public class displayMap extends PaperTouchScreen
{
 
  PShape bot = loadShape("Map.svg");
  public void settings()
  {
    setDrawingSize(A3BoardSize.x,A3BoardSize.y);
    loadMarkerBoard(Papart.markerFolder + "A3-default.svg",A3BoardSize.x,A3BoardSize.y);
    //setDrawOnPaper();
  }
  
  public void setup(){}
  
  public void drawOnPaper()
  {
   background(0,0,200,100);
   shape(bot,0,0);
  }
  
}