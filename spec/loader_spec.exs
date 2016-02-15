defmodule LoaderSpec do
  use ESpec

  alias Paralex.Loader

  describe "load" do
    let :dir, do: "/home/antonmi/elixir/paralex/spec/ruby"
    let :dir, do: "/home/antonmi/ruby/matic-home"

    let! :files do
      Loader.load(dir) |> Enum.shuffle
    end

    it "filters files" do
      Enum.each(files, fn(file) ->
        expect file |> to(end_with(".rb"))
      end)
    end

    it do: expect Enum.count(files) |> to(eq 15)

    describe "split" do
      let :parts, do: Loader.split(files, 10)

      it "checks parts" do
        IO.inspect(parts)
        [part1, part2, part3, part4] = parts
        expect length(part1) |> to(eq 4)
        expect length(part4) |> to(eq 3)
      end


      it do
        IO.inspect(length(files))
        opts = [in: nil, out: :stream]
        parts
        |> Enum.map(fn(part) ->
          Task.async(fn ->
            command = "cd /home/antonmi/ruby/matic-home && bundle exec rubocop -c .rubocop.yml #{Enum.join(part, " ")}"
            %Porcelain.Process{out: outstream} = Porcelain.spawn_shell(command, opts)
            IO.inspect("-----")
            Enum.each(outstream, &IO.write(&1))
          end)
        end)
        |> Enum.map(&Task.await(&1, :infinity))

      end
    end
  end
end
