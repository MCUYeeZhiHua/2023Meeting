PVector[] v = new PVector[1000]; //有1000個點
int[][] density = new int[20][20]; //20*20的方格
void setup() {
  size(500, 500, P3D);
  for (int k=0; k<1000; k++) {
    v[k] = new PVector(randomGaussian()*50, randomGaussian()*50); //點的擴散範圍
    //從第20行，推算 float x = i*10-100, y = j*10-100;
    //移項變號，得到 i*10 = x+100, i = (x+100)/10;
    int i =int(v[k].x+100)/10, j = int(v[k].y+100)/10;
    if (i<0 || j<00 || i>=20 || j>=20) continue; //超出範圍(20*20方格)的時候跳開
    density[i][j]++; //每個點畫一次就在格子裡面標記+1
  }
}
void draw() {
  background(0);
  translate(width/2, height/2);
  //rotateY(radians(frameCount));
  for (int i=0; i<20; i++) {
    for (int j=0; j<20; j++) {
      float x=i*10-100, y=j*10-100; //x=i*長度+x位移量,y=i*長度+y位移量
      pushMatrix();
      translate(x, y);
      fill(255, 0, 0, density[i][j]*50);
      if (mousePressed) box(10);
      popMatrix();
    }
  }
  for (int k=0; k<1000; k++) {
    stroke(255); //先畫白色的點
    point(v[k].x, v[k].y, 10); //先畫白色的點

    stroke(255, 0, 0, Interpolate(v[k].x, v[k].y)*50);
    point(v[k].x, v[k].y, 10);
    //int i =int(v[k].x+100)/10, j = int(v[k].y+100)/10; //推算i,j
    //if(i<0 || j<00 || i>=20 || j>=20) stroke(255); //超過範圍不畫
    //else stroke(255,0,0, density[i][j]*50); //模仿剛剛畫格子的fill()值
    //point(v[k].x, v[k].y, 10); //再畫一次紅色的點
  }
}
float Interpolate(float x, float y) {
  for (int i=0; i<20-1; i++) {
    for (int j=0; j<20-1; j++) { //(x1,y1)、(x2,y2)是虛擬中心點的座標，+5使原本(x,y)變成中心點
      float x1 = i*10-100+5, y1 = j*10-100+5; //
      float x2 = (i+1)*10-100+5, y2 = (j+1)*10-100+5;
      if (x1<=x && x<x2 && y1<=y && y<y2) {
        return bilinear(x, y, x1, y1, x2, y2, i, j);
      }
    }
  }
  return 0;
}
float bilinear(float x, float y, float x1, float y1, float x2, float y2, int i, int j) {
  float alphaX = (x-x1)/(x2-x1), alphaY = (y-y1)/(y2-y1);
  float densityUp = density[i][j]*(1-alphaX) + density[i][j+1]*alphaX;
  float densityDown = density[i+1][j]*(1-alphaX) + density[i+1][j+1]*alphaX;
  float densityCenter = densityUp*(1-alphaY) + densityDown*alphaY;
  return densityCenter;
}
