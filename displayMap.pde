public class displayMap extends PaperTouchScreen
{
  
  public void settings()
  {
    setDrawingSize(A4BoardSize.x,A4BoardSize.y);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg",A4BoardSize.x,A4BoardSize.y);
    setDrawOnPaper();
  }
  
  public void setup(){}
  
  public void drawOnPaper()
  {
   background(0,0,200,100);
   fill(0,100,0,100);
   rect(98.7f,140,101,12);    
  }
  
}