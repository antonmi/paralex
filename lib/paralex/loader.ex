defmodule Paralex.Loader do

  def load(dir) do
    dir
    |> Path.join("**/*.rb")
    |> Path.wildcard()
    |> Enum.filter(&File.regular?(&1))
  end

  def split(files, count) do
    size = round(Float.ceil(length(files) / count))
    Enum.chunk(files, size, size, [])
  end

end
