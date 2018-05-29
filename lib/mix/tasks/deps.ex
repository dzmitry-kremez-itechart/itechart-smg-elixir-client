defmodule Mix.Tasks.Smg.Deps do
  use Mix.Task

  @shortdoc "Print all iTechArt departments"
  def run(_) do
    Mix.Task.run("app.start")
    Smg.deps()
  end
end
