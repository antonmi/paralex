defmodule ParalexSpec do
  use ESpec

  alias Porcelain.Process, as: Proc



  it do
    # instream = SocketStream.new('example.com', 80)
    opts = [in: nil, out: :stream]
    proc = %Proc{out: outstream} = Porcelain.spawn("rubocop", ["spec/ruby", "-a"], opts)
    IO.inspect(proc)
    Enum.each(outstream, fn(data) ->
      IO.inspect("=========================")
      IO.write(data)
      # IO.inspect(data)
      # IO.stream(:stdio, :line)
    end)
  end

end
