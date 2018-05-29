defmodule Smg.Client do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> initial_session_id end, name: :session_id)
  end

  @base_url "https://smg.itechart-group.com/MobileServiceNew/MobileService.svc"

  def username, do: Application.get_env(:smg, :username)
  def password, do: Application.get_env(:smg, :password)

  defp auth_url, do: "#{@base_url}/Authenticate"
  defp deps_url, do: "#{@base_url}/GetAllDepartments"
  defp empls_path, do: "#{@base_url}/GetAllEmployees"
  defp empls_by_dep_id_path, do: "#{@base_url}/GetEmployeesByDeptIdUpdated"
  defp empl_details_path, do: "#{@base_url}/GetEmployeeDetails"

  def employee_details(%{profile_id: profile_id}) do
    HTTPoison.get!("#{empl_details_path}?sessionId=#{session_id}&profileId=#{profile_id}")
    |> parse_response_body
    |> parse("Profile")
  end

  def employees(%{dep_id: dep_id}) do
    HTTPoison.get!(
      "#{empls_by_dep_id_path}?sessionId=#{session_id}&departmentId=#{dep_id}&initialRequest=true&updatedDate=8/13/2013%2012:53:59%20PM"
    )
    |> parse_response_body
    |> parse("Profiles")
  end

  def employees_with_details(%{dep_id: dep_id}) do
    employees(%{dep_id: dep_id})
    |> Enum.map(fn e ->
      Task.async(fn -> employee_details(%{profile_id: e["ProfileId"]}) end)
    end)
    |> Enum.map(&Task.await(&1))
  end

  def employees do
    HTTPoison.get!("#{empls_path}?sessionId=#{session_id}")
    |> parse_response_body
    |> parse("Profiles")
  end

  def departments do
    HTTPoison.get!("#{deps_url}?sessionId=#{session_id}")
    |> parse_response_body
    |> parse("Depts")
  end

  def session_id do
    Agent.get(:session_id, & &1)
  end

  defp initial_session_id do
    authenticate
    |> parse("SessionId")
  end

  defp authenticate do
    HTTPoison.get!("#{auth_url}?username=#{username}&password=#{password}")
    |> parse_response_body
  end

  defp parse_response_body(response) do
    response.body
    |> Poison.decode!()
  end

  defp parse(body, field) do
    body[field]
  end
end
