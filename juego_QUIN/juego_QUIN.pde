int filas = 12;
int columnas = 12;
PImage globo;
PImage muro;
PImage balon;
PImage payaso;
int[][] cuadricula = new int[filas][columnas];

int payasoCx = 1;
int payasoCy = 1;


void setup() {
  size(800, 600);

  globo = loadImage("globoAzul.png");
  muro = loadImage("muro.png");
  balon = loadImage("balon.png");
  payaso = loadImage("payaso-05.png");
  //Elementos en cuadricula:
  //1 = muros

  for (int fila = 0; fila < cuadricula.length; fila++) {
    for (int colum = 0; colum < cuadricula[fila].length; colum++) {
      println("fila", fila);
      println("col", colum);
      if (fila == 0) {
        cuadricula[fila][colum] = 1;
      } else if (colum == 0) { 
        cuadricula[fila][colum] = 1;
        cuadricula[1][0] = 0;
      } else if (fila == 2 || fila == 7 ) {
        cuadricula[fila][2]=1;
        cuadricula[fila][3]=1;
        cuadricula[fila][4]=1;
      } else if (fila==4 && colum==5 ) {
        cuadricula[fila][colum] = 2;
      } else {
        cuadricula[fila][colum] = 0;
      }
    }
  }
}
void draw() {
  background(128);

  float anchoCelda = width/columnas;
  float altoCelda = height/filas;


  for (int fila = 0; fila < filas; fila++) {
    for (int col = 0; col < columnas; col++) {
      float celdaX = anchoCelda*col;
      float celdaY = altoCelda*fila;
      if (cuadricula[fila][col]==1) {
        image(muro, celdaX, celdaY);
      }
      if (cuadricula[fila][col]==2) {
        image(balon, celdaX, celdaY);
      }
    }
  }
  //float payasoPx = payasoCx * (anchoCelda);
  //float payasoPy = payasoCy * (altoCelda);
  image(payaso, payasoCx, payasoCy);
  if (keyPressed) { 
    if (key == 'd') {
    //  if (payasoCx < columnas-1 && cuadricula[payasoCy][payasoCx+1] != 0){
          payasoCx++;
    //}
   
      }
    
    if (key == 'a') {
      //if(payasoCx > 0 && cuadricula[payasoCy][payasoCx+1] != 0){
      payasoCx--;
      //}
    }
    if (key == 'w') {
      //if(payasoCy >0 && cuadricula[payasoCy-1][payasoCx] != 0){
      payasoCy--;
      //}
    }
    if (key == 's') {
      //if(payasoCy < filas-1 && cuadricula[payasoCy+1][payasoCx]!=0){
      payasoCy++;
     // }  
  }
  }
}

////////////
