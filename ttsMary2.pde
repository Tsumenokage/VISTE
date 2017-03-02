import http.requests.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import processing.sound.*;
void tts(String text)
{
  PostRequest post = new PostRequest("http://127.0.0.1:59125/process?");
  post.addData("INPUT_TEXT", text);
  post.addData("INPUT_TYPE", "TEXT");
  post.addData("LOCALE","fr");
  post.addData("VOICE","upmc-pierre-hsmm");
  post.addData("OUTPUT_TYPE","AUDIO");
  post.addData("AUDIO","WAVE");
  post.send();
  println("Reponse Content: " + post.getContent());
  println("Reponse Content-Length Header: " + post.getHeader("Content-Type"));
  
  byte[] bytesA = post.getContent().getBytes();
  Path path = Paths.get(sketchPath("data") + "/output.wav");
  try
  {
  Files.write(path,bytesA);
  
  SoundFile file = new SoundFile(this, "output.wav");
  file.rate(0.33);
  file.play();
  }catch (IOException e) {
         System.err.println(e);
  }
}