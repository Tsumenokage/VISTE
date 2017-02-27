public class displayMap extends PaperTouchScreen
{
  
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
   fill(100,0,0);
   rect(98.7f,140,101,12);    
  }
  
}