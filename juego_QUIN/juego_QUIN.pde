int filas = 12; //<>//
int columnas = 12;
PImage globo;
PImage muro;
PImage balon;
PImage payaso;
int[][] cuadricula = new int[filas][columnas];

int payasoCx = 1;
int payasoCy = 1;




final int N_SPRITES_X = 3;
final int N_SPRITES_Y = 1;
final int TOTAL_SPRITES = N_SPRITES_X * N_SPRITES_Y;  


int current_sprite = 0;
int speed_x = 6;
int posi_x = 0;
int posi_y = 200;



// vector de todas la imagenes
PImage [] my_sprites;


int estadoPayaso;



void setup() {
  size(displayWidth, displayHeight);

  globo = loadImage("globoAzul.png");
  muro = loadImage("muro.png");
  balon = loadImage("balon.png");
  payaso = loadImage("quinfin.png");
  //Elementos en cuadricula:
  //1 = muros

  for (int fila = 0; fila < cuadricula.length; fila++) {
    for (int colum = 0; colum < cuadricula[fila].length; colum++) {

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


  mover();
  display_the_sprite();
  frameRate(5);

  //float payasoPx = payasoCx * (anchoCelda);
  //float payasoPy = payasoCy * (altoCelda);
  //image(payaso, payasoCx, payasoCy);
  if (keyPressed) { 
    if (key == 'd') {
      //  if (payasoCx < columnas-1 && cuadricula[payasoCy][payasoCx+1] != 0){

      move_the_sprite();
      payasoCx += 20;
    }

    if (key == 'a') {
      //if(payasoCx > 0 && cuadricula[payasoCy][payasoCx+1] != 0){
      //  payasoCx -= 3;
      move_the_sprite();
      payasoCx -= 10; 

      //}
    }
    if (key == 'w') {
      //if(payasoCy >0 && cuadricula[payasoCy-1][payasoCx] != 0){
      payasoCy -= 20 ;
      move_the_sprite();

      //}
    }
    if (key == 's') {
      //if(payasoCy < filas-1 && cuadricula[payasoCy+1][payasoCx]!=0){

      payasoCy += 20;
      move_the_sprite();


      // }
    }
  }
}


//se llena el arreglo
void mover() {

  my_sprites = new PImage[TOTAL_SPRITES];
  PImage my_sprite_sheet = loadImage("spritePayaso.png");

  int my_sprite_width = my_sprite_sheet.width / N_SPRITES_X;
  int my_sprite_height = my_sprite_sheet.height / N_SPRITES_Y;

  int index = 0;

  for (int y = 0; y < N_SPRITES_Y; y++) {
    for (int x = 0; x < N_SPRITES_X; x++) {
      my_sprites[index] = my_sprite_sheet.get(x * my_sprite_width, y * my_sprite_height, my_sprite_width, my_sprite_height);

      index++;
    }
  }
}







// consigue la imagen actual

void move_the_sprite() {
  current_sprite++;
  current_sprite %= TOTAL_SPRITES;
}

void display_the_sprite() {
  pushMatrix();
  image(my_sprites[current_sprite], payasoCx, payasoCy);
  popMatrix();
  pushMatrix();
  stroke(255);
  popMatrix();
}






////////////
