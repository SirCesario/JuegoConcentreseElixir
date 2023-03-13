defmodule GameMemory do

  def inicier_juego do
  IO.puts "Cual es tu nombre"
  nombre = String.trim(IO.gets(""))
  apelli = last_name()
  ed = edad()
  finalizar_juego(nombre, apelli,ed)
 end

 def finalizar_juego(nombre, apelli,ed) do

 IO.puts "Es un placer saludarte : #{nombre} #{apelli}"
 #finalizar_juego(nombre, apelli)
 end

 def last_name do
  IO.puts " Ingresa tu Apellido "
  apellido = String.trim(IO.gets(""))
  apellido
end

def edad do
  IO.puts " Ingresa tu edad "
  numero = String.trim(IO.gets(""))
  if numero >= 18 do
    IO.puts "si puedes jugar"
  else
      IO.puts "sigue intentando"
    end
end


end

GameMemory.inicier_juego()
