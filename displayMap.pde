public class displayMap extends PaperTouchScreen
{
  private PShape[] formes;
  public void settings()
  {
    setDrawingSize(A3BoardSize.x,A3BoardSize.y);
    loadMarkerBoard(Papart.markerFolder + "A3-default.svg",A3BoardSize.x,A3BoardSize.y);
    formes = bot.getChildren()[1].getChildren();
    //setDrawOnPaper();
  }
  
  public void setup(){}
  
  public void drawOnPaper()
  {
   background(0,0,200,100);
   shape(bot,0,0);
  }
  
  public PShape[] getFormes()
  {
    return this.formes;
  }
  
}