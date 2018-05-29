defmodule Mix.Tasks.Smg.Employees do
  use Mix.Task

  @shortdoc "Print all iTechArt employees"
  def run(_) do
    Mix.Task.run("app.start")
    Smg.employees()
  end
end
