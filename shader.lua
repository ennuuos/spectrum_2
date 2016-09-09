shader = {
	abberation = love.graphics.newShader[[
  	extern number evolution;
  	extern number magnitude;
  	number pi = 3.14;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords);

      pixel.r = Texel(texture, vec2(texture_coords.x + sin(evolution)*magnitude, texture_coords.y + cos(evolution)*magnitude)).r;
      pixel.g = Texel(texture, vec2(texture_coords.x + sin(evolution + 2*pi/3)*magnitude, texture_coords.y + cos(evolution + 2*pi/3)*magnitude)).g;
      pixel.b = Texel(texture, vec2(texture_coords.x + sin(evolution + 4*pi/3)*magnitude, texture_coords.y + cos(evolution + 4*pi/3)*magnitude)).b;

      if(pixel.a > 1) {
      	pixel.a = 1;
      }
   	  return pixel * color;
    }
  ]]

}