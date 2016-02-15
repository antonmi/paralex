defmodule Paralex do

  def run(command, args) do

  end

  

  def processors_count do
    :erlang.system_info(:logical_processors_available)
  end

end
