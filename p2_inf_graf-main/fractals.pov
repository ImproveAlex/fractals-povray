#include "colors.inc"  
#include "textures.inc"
#include "realskies.inc"

camera {
  location <5, 2, 15>
  look_at <-2, 0.5, -0.5> 
  angle 36
}

#declare Pyramid = rgb <0.871, 0.612, 0.145>;

sky_sphere {
    // Utiliza uno de los cielos definidos anteriormente
    sky_realsky_01
}
 
 
light_source { <10,50,50> color White}

#macro sierpinski(s, base_center, recursion_depth)
    #if (recursion_depth > 0)
        union {       
            sierpinski(s / 2, base_center + s/2*y,      recursion_depth - 1)
            sierpinski(s / 2, base_center - s/2*(x+z),  recursion_depth - 1)
            sierpinski(s / 2, base_center - s/2*(x-z),  recursion_depth - 1)
            sierpinski(s / 2, base_center - s/2*(-x+z), recursion_depth - 1)
            sierpinski(s / 2, base_center - s/2*(-x-z), recursion_depth - 1)
        }
    #else
        difference{
            box { <1,1,1>, <-1,0,-1> }
            plane{ x-y,  -sqrt(2)/2}
            plane{ -x-y, -sqrt(2)/2}
            plane{ z-y,  -sqrt(2)/2}
            plane{ -z-y, -sqrt(2)/2}
            scale s*1.0
            translate base_center            
        }    
    #end
#end

object {
    sierpinski(2, <0,0,0>, 5) // Llama a la macro sierpinski con tamaño 10, posición base en <0,0,0>, y profundidad de recursión 3
    pigment { color Pyramid }
    //finish {
        //ambient 0.1 // Reducimos la luz ambiente para oscurecer las áreas no iluminadas
        //emission 1 // Propiedad de emisión para simular la luminiscencia del objeto
        //diffuse 0.5 // Añadimos algo de reflexión difusa para interactuar con la luz ambiente
        //specular 0 // Sin reflexión especular
    //}
}

object {
    sierpinski(2, <-5,0,-5>, 5) // Llama a la macro sierpinski con tamaño 10, posición base en <0,0,0>, y profundidad de recursión 3
    pigment { color Pyramid }
    //finish {
        //ambient 0.1 // Reducimos la luz ambiente para oscurecer las áreas no iluminadas
        //emission 1 // Propiedad de emisión para simular la luminiscencia del objeto
        //diffuse 0.5 // Añadimos algo de reflexión difusa para interactuar con la luz ambiente
        //specular 0 // Sin reflexión especular
    //}
}

object {
    sierpinski(2, <-10,0,-10>, 5) // Llama a la macro sierpinski con tamaño 10, posición base en <0,0,0>, y profundidad de recursión 3
    pigment { color Pyramid }
    //finish {
        //ambient 0.1 // Reducimos la luz ambiente para oscurecer las áreas no iluminadas
        //emission 1 // Propiedad de emisión para simular la luminiscencia del objeto
        //diffuse 0.5 // Añadimos algo de reflexión difusa para interactuar con la luz ambiente
        //specular 0 // Sin reflexión especular
    //}
}

plane{<0,0.1,0>, 0 
      texture{pigment{ rgb <0.2, 0.2, 0.2> } 
              normal { bumps 0.08 scale <1,0.25,0.35>*1 turbulence 0.6 }
              finish { ambient 0.05 diffuse 0.55 
                       brilliance 6.0 phong 0.8 phong_size 120
                       reflection 0.6 }
             }
     }

julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 0.0, 0.3> ] // High opacity base color (yellow)
            //[ 0.5  rgbt <1.0, 1.0, 0.0, 0.5> ] // Medium opacity (yellow)
            //[ 1.0  rgbt <1.0, 1.0, 0.0, 0.0> ] // Low opacity (transparency)
        }
      }   
   }
   
   interior {
      ior 1.1
   }
   scale 3.2
   rotate <135, 20, 90>
   translate <-25, 10, -50>
}

// Define textures
#declare CarpetTexture =
texture {
    pigment {
        gradient y
        color_map {
            [ 0.0 rgbt <1.0, 0.8, 0.0, 1.0> ] // Base color (yellow-orange)
            [ 0.5 rgbt <0.8, 0.5, 0.0, 0.7> ] // Mid color (orange-brown)
            [ 1.0 rgbt <0.4, 0.2, 0.0, 0.3> ] // Edge color (dark brown)
        }
    }
    finish {
        ambient 0.1
        diffuse 0.9
        specular 0.3
        reflection 0.1
    }
}

julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 1.0, 0.8> ] // Color base con alta opacidad
            [ 0.5  rgbt <1.0, 1.0, 1.0, 0.5> ] // Opacidad media
            [ 1.0  rgbt <1.0, 1.0, 1.0, 0.0> ] // Opacidad baja (transparencia)
         }
      }   
      finish {
         ambient 0.5 // Reducido para que sea más translúcido
         diffuse 0.5 // Reducido para que sea más translúcido
         specular 0.5 // Reducido para que sea más translúcido
         roughness 0.005 // Aumentado para dar una sensación más suave
         reflection 0.0 // No refleja mucho, más nuboso
         transmit 0.9 // Alta transmitancia para que sea más translúcido
      }
   }
   
   interior {
      ior 1.1
   }
   scale 10
   rotate <15, 10, 60>
   translate <-120, 15, -150>
}

julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 1.0, 0.8> ] // Color base con alta opacidad
            [ 0.5  rgbt <1.0, 1.0, 1.0, 0.5> ] // Opacidad media
            [ 1.0  rgbt <1.0, 1.0, 1.0, 0.0> ] // Opacidad baja (transparencia)
         }
      }   
      finish {
         ambient 0.5 // Reducido para que sea más translúcido
         diffuse 0.5 // Reducido para que sea más translúcido
         specular 0.5 // Reducido para que sea más translúcido
         roughness 0.005 // Aumentado para dar una sensación más suave
         reflection 0.0 // No refleja mucho, más nuboso
         transmit 0.9 // Alta transmitancia para que sea más translúcido
      }
   }
   
   interior {
      ior 1.1
   }
   scale 10
   rotate <15, 10, 60>
   translate <-100, 15, -150>
}
julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 1.0, 0.8> ] // Color base con alta opacidad
            [ 0.5  rgbt <1.0, 1.0, 1.0, 0.5> ] // Opacidad media
            [ 1.0  rgbt <1.0, 1.0, 1.0, 0.0> ] // Opacidad baja (transparencia)
         }
      }   
      finish {
         ambient 0.5 // Reducido para que sea más translúcido
         diffuse 0.5 // Reducido para que sea más translúcido
         specular 0.5 // Reducido para que sea más translúcido
         roughness 0.005 // Aumentado para dar una sensación más suave
         reflection 0.0 // No refleja mucho, más nuboso
         transmit 0.9 // Alta transmitancia para que sea más translúcido
      }
   }
   
   interior {
      ior 1.1
   }
   scale 10
   rotate <15, 10, 60>
   translate <-80, 15, -150>
}
julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 1.0, 0.8> ] // Color base con alta opacidad
            [ 0.5  rgbt <1.0, 1.0, 1.0, 0.5> ] // Opacidad media
            [ 1.0  rgbt <1.0, 1.0, 1.0, 0.0> ] // Opacidad baja (transparencia)
         }
      }   
      finish {
         ambient 0.5 // Reducido para que sea más translúcido
         diffuse 0.5 // Reducido para que sea más translúcido
         specular 0.5 // Reducido para que sea más translúcido
         roughness 0.005 // Aumentado para dar una sensación más suave
         reflection 0.0 // No refleja mucho, más nuboso
         transmit 0.9 // Alta transmitancia para que sea más translúcido
      }
   }
   
   interior {
      ior 1.1
   }
   scale 10
   rotate <15, 10, 60>
   translate <-60, 15, -150>
}
julia_fractal {
   <0.0, 1.15, -0.2, 0.0>
   slice <0.2873, 0.0, 0.0, 0.9578>, 0.2
   max_iteration 10
   precision 2000
   sqr
   quaternion
   texture {   
      pigment {
         gradient y
         color_map {
            [ 0.0  rgbt <1.0, 1.0, 1.0, 0.8> ] // Color base con alta opacidad
            [ 0.5  rgbt <1.0, 1.0, 1.0, 0.5> ] // Opacidad media
            [ 1.0  rgbt <1.0, 1.0, 1.0, 0.0> ] // Opacidad baja (transparencia)
         }
      }   
      finish {
         ambient 0.5 // Reducido para que sea más translúcido
         diffuse 0.5 // Reducido para que sea más translúcido
         specular 0.5 // Reducido para que sea más translúcido
         roughness 0.005 // Aumentado para dar una sensación más suave
         reflection 0.0 // No refleja mucho, más nuboso
         transmit 0.9 // Alta transmitancia para que sea más translúcido
      }
   }
   
   interior {
      ior 1.1
   }
   scale 10
   rotate <15, 10, 60>
   translate <-40, 15, -150>
}