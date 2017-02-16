


int  STEP = 10;
float  x_amount = .1;
float  y_amount = .1;
float  counter;
color[]  palette = {
  #E369A4, #297CD3, #008DFC
};

float  x_sun = 0;
float  y_sun = 0;
float  sun_rad = 200;


void  setup()
{
  size(800, 800);
  smooth(4);
  counter = 0.0;
  x_sun = width/2;
  y_sun = height/2;
}


void  draw()
{

  background(0);


  float  x_c = 0;
  for (int x=0; x<width; x+=STEP)
  {
    float  y_c = 0;
    for (int y=0; y<height; y+=STEP)
    {
      float noise = noise(x_c, y_c+counter);
      float noise2 = noise(x_c*y_c, y_c*counter);
      pushMatrix();
      translate(x, y);

      boolean  is_sun = false;
      float d = dist(x, y, x_sun, y_sun);
      if (d < sun_rad)
      {
        is_sun = true;
      }

      noise*=255;
      int _case = (int)map(noise, 0, 255, 0, 3);
      noStroke();

      float  dist_norm = d/sun_rad;
      dist_norm = map(d, 0.0, sun_rad, 0.0, 1.0);

      color  lerped = lerpColor(palette[_case], color(255), 2.0-dist_norm);

      stroke(lerped);

      pushMatrix();
      scale(noise/255.0);
      draw_x();
      popMatrix();

      popMatrix();
      y_c+=y_amount;
    }
    x_c+=x_amount;
  }
  counter+=.05;
}

void  draw_x()
{
  float  _size = STEP;
  line(0, 0, _size, _size);
  line(_size, 0, 0, _size);
}