class Globos {
  PVector pos;
  PVector posRA;
  PVector speed;
  PImage spriteSheetGlobos;
  float globoActual;
  PImage [][] movimiento;
  float imagenGlobo;

  Bombas bomba[];


  // globo rojo  (0,0,47,80);
  // globo muerte (0,80,47,80);

  Globos() {
    pos= new PVector (random(10, 700), random(300, 500));
    posRA= new PVector (random(10, 700), random(100, 200));
    speed = new PVector();
    globoActual = 0;
    setupSpritesGlobos();
  }

  void setupSpritesGlobos() {
    movimiento = new PImage[3][5];
    spriteSheetGlobos = loadImage("balones-03.png");
    for (int i = 0; i < 5; i++) {
      movimiento[0][i] = spriteSheetGlobos.get(47 * i, 0, 47, 80);
      movimiento[1][i] = spriteSheetGlobos.get(47 * i, 83, 47, 79);
      movimiento[2][i] = spriteSheetGlobos.get(47 * i, 166, 47, 79);
    }
  }


  void drawGloboRojo(float posPayasoX, float posPayasoY) {
    moverGlobo(posPayasoX, posPayasoY, 0.0001);
    for (int i = 0; i < 5; i++) {
      image(movimiento[0][1 + int(imagenGlobo)], posRA.x, posRA.y);
    }
  }

  void drawGloboMorado(float posPayasoX, float posPayasoY, float incremento) {
    moverGlobo(posPayasoX, posPayasoY, incremento);
    for (int i = 0; i < 5; i++) {
      image(movimiento[1][1 + int(imagenGlobo)], pos.x, pos.y);
    }
  }
  void drawGloboAzul(float posPayasoX, float posPayasoY) {
    moverGlobo(posPayasoX, posPayasoY, 0.001);
    for (int i = 0; i < 5; i++) {
      image(movimiento[2][1 + int(imagenGlobo)], posRA.x, posRA.y);
    }
  }

  void moverGlobo(float posPayasoX, float posPayasoY, float incremento) {

    imagenGlobo = (imagenGlobo + 0.1) % 4;
    if (limitar()) {
      if (pos.x >= posPayasoX && pos.y >= posPayasoY) {
        speed.x = -incremento;
        speed.y = -incremento;
        pos.x +=   speed.x;
        pos.y +=   speed.y;
      } else if (pos.x >= posPayasoX && pos.y <= posPayasoY ) {
        speed.x = -incremento;
        speed.y = incremento;
        pos.x +=   speed.x;
        pos.y +=   speed.y;
      } else if (pos.x <= posPayasoX && pos.y >= posPayasoY ) {
        speed.x = incremento;
        speed.y = -incremento;
        pos.x +=   speed.x;
        pos.y +=   speed.y;
      } else if (pos.x <= posPayasoX && pos.y <= posPayasoY) {
        speed.x = incremento;
        speed.y = incremento;

        pos.x +=   speed.x;
        pos.y +=   speed.y;
      }
    }
  }
  boolean validarColisionGlobosRA(float posPayasoX, float posPayasoY, int val) {
   // println("x",posRA.x,"y", posRA.y);
    if ((posPayasoX >= posRA.x-70  && posPayasoX <= posRA.x +20) && (posPayasoY + 90 >= posRA.y  && posPayasoY + 90 <=  posRA.y +83) && val==1) {
     // image(movimiento[0]pos.x[1 + int(imgenGlobo)], pos.x = -180, pos.y = -180);
     //posRA.x = -100;
     //posRA.y = -100;
      return true;
    }


    return false;
  }
   boolean validarColisionGlobosM(float posPayasoX, float posPayasoY) {
    println("x",pos.x,"y", pos.y);
    if ((posPayasoX >= pos.x-60  && posPayasoX <= pos.x +20) && (posPayasoY >= pos.y - 90  && posPayasoY+10  <=  pos.y+60)) {
     // image(movimiento[0]pos.x[1 + int(imgenGlobo)], pos.x = -180, pos.y = -180);
     //pos.x -= 0.5;
     //pos.y -= 0.5;
      return true;
    }


    return false;
  }


  float getPosGloboX() {
    return pos.x;
  }
  float getPosGloboY() {
    return pos.x;
  }

  //void seguirPayaso(int xCambio,int yCambio){


  //}




  boolean limitar() {
    if (pos.x >= 0 && pos.x <= 750 && pos.y < 540 ) {
      return true;
    }
    return false;
  }
}
