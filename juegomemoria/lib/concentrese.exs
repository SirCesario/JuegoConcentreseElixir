defmodule MemoriaGame do
  #Definicion para Iniciar el Juego
  @consonantes ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "ñ", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
  @vocales ["a", "e", "i", "o", "u"]

  def start_juego do
    IO.puts "***********************Bienvenidos al Juego de Memoria !! Elixir !! *********************************** "
    IO.puts " Ingrese su NickName : "
    nickname = String.trim(IO.gets(""))
    puntos = 0
    vidas = 4
    racha_max = 0

    tablero = [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12]
    ]

    juego = %{
      consonantes: @consonantes,
      vocales: @vocales,
      jugador: nickname,
      tablero: tablero,
    }

    play_game(juego)
  end

  #Definicion de la logica del Juego
  def play_game(juego) do

    def generar_cartas(0, cartas), do: cartas

    def generar_cartas(n, cartas) do
      consonantes = @consonantes
      vocales = @vocales
      consonante_mayus = String.upcase(List.random(consonantes))
      consonante_minus = List.random(consonantes)
      vocal = List.random(vocales)
      carta1 = %{
        letra: consonante_mayus,
        descubierta: false
      }
      carta2 = %{
        letra: vocal,
        descubierta: false
      }
      carta3 = %{
        letra: consonante_minus,
        descubierta: false
      }
      nuevas_cartas = [carta1, carta2, carta3]
      generar_cartas(n-1, cartas ++ nuevas_cartas)
    end

  end

  #Definicion de los resultado
end
