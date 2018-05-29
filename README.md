# Smg

Smg is an elixir app that could help you to get employees info of iTechArt people

## Usage

First create `config/secrets.exs` file with your SMG credentials

### Now you could use mix tasks

```bash
mix help | grep smg

mix smg.deps
mix smg.employees
mix smg.employees_by_dep D10
mix smg.employees_with_details D10
```

### Also you could try things in iex console

```bash
iex -S mix
```

```elixir
# Print all iTechArt departments
Smg.deps 

# Print all iTechArt employees
Smg.employees  

# Print all iTechArt D10 department employees
Smg.employees_by_dep("D10")  

# Print all iTechArt D10 department employees with phone and skype contacts
Smg.employees_with_details("D10") 
```

