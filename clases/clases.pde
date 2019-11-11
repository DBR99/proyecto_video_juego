import ddf.minim.*;
import processing.serial.*;


Serial myPort;

int val;
int valArduino;

Payaso payaso;
Globos globoRojo; 
Globos globoRojo2;
Globos globoAzul; 
Globos globoMorado1;
Globos globoMorado2;
Sogas sogas;


Minim minim;
AudioPlayer intro;


//------Escenarios
// 0 = video
// 1 = intro
// 2 = circo
// 3 = fuera circo
// 4 = escenario con sogas;
// 5 =  game over;
// 6 = won;
int estadoEscenario = 1;
PImage escenario1;
PImage escenario2;
PImage escenario3;
PImage escenario4;
PImage escenario5;
PImage escenario6;

void setup() {
  size(800, 600);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);


  escenario1 = loadImage("escenario1.png");
  escenario2=loadImage("escenario2.png");
  escenario3=loadImage("escenario3.png");
  //escenario4=loadImage("escenario4.png");
  escenario5=loadImage("gameOver.png");
  escenario6=loadImage("won.png");

  sogas = new Sogas();
  payaso = new Payaso();
  globoRojo = new Globos();
  globoRojo2 = new Globos();
  globoMorado1 = new Globos();
  globoMorado2 = new Globos();
  globoAzul = new Globos();



  minim = new Minim(this);
  intro = minim.loadFile("intro.mp3");
}

void serialEvent(Serial myPort) {
  val=myPort.read()-48;
  myPort.clear();
}


void draw() {

  //println(val);
  dirMovimientoPayaso(val);
  if (estadoEscenario == 1) {
    intro.play();
    background(escenario1);
    if (val == 1) {
      estadoEscenario = 2;
      intro.pause();
    }
  } else if (estadoEscenario == 2) {
    background(escenario2);
    payaso.drawPayaso();
    payaso.drawPuntos();
    payaso.drawVida();
    estadoEscenario = payaso.getEstadoEscenario();
  } else if (estadoEscenario == 3) {
    background(escenario3);
    
    payaso.drawPuntos();
    payaso.drawVida();


    // println( (sogaAux.recogeSoga(payaso.getPosPayasoX(), payaso.getPosPayasoY())));

    sogas.drawSogas();
    if (sogas.validarColision(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val)==true) {
      payaso.setPuntos(0.5);
    };
    //println(sogas.validarColision(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val));
    globoRojo.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {
      payaso.setPuntos(1);
    };

    globoRojo2.drawGloboRojo(payaso.getPosPayasoX(), payaso.getPosPayasoY()); 
    if (globoRojo2.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {
      payaso.setPuntos(1);
    };

    globoAzul.drawGloboAzul(payaso.getPosPayasoX(), payaso.getPosPayasoY());
    if (globoAzul.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY(), val) == true) {
      payaso.setPuntos(1);
    };



    //  println( globoRojo.validarColisionGlobosRA(payaso.getPosPayasoX(), payaso.getPosPayasoY()));
    globoMorado1.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.3);
    globoMorado2.drawGloboMorado(payaso.getPosPayasoX(), payaso.getPosPayasoY(), 0.2);
    if ( globoMorado1.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(payaso.getPosPayasoX(), payaso.getPosPayasoY());
      } else {
        estadoEscenario=5;
      }
    };
    if ( globoMorado2.validarColisionGlobosM(payaso.getPosPayasoX(), payaso.getPosPayasoY())==true) {
      if (payaso.validarVida()==true) {
        payaso.setVida(1);
        payaso.setPosPayasoX(368);
        payaso.setPosPayasoY(54);
        payaso.drawPayasoQuemado(payaso.getPosPayasoX(), payaso.getPosPayasoY());
      } else {
        estadoEscenario=5;
      }
    }

payaso.drawPayaso();
  
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
    break;
  case 3:
    xCambio -= 1;

    break;
  case 4:
    yCambio -= 1 ;
    break;
  case 5:
    ;
    yCambio += 1;
    break;
  }
  payaso.actualizarPosicionPayaso(xCambio, yCambio);
}
