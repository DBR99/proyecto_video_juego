class Payaso {

  float x;
  float y;
  float puntos;
  int vida;
  //int estadoEscenario;

  // sprite --->
  PImage spriteSheetPayaso;
  PImage [][] movimiento;
  PImage payasoQuemado;
  boolean enMovimiento;
  int direccionActual;
  float imagenActual;


  final int  RIGHT = 0, LEFT =1, UP = 3, DOWN = 2;


  Payaso() {
    enMovimiento = false;
    direccionActual = 0;
    imagenActual = 0;
    puntos =5;
    vida = 3;
    // estadoEscenario = 2;
    x=250;
    y=250;
    setupSpritesPayaso();
  }


  //  MOV DERECHA (0,0,70,102);

  //  MOV IZQUIERDA (0,100,70,102);

  //MOV HACIA ABAJO - muñeco de frente  (0,200,70,102);

  // MOV ARRIBA - muñeco por detras  (0,302,70,103);


  void setupSpritesPayaso() {
    movimiento = new PImage[4][6];


    spriteSheetPayaso = loadImage("SpritePayasoCompleto5.png");
    for (int i = 0; i < 6; i++) {
      movimiento[0][i] = spriteSheetPayaso.get((53+20) * i, 0, 73, 98);
      movimiento[1][i] = spriteSheetPayaso.get((53+20) * i, 100, 73, 98);
      movimiento[2][i] = spriteSheetPayaso.get(78 * i, 200, 78, 102);
      movimiento[3][i] = spriteSheetPayaso.get(78 * i, 302, 78, 103);
    }
  }

  float getPosPayasoX () {
    return x;
  }

  float getPosPayasoY () {
    return y;
  }

  void setPosPayasoX (float posPayasoX) {
    x = posPayasoX;
  }

  void setPosPayasoY (float posPayasoY) {
    y = posPayasoY;
  }


  void setDecrementoPosPayasoX (float decremento) {
    x -= decremento;
  }

  void setDecrementoPosPayasoY (float decremento) {
    y -= decremento;
  }



  void drawPayaso() {

    if (enMovimiento) {
      image(movimiento[direccionActual][1 + int(imagenActual)], x, y);
    } else {
      image(movimiento[direccionActual][0], x, y);
    }
  }

  void drawPayasoQuemado(float posX, float posY) {
    payasoQuemado = spriteSheetPayaso.get(78 * 6, 200, 77, 102);
    image(payasoQuemado, posX, posY);
  }






  void actualizarDireccionPayaso(int xCambio, int yCambio) {
    imagenActual = (imagenActual + 0.2) % 5;
    enMovimiento = true;

    if (xCambio == 0 && yCambio == 0) {
      enMovimiento = false;
    } else if (xCambio == -1) {
      direccionActual = LEFT;
      //   println(direccionActual);
    } else if (xCambio == 1) {
      direccionActual = RIGHT;
      //   println(direccionActual);
    } else if (yCambio == -1) {
      direccionActual = UP;
      //    println(direccionActual);
    } else if (yCambio == 1) {
      direccionActual = DOWN;
      //  println(direccionActual);
    }

    x = x + xCambio;
    y = y + yCambio;
    validarLimites(xCambio, yCambio);
  }

  void validarLimites(int xCambio, int yCambio) {
     if (estadoEscenario==2) {
    if (validarLimitesEscenario2()==false) {
      x = x - xCambio;
      y = y - yCambio;
        }
    }
     if (estadoEscenario==3) {
    if (validarLimitesEscenario3()==false) {
      x = x - xCambio;
      y = y - yCambio;
        }
    }
         if (estadoEscenario==4) {
    if (validarLimitesEscenario4()==false) {
      x = x - xCambio;
      y = y - yCambio;
        }
    }
  }

  boolean validarLimitesEscenario2() {
    if ((x>=100 && x+51<=665 && y+70>=180 && y+91<= 400)||(y+62>=62 && y <=511 && x>130 && x+51<=530) || (x>=156 && x+51<=534 && y+70>=129 && y+91<=461)||(y<=479 && y+70>=63 
    && x>=235 && x+51<=623)) {
      return true;
    } else {
      return false;
    }
  }
   boolean validarLimitesEscenario3() {
    if ((x>=0 && x+60<=width && y+70>=0 && y+91<=height)) {
      return true;
    } else {
      return false;
    }
  }
     boolean validarLimitesEscenario4() {
    if ((x>=0 && x+60<=width && y+70>=0 && y+91<=height)) {
      return true;
    } else {
      return false;
    }
  }




  //-----------------------------------------------------VALIDACIONES DE ESCENARIOS
  boolean validarPasarEscenario3() {
    if (x + 51 >=376 && x + 51  <= 449 && y + 90 >=491 && y + 90<=517) {
      return true;
    } else {
      return false;
    }
  } 

  boolean validarPasarEscenario4() {
    if (x + 51 >=240 && x + 51  <= 589 && y + 90 >=553 && y + 85<=605) {
      return true;
    } else {
      return false;
    }
  } 

  boolean validarVolverEscenario3() {
    if (x + 51 >=294 && x + 51  <= 487 && y >=-5 && y + 85<=80) {
      return true;
    } else {
      return false;
    }
  } 
  boolean validarVolverEscenario2() {
    if (x + 51 >=301 && x + 51  <= 489 && y >=-5 && y + 86<=140) {
      return true;
    } else {
      return false;
    }
  } 
  //-------------------------------------------------------------

  //-------------------------------------------------------VALIDACIONES PUNTOS Y VIDAS

  void setPuntos(float incremento) {
    puntos += incremento;
  }

  void setVida(float decremento) {
    vida -= decremento;
  }

  float getPuntos() {
    return puntos;
  }

  int getVida() {
    return vida;
  }

  boolean validarGanar() {
    if (puntos >= 17 && x+51 >= 303 && x+51 <= 502 && y+91 >=200 && y+91<= 370 ) {
      return true;
    }
    return false;
  }


  boolean validarVida() {
    if (vida > 1) {
      return true;
    } else {
      return false;
    }
  }


  void drawPuntos() {
    textSize(32);
    fill(0, 102, 153);
    text(puntos, 660, 44);
  }
  void drawVida() {
    textSize(32);
    fill(0, 102, 153);
    text(vida, 610, 44);
  }
  //--------------------------------------------------------------------

 
}
