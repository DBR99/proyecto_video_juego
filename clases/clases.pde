import ddf.minim.*;
import processing.serial.*;
import processing.video.*;
Movie myMovie;



Serial myPort;

int val;



Payaso payaso;

//--------------Objetos Escenario 3
Globos globoRojo1E3;
Globos globoRojo2E3;
Globos globoRojo3E3;
Globos globoAzul1E3;
Globos globoAzul2E3;
Globos globoAzul3E3;
//_--------------------------


//-------------------Objetos Escenario 4
Globos globoRojo; 
Globos globoRojo2;
Globos globoAzul1; 
Globos globoAzul2; 
Globos globoMorado1;
Globos globoMorado2;
Globos globoMorado3;
Globos globoMorado4;
Globos globoMorado5;
Sogas sogas;
// -------------------------------------

Minim minim;
AudioPlayer intro;
AudioPlayer recogerCosas;
AudioPlayer globo;
AudioPlayer jugando;
AudioPlayer won;
AudioPlayer gameOver;
AudioPlayer caminar;



//----------------Escenarios
// 0 = video
// 1 = intro
// 2 = circo
// 3 = fuera circo
// 4 = escenario con sogas;
// 5 =  game over;
// 6 = won;
//7 = mision;
int estadoEscenario = 0;
int xMision=153;
int yMision=135;
boolean mostrarMision=true;

PImage escenario1;
PImage escenario2;
PImage escenario3;
PImage escenario4;
PImage escenario5;
PImage escenario6;
PImage mision;
//---------------------------

void setup() {
  size(800, 600);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);

  myMovie = new Movie(this, "intro comprimido.mp4");




  escenario1 = loadImage("escenario1.png");
  escenario2=loadImage("escenario2.png");
  escenario3=loadImage("escenario3.png");
  escenario4=loadImage("escenario4.png");
  escenario5=loadImage("gameOver.png");
  escenario6=loadImage("won.png");
  mision = loadImage("mision-07.png");


  payaso = new Payaso();
  //-----------Objetos escenario 3
  globoRojo1E3 = new Globos();
  globoRojo2E3 = new Globos();
  globoRojo3E3 = new Globos();
  globoAzul1E3 = new Globos();
  globoAzul2E3 = new Globos();
  globoAzul3E3 = new Globos();

  //---------Objetos escenario 4
  sogas = new Sogas();
  globoRojo = new Globos();
  globoRojo2 = new Globos();
  globoMorado1 = new Globos();
  globoMorado2 = new Globos();
  globoMorado3 = new Globos();
  globoMorado4 = new Globos();
  globoMorado5 = new Globos();
  globoAzul1 = new Globos();
  globoAzul2 = new Globos();
  //-----------------------------


  minim = new Minim(this);
  intro = minim.loadFile("intro.mp3");
  recogerCosas = minim.loadFile("recoger.mp3");
  globo = minim.loadFile("Globo.mp3");
  jugando = minim.loadFile("Thinking Music.mp3");
  won = minim.loadFile("won.wav");
  gameOver = minim.loadFile("GameOverCut.mp3");
  caminar = minim.loadFile("caminar.wav");
}

void serialEvent(Serial myPort) {
  val=myPort.read()-48;
  myPort.clear();
}

void movieEvent(Movie m) {
  m.read();
}


void draw() {
  myPort.write('0');
  dirMovimientoPayaso(val);


  println("estado escenario ", estadoEscenario);
  if (estadoEscenario == 0) {
    myPort.write('1');
    myPort.write('0');
    myPort.write('1');
    myMovie.play();
    image(myMovie, 0, 0);
    println(myMovie.time());
    if (myMovie.time() >= 38) {
      estadoEscenario=1;
    }
  }



  if (estadoEscenario == 1) {

    intro.play();
    background(escenario1); 
    if (val == 1) {
      println(val);
      estadoEscenario = 7;
      intro.pause();
    }
  } else if (estadoEscenario == 7) {
    background(escenario2);
    jugando.play();
    image(mision, xMision, yMision);
    println(val);
    if (val == 2 || val == 3) {
      estadoEscenario = 2;
    }
  } else if (estadoEscenario == 2) {
    background(escenario2);

    // jugando.play();
    payaso.drawPayaso();
    payaso.drawPuntos();
    payaso.drawVida();

    println(val);


    if (payaso.validarGanar() == true) {
      estadoEscenario = 6;
      background(escenario6);
      ganar(true);
      jugando.pause();
    }

    if (payaso.validarPasarEscenario3() == true) {
      estadoEscenario = 3;
      payaso.setPosPayasoY(55);
    }
  }
  // -------------------------------------------------------ESCENARIO 3
  else if (estadoEscenario == 3) {
    background(escenario3);

    payaso.drawPayaso();
    payaso.drawPuntos();
    payaso.drawVida();

    //--------------------------------------------------------------------------------------------GLOBOS ROJOS
    globoRojo1E3.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo1E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };

    globoRojo2E3.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo2E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };
    globoRojo3E3.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo3E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };

    //-----------------------------------------------------------------------------------------GLOBOS AZULES

    globoAzul1E3.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    if (globoAzul1E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };
    globoAzul2E3.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    if (globoAzul2E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };
    globoAzul3E3.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    if (globoAzul3E3.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };

    //-----------------------


    if (payaso.validarPasarEscenario4()==true) {
      estadoEscenario=4;
      payaso.setPosPayasoY(70);
    }
    if (payaso.validarVolverEscenario2() == true) {
      estadoEscenario=2;
      payaso.setPosPayasoY(398);
    }
  } 
  //-------------------------------------------------------- ESCENARIO 4
  else if (estadoEscenario == 4) {
    background(escenario4);

    payaso.drawPuntos();
    payaso.drawVida();

    //-------------------------------SOGAS

    sogas.drawSogas();


    // if (sogas.validarColision(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
    // payaso.setDecrementoPosPayasoX(0.8);
    //payaso.setDecrementoPosPayasoY(0.8);
    //};

    if (sogas.recogeSoga(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val)==true) {
      recogerCosas(true);
      payaso.setPuntos(0.5);
      myPort.write('1');
    };

    //------------------------------------------------------------------------------------------GLOBOS MORADOS

    payaso.drawPayaso();
    globoMorado1.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.4);
    globoMorado2.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.4);
    globoMorado3.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.3);
    globoMorado4.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.2);
    globoMorado5.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.1);

    if ( globoMorado1.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      myPort.write('2');

      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(368, 54);
      } else {
        estadoEscenario=5;
        perder(true);
      }
    };
    if ( globoMorado2.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      myPort.write('2');
      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(368, 54);
      } else {
        estadoEscenario=5;
        perder(true);
      }
    }





    if ( globoMorado3.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      myPort.write('2');

      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(368, 54);
      } else {
        estadoEscenario=5;
        perder(true);
      }
    };
    if ( globoMorado4.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      myPort.write('2');
      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(368, 54);
      } else {
        estadoEscenario=5;
        perder(true);
      }
    }
    if ( globoMorado5.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      myPort.write('2');
      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(368, 54);
      } else {
        estadoEscenario=5;
        perder(true);
      }
    }
    //--------------------------------------------------------------------------------------GLOBOS ROJOS
    //println(sogas.validarColision(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val));
    globoRojo.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };

    globoRojo2.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo2.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };

    //-----------------------------------------------------------------------------------------GLOBOS AZULES

    globoAzul1.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    globoAzul2.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    if (globoAzul1.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };
    if (globoAzul2.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {

      recogerGlobo(true);
      payaso.setPuntos(1);
      myPort.write('1');
    };




    if (payaso.validarVolverEscenario3()==true) {
      estadoEscenario=3;
      payaso.setPosPayasoY(458);
    }
  }

  if (estadoEscenario == 5) {
    background(escenario5);
  }
}




void dirMovimientoPayaso(int val) {
  int xCambio=0;
  int yCambio=0;
  // println(val);

  switch (val) {
  case 2:
    xCambio += 1;
    camina(true);
    break;
  case 3:
    xCambio -= 1;
    camina(true);
    break;
  case 4:
    yCambio -= 1 ;
    camina(true);
    break;
  case 5:
    yCambio += 1;
    camina(true);
    break;
  }
  payaso.actualizarDireccionPayaso(xCambio, yCambio);
}

void perder(boolean perder) {
  if (perder == true) {
    jugando.pause();
    gameOver.play();
    gameOver.rewind();
  } else {
    gameOver.pause();
  }
}

void ganar(boolean ganar) {
  if (ganar == true) {
    won.play();
    won.rewind();
  } else {
    won.pause();
  }
}

void camina(boolean camina) {
  if (camina == true) {
    caminar.play();
    caminar.rewind();
  } else {
    caminar.pause();
  }
}

void recogerGlobo(boolean tomarGlobo) {
  if (tomarGlobo == true) {
    globo.play();
    globo.rewind();
  } else {
    globo.pause();
  }
}


void recogerCosas(boolean recogerCosa) {
  if (recogerCosa == true) {
    recogerCosas.play();
    recogerCosas.rewind();
  } else {
    recogerCosas.pause();
  }
}
