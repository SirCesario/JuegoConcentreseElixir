defmodule Juegoconcentrese  do

    @abecedario ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    @vocales ["a", "e", "i", "o", "u"]

def play do
  IO.puts "*************************************Bienvenido al Juego de Concentrese - ELIXIR ************************************"
  IO.puts "Ingresa tu NickName"
  nickname = String.trim(IO.gets(""))

  tablero = generar_tablero()
  puntos = 0
  vidas = 4
  max_racha = 0

  IO.puts "Jugador : #{nickname}"
  dibujar_tablero(tablero)
end

end
