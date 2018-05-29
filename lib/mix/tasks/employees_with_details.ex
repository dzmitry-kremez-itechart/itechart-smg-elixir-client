defmodule Mix.Tasks.Smg.EmployeesWithDetails do
  use Mix.Task

  @shortdoc "Print all iTechArt employees by department name, like D10"
  def run(args) do
    Mix.Task.run("app.start")
    Smg.employees_with_details(Enum.join(args, " "))
  end
end
