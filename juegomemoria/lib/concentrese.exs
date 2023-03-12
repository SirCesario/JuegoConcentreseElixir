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

    def crear_tablero do
      cartas = generar_cartas(6, [])
      cartas_mezcladas = Enum.shuffle(cartas)
      tablero = [
        [cartas_mezcladas[0], cartas_mezcladas[1], cartas_mezcladas[2], cartas_mezcladas[3]],
        [cartas_mezcladas[4], cartas_mezcladas[5], cartas_mezcladas[6], cartas_mezcladas[7]],
        [cartas_mezcladas[8], cartas_mezcladas[9], cartas_mezcladas[10], cartas_mezcladas[11]]
      ]
      {tablero, []}
    end

    def mostrar_tablero(cartas, estado) do
      cartas_ocultas = ocultar_cartas(cartas, estado)
      tablero = construir_tablero(cartas_ocultas)
      IO.puts(tablero)
    end

    defp ocultar_cartas(cartas, estado) do
      Enum.map(cartas, fn carta ->
        if Map.has_key?(estado, carta) do
          carta
        else
          {:oculta, carta}
        end
      end)
    end

    defp construir_tablero(cartas) do
      Enum.reduce(cartas, "", fn carta, acc ->
        if carta == {:oculta, _} do
          "#{acc} [  ]"
        else
          "#{acc} [#{carta}]"
        end
      end)
    end

    def select_card(nickname, tablero, letras_adivinadas, puntos, vidas, racha_max) do
      # Mostrar el tablero actual
      IO.puts "Tablero actual:"
      mostrar_tablero(tablero, letras_adivinadas)

      # Solicitar al jugador que seleccione una carta
      IO.puts "#{nickname}, es tu turno."
      IO.puts "Selecciona una carta:"
      input = IO.gets() |> String.trim()
      card_num = String.to_integer(input)

      # Verificar si la carta seleccionada es válida
      case card_num do
        n when n in 1..12 ->
          carta = Enum.at(tablero, n - 1)
          if carta == :revelada do
            IO.puts "La carta seleccionada ya fue revelada. Selecciona otra carta."
            select_card(nickname, tablero, letras_adivinadas, puntos, vidas, racha_max)
          else
            # Revelar la carta seleccionada
            IO.puts "La carta seleccionada es #{carta}."
            # Marcar la carta como revelada en el tablero
            tablero_actualizado = Enum.replace_at(tablero, n - 1, :revelada)
            # Actualizar las letras adivinadas
            letras_actualizadas = actualizar_letras_adivinadas(letras_adivinadas, carta)
            # Verificar si se formó un par
            case formo_par(letras_actualizadas, carta) do
              true ->
                IO.puts "¡Formaste un par!"
                # Actualizar los puntos y la racha
                puntos_actualizados = actualizar_puntos(puntos, carta)
                racha_actualizada = actualizar_racha(racha_max)
                # Pedir al jugador que seleccione otra carta
                select_card(nickname, tablero_actualizado, letras_actualizadas, puntos_actualizados, vidas, racha_actualizada)
              false ->
                # Reducir una vida y verificar si se acabó el juego
                vidas_actualizadas = vidas - 1
                if vidas_actualizadas == 0 do
                  fin_del_juego(puntos, racha_max, letras_adivinadas)
                else
                  IO.puts "La carta seleccionada no forma un par."
                  # Pedir al jugador que seleccione otra carta
                  select_card(nickname, tablero_actualizado, letras_actualizadas, puntos, vidas_actualizadas, racha_max)
                end
            end
          end
        _ ->
          IO.puts "La carta seleccionada no es válida. Selecciona una carta del 1 al 12."
          select_card(nickname, tablero, letras_adivinadas, puntos, vidas, racha_max)
      end
    end

    def game_over?(vidas, tablero) when vidas <= 0 or tablero == [] do
      true
    end

    def game_over?(_vidas, _tablero) do
      false
    end


  end

  #Definicion de los resultado


    def mostrar_resultados(puntaje, vidas, letras_adivinadas, racha_max) do
      IO.puts "Juego terminado."
      IO.puts "Puntaje final: #{puntaje}"
      IO.puts "Vidas restantes: #{vidas}"
      IO.puts "Letras adivinadas: #{letras_adivinadas}"
      IO.puts "Racha máxima: #{racha_max}"
      case puntaje > 0 and vidas > 0 do
        true -> IO.puts "¡Ganaste!"
        false -> IO.puts "Perdiste :("
      end
    end

end

MemoriaGame.start_juego()
