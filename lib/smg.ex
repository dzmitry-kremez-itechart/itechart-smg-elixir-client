defmodule Smg do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: Smg.Client,
        start: {Smg.Client, :start_link, [[]]}
      }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def deps do
    title = "iTechArt Departments List"
    header = ["Id", "Department", "Employees #"]

    Smg.Client.departments()
    |> Enum.sort(fn x, y -> x["NumUsers"] < y["NumUsers"] end)
    |> Enum.map(fn dep -> [dep["Id"], dep["DepCode"], dep["NumUsers"]] end)
    |> TableRex.quick_render!(header, title)
    |> IO.puts()
  end

  def employees_with_details(dep_code) do
    title = "iTechArt Employees List"
    header = ["Id", "Full Name", "Phone", "Skype"]

    Smg.Client.employees_with_details(%{dep_id: get_dep_id(dep_code)})
    |> Enum.sort(fn x, y -> x["Id"] < y["Id"] end)
    |> Enum.map(fn e ->
      [e["ProfileId"], [e["LastName"] <> " " <> e["FirstName"]], e["Phone"], e["Skype"]]
    end)
    |> TableRex.quick_render!(header, title)
    |> IO.puts()
  end

  def employees_by_dep(dep_code) do
    Smg.Client.employees(%{dep_id: get_dep_id(dep_code)})
    |> print_employees
  end

  def employees do
    Smg.Client.employees()
    |> print_employees
  end

  def print_employees(employees) do
    title = "iTechArt Employees List"
    header = ["Id", "Full Name", "Room"]

    employees
    |> Enum.sort(fn x, y -> x["Id"] < y["Id"] end)
    |> Enum.map(fn e -> [e["ProfileId"], [e["LastName"] <> " " <> e["FirstName"]], e["Room"]] end)
    |> TableRex.quick_render!(header, title)
    |> IO.puts()
  end

  def get_dep_id(dep_code) do
    Smg.Client.departments()
    |> Enum.find(fn d -> d["DepCode"] == dep_code end)
    |> Map.get("Id")
  end
end
