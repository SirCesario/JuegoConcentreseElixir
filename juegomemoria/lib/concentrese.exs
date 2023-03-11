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

  for _ <- 1..4 do
    IO.puts "Vidas: #{vidas}\nSeleccione un par : "
    {fila1, col1} = get_carta()
    {fila2, col2} = get_carta()
    carta1 = List.at(List.at(tablero, fila1), col1)
    carta2 = List.at(List.at(tablero, fila2), col2)

    if carta1 == carta2 && fila1 != fila2 && col1 != col2 do
      actualizar_tablero(tablero, fila1, col1, nil)
      actualizar_tablero(tablero, fila2, col2, nil)
      puntos_racha = calcular_puntos(carta1)
      puntos = puntos + puntos_racha
      max_racha = max_racha + 1
      IO.puts "Has encontrado un par de #{carta1}. +#{puntos_racha} puntos."
    else
      vidas = vidas - 1
      IO.puts "Sigue intentando."
    end

    dibujar_tablero(tablero)

    if all_pares_encontrados?(tablero) do
      IO.puts "**************  ¡¡ FELICIDADES !! HAS ENCONTRADO TODOS LOS PARES.************"
      break()
    end
  end
  IO.puts "Fin de la partida."
    IO.puts "Jugador: #{nickname}"
    IO.puts "Puntaje final: #{puntos}"
    IO.puts "Racha máxima: x#{max_racha}"
    IO.puts "Vidas: #{vidas}"
end

end
