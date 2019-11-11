class Sogas {
  PImage soga1;

  PVector[] posSoga;


  int cantidad;
  PVector aux;
  PVector auxComparacion;
  PImage [] sogas;
  //float posSogaX;
  //float posSogaY;

  Sogas() {
    cantidad=21;
    soga1 = loadImage("soga-01.png");

    aux =new PVector();
    auxComparacion =new PVector(34, 20);
    posSoga = new PVector[cantidad];

    for (int i=0; i<cantidad; i++) {
      posSoga[i] = new PVector(random(10, 100), random(300, 550));
      for (int j=0; j<i; j++) {
        aux.x = posSoga[i].x - posSoga[j].x;
        aux.y = posSoga[i].y - posSoga[j].y;
        if (posSoga[i] == posSoga[j]) {
          i--;
        } else {
          if (aux.x <= auxComparacion.x ) {
            posSoga[i].x += 34;
          } else if (aux.y <= auxComparacion.y) {
            posSoga[i].y += 20;
          }
        }
      }
    }
  }


  void drawSogas() {
    for (int i=0; i<cantidad; i++) {
      image(soga1, posSoga[i].x, posSoga[i].y);
      println("x: ", i, " ", posSoga[i].x, "y", posSoga[i].y);
    }
  }
  boolean validarColision(float posPayasoX, float posPayasoY,int val) {
    for (int i=0; i<cantidad; i++) {
      if ((posPayasoX >= posSoga[i].x-60  && posPayasoX <= posSoga[i].x +20) && (posPayasoY+90 >= posSoga[i].y  && posPayasoY+90 <= posSoga[i].y +20) && val==1) {
        image(soga1, posSoga[i].x = -50, posSoga[i].y = -50);
       
        return true;
      }
    }

    return false;
  }
  
 



  boolean limitar(float posx, float posy) {
    if (posx >= 0 && posx <= 750 && posy <= 500 ) {
      return true;
    }
    return false;
  }
}
