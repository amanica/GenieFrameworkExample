module Simulations
const MODULE_INFO = """
Example module that changes view mode using an enum.
The run page also does some async action.
(Just re-run the Simulations.jl module in vscode repl if changes are not picked up)

Pros:
  * Switch fast between modes without reload

Cons:
  * Loads all views into the browser with all the data
"""

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple, FilePathsBase
using DataFrames
@genietools

@enum ViewMode begin
    LIST
    NEW
    SINGLE
end

@enum SimulationStatus INIT RUNNING SUCCESS FAIL

Stipple.@kwdef mutable struct Simulation
  id::Int
  status::SimulationStatus
end

# Fake db
simulations=Dict{Int, Simulation}()

function simulationsAsDataFrame()
  if !isempty(simulations)
      data = [(id, simulation.status) for (id, simulation) in simulations]
      return DataFrame(data, [:id, :status])
  else
      return DataFrame()
  end
end

@app begin
    @out viewMode::ViewMode = LIST
    @in newButton = false
    @in runButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @out simulation::Simulation = Simulation(0, INIT)

    @out tableData = DataTable(simulationsAsDataFrame())
    @in tablefilter = ""

    @onbutton listButton listButtonClicked()
    @onbutton newButton newButtonClicked()
    @onbutton runButton runButtonClicked()

    @onchange viewMode, simulation viewModeChanged()
end

include("controller.jl") # Note: handlers need to be after @app

@page("/simulations", p"simulations/view.jl", layout=LAYOUT)

end
