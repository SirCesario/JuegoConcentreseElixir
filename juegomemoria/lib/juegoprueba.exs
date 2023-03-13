defmodule Memoria do

  #Listas para usar en el Juego
  #@consonantes ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "ñ", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
  #@vocales ["a", "e", "i", "o", "u"]

  def start_juego do
    IO.puts "*********************** BIENVENIDO AL JUEGO DE MEMORIA CONCENTRESE ELIXIR  *****************"
    IO.puts " Para iniciar el juego ingresa tu Nombre : "
    nickname = String.trim(IO.gets(""))
    vidas = 4
    intentos = 6
    puntos = 0
    racha_max = 0
   # estadisticas = [vidas, intentos, puntos , racha_max]

    IO.puts " Estas son tus estadisticas Iniciales #{nickname}
     vidas = #{vidas},
     intentos = #{intentos},
     puntos = #{puntos},
     racha_max = #{racha_max}
    "

  end

end

Memoria.start_juego()
