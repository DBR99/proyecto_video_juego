class Payaso {

  float x;
  float y;
  float puntos;
  int vida;
  int estadoEscenario;

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
    estadoEscenario = 2;
    x=200;
    y=200;
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




  void drawPayaso() {

    if (enMovimiento) {
      image(movimiento[direccionActual][1 + int(imagenActual)], x, y);
    } else {
      image(movimiento[direccionActual][0], x, y);
    }
  }

  void drawPayasoQuemado(float posX, float posY) {
    payasoQuemado = spriteSheetPayaso.get(78 * 6, 200, 78, 102);
    image(payasoQuemado, posX, posY);
  }






  void actualizarPosicionPayaso(int xCambio, int yCambio) {
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


    ////////////////////////////////////////////////////////////////////REVISAR
    // println(get(int(x), int(y)));
    // println(x, "Payaso ", y);
    validarLimites(xCambio, yCambio);
    if (x == 368 && y == 403) {
      y = 54;
    }
  }

  void validarLimites(int xCambio, int yCambio) {
    if (getEstadoEscenario()==2) {
      if (payasoEnLimiteEscenario2(x, y)) {
        x = x - xCambio;
        y = y - yCambio;
      }
    } else   if (getEstadoEscenario()==3) {
      if (payasoEnLimiteEscenario3(x, y)) {
        x = x - xCambio;
        y = y - yCambio;
      }
    }
  }




  boolean payasoEnLimiteEscenario2(float x, float y) {

    if (x <= 67 || y <= -37 || x >= 627 || y >= 404) {
      return true;
    } else if (x == 368 && y == 403) {
      estadoEscenario = 3;
    }
    return false;
  }
  boolean payasoEnLimiteEscenario3(float x, float y) {

    if (x <= 0 || y <= -37 || x >= width-53 || y >= height-80) {
      return true;
    }
    return false;
  }

  void setPuntos(float incremento) {
    puntos += incremento;
  }

  void setVida(float decremento) {
    vida -= decremento;
  }
  boolean validarVida() {
    if (vida >= 0) {
      return true;
    }
    return false;
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

  int getEstadoEscenario() {
    return estadoEscenario;
  }
}
