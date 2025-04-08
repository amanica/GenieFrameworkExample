"""
How to run:

julia --project
using Pkg; Pkg.instantiate()
using Genie; Genie.loadapp(); up()
"""

module App

using GenieFramework
@genietools

@app begin
  @in name = "Genie"
  @out subject = "Genie"
  @onchange name begin
    @info "name changed to $name"
    subject = name
  end
end

function ui()
  [
    h1("My First Genie App"),
    p(textfield("Enter your name", :name)),
    h2("Hello {{subject}}!")
  ]
end

@page("/", ui)
end
