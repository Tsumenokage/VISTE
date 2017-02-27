public class displayMap extends PaperTouchScreen
{
  TrackedView boardView;
  PVector captureSize = new PVector((int) A4BoardSize.x-50, (int) A4BoardSize.y - 50);
  PVector origin = new PVector(50, 50);
  int picSize = 128;
  boolean isActivated = false;
  
  public void settings()
  {
    setDrawingSize(A4BoardSize.x,A4BoardSize.y);
    loadMarkerBoard(Papart.markerFolder + "A4-default.svg",A4BoardSize.x,A4BoardSize.y);
    setDrawOnPaper();
  }
  
  public void setup()
  {
    boardView = new TrackedView(this);
    boardView.setCaptureSizeMM(captureSize);
    boardView.setImageWidthPx(picSize);
    boardView.setImageHeightPx(picSize);
    boardView.setTopLeftCorner(origin);
    boardView.init();
  }
  
  public void drawOnPaper()
  {
   background(0,0,200,100);
   fill(0,100,0,100);
   rect(98.7f,140,101,12);    
  }
  
}