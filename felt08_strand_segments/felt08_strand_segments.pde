PVector D;
PVector []Di;
void setup(){
  size(400,400,P3D);
  D = new PVector(random(-1,+1),random(-1,+1),random(-1,+1));
  Di = new PVector[10];
  for(int i=0;i<10;i++){
   float sigma = 0.3; //值越小，毛線越直
   Di[i] = new PVector(
   randomGaussian()*sigma+D.x,
   randomGaussian()*sigma+D.y,
   randomGaussian()*sigma+D.z).normalize();
  }
}
void draw(){
 background(#FFFFF2);
 float x=200,y=200,z=0;
 for(int i=0;i<10;i++){
   float s=50;//毛線的長度
  line(x,y,z,x+Di[i].x*s,y+Di[i].y*s,z+Di[i].z*s);
  x+=Di[i].x*s;
  y+=Di[i].y*s;
  z+=Di[i].z*s;
 }
}
