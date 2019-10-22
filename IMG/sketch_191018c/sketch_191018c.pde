final int N_SPRITES_X = 4;
final int N_SPRITES_Y = 1;
final int TOTAL_SPRITES = N_SPRITES_X * N_SPRITES_Y;   // 16

int current_sprite = 0;
int speed_x = 6;
int posi_x = 0;
int posi_y = 200;

PImage [] my_sprites;

void settings() {
  size(displayWidth, displayHeight, P3D);
}

void setup() {
  my_sprites = new PImage[TOTAL_SPRITES];

  // put 1 image in the data s folder 
  PImage my_sprite_sheet = loadImage("spritePayaso.png");

  int my_sprite_width = my_sprite_sheet.width / N_SPRITES_X;
  int my_sprite_height = my_sprite_sheet.height / N_SPRITES_Y;

  int index = 0;

  for (int y = 0; y < N_SPRITES_Y; y++) {
    for (int x = 0; x < N_SPRITES_X; x++) {
      my_sprites[index] = my_sprite_sheet.get(x * my_sprite_width, y * my_sprite_height, 
        my_sprite_width, my_sprite_height);

      index++;
    }
  }
}

void draw() {
  
  background(100, 50, 200);
  move_the_sprite();
  display_the_sprite();
  
  frameRate(15);
  
}

void move_the_sprite() {
  
  current_sprite++;
  current_sprite %= TOTAL_SPRITES;
  
  posi_x = (posi_x < width) ? posi_x += speed_x : 0;
}

void display_the_sprite() {
  
  pushMatrix();
  translate(posi_x, posi_y, 300);
  image(my_sprites[current_sprite], 0, 0);
  popMatrix();
  
  
  pushMatrix();
  translate(0, posi_y + 1, 300);
  stroke(255);
  line(0, my_sprites[current_sprite].height, width, my_sprites[current_sprite].height);
  popMatrix();
}

void mousePressed() {
  exit();
}
