PVector[] v = new PVector[1000];
int[][] density = new int[20][20];
void setup() {
  size(500, 500, P3D);
  for (int k=0; k<1000; k++) {
    v[k] = new PVector(randomGaussian()*50, randomGaussian()*50);
    //從第20行，推算 float x = i*10-100, y = j*10-100;
    //移項變號，得到 i*10 = x+100, i = (x+100)/10;
    int i =int(v[k].x+100)/10, j = int(v[k].y+100)/10;
    if(i<0 || j<00 || i>=20 || j>=20) continue;
    density[i][j]++;
  }
}
void draw() {
  background(0);
  translate(width/2, height/2);
  //rotateY(radians(frameCount));
  for (int i=0; i<20; i++) {
    for (int j=0; j<20; j++) {
      float x=i*10-100, y=j*10-100;
      pushMatrix();
      translate(x, y);
      fill(255,0,0,density[i][j]*50);
      if(mousePressed) box(10);
      popMatrix();
    }
  }
  for (int k=0; k<1000; k++){
    stroke(255); //先畫白色的點
    point(v[k].x, v[k].y, 10);
    
    int i =int(v[k].x+100)/10, j = int(v[k].y+100)/10;
    if(i<0 || j<00 || i>=20 || j>=20) stroke(255);
    else stroke(255,0,0, density[i][j]*50);
    point(v[k].x, v[k].y, 10);
  }
}
/*
color Interpolate(int i, int j){
  density[i][j];
  color c = #FF0000;
  return c;
}*/
