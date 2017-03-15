
/**
* This class will be use for two things, display the map and check the positions of the fingers
*/
public class displayMap extends PaperTouchScreen
{
  private PShape[] formes;
  PImage fond;
  TouchList touchListe = new TouchList();
  ArrayList<TouchPoint> touchs2D = new ArrayList<TouchPoint>();
  XML xml;
  ttsMary TTS = new ttsMary();

  Map<String, String> shapeNameDesc = new HashMap<String, String>();
    
  public void settings()
  {
    setDrawingSize(A3BoardSize.x,A3BoardSize.y);
    loadMarkerBoard(Papart.markerFolder + "A3-default.svg",A3BoardSize.x,A3BoardSize.y);
    formes = bot.getChildren()[1].getChildren();
    fond = loadImage("fond.png");
    //setDrawOnPaper();
    parseSVG();
    println(shapeNameDesc);
  }
  
  public void setup()
  {
    
  }
  
  public void drawOnPaper()
  {

   background(0,0,200,100);
   image(fond,0,0,A3BoardSize.x,A3BoardSize.y);
   shape(bot,0,0,A3BoardSize.x,A3BoardSize.y);

   updateTouch();
   drawTouch();
   

  }
  
  public void checkPosition()
  {
     updateTouch();
     touchList = getTouchList();
     if(touchList.size()==1)
       for(Touch t : touchList)
       {
         String places;
         places = checkDistance(t.position);
         if(places != "")
           tts(places);
       }
     else
       tts("Plus d'un seul doigt détecté");
  }
  
  public void parseSVG()
  {

    
    xml = loadXML("map.svg");
    XML[] childrenG = xml.getChildren("g");
    XML[] childrenPath = {};
    XML[] rectPath = {};
    XML[] circlePath = {};
    for(int i = 0; i < childrenG.length;i++)
    {
     childrenPath = (XML[])concat(childrenPath, childrenG[i].getChildren("path"));
     rectPath = (XML[])concat(rectPath, childrenG[i].getChildren("rect"));
     circlePath = (XML[])concat(rectPath, childrenG[i].getChildren("circle"));
    }
    
    
    for(int i = 0;i<childrenPath.length;i++)
    {
     String desc = "Aucune description disponible";
     if(childrenPath[i].getChild("desc") != null)
     desc = childrenPath[i].getChild("desc").getContent();
     String name = childrenPath[i].getString("id");
     shapeNameDesc.put(name,desc);
    }
    
    for(int i = 0;i<rectPath.length;i++)
    {
     String desc = "Aucune description disponible";
     if(rectPath[i].getChild("desc") != null)
     desc = rectPath[i].getChild("desc").getContent();
     String name = rectPath[i].getString("id");
     shapeNameDesc.put(name,desc);
    }
    
    for(int i = 0;i<circlePath.length;i++)
    {
     String desc = "Aucune description disponible";
     if(circlePath[i].getChild("desc") != null)
     desc = circlePath[i].getChild("desc").getContent();
     String name = circlePath[i].getString("id");
     shapeNameDesc.put(name,desc);
    }
        
  }
  
  public String checkDistance(PVector pos)
  {
    String places = "";
    Screen screen = getScreen();
    PVector S = new PVector(0,0,0);
    PVector[] corners = screen.getCornerPos(getCameraTracking());
    println(corners[0]);
    for(int k = 0;k < formes.length;k++)
    {
      if(formes[k].getFamily() == 102)
      {
        float distance = 9999999;
        for(int i = 0;i < formes[k].getVertexCount()-1; i++)
        {
          float dist = SquaredDistancePointToLineSegment(formes[k].getVertex(i),formes[k].getVertex(i+1),pos,S);
          if(sqrt(dist) < distance)
          {
           distance = sqrt(dist);
          }
        }
        if(distance <=20)
        {
          places += shapeNameDesc.get(formes[k].getName());
        }
      }
      else if(formes[k].getKind() == RECT)
      {
        float x = formes[k].getParam(0);
        float y = formes[k].getParam(1);
        float width = formes[k].getParam(2);
        float height = formes[k].getParam(3);
        
        if(pos.x > x && pos.x < x + width && pos.y > y && pos.y < y + height)
        {
          places += " " + shapeNameDesc.get(formes[k].getName());
        }
        
      }
      else if(formes[k].getKind() == ELLIPSE)
      {
         float x = formes[k].getParam(0);
         float y = formes[k].getParam(1);
         float r = formes[k].getParam(2);
         
         if(Math.pow((pos.x - x),2) + Math.pow((pos.y - y),2) <= Math.pow(r,2))
         {
           places += " " + shapeNameDesc.get(formes[k].getName());
         }
        
      }
    }
    println(places);
    return places;
  }
  
  public PShape[] getFormes()
  {
    return this.formes;
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
  
}