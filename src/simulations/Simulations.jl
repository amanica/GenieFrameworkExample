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
using DataFrames, PlotlyBase, Dates
using GenieFramework, Stipple, FilePathsBase, StipplePlotly
@genietools

@enum ViewMode begin
    LIST
    NEW
    SINGLE
end

@enum SimulationStatus INIT RUNNING SUCCESS FAIL

Stipple.@kwdef mutable struct Simulation
  id::Int = 0
  status::SimulationStatus = INIT
  start::DateTime = today() - Day(2)
  stop::DateTime = today() - Day(1)
  data::DataFrame = DataFrame(time=DateTime[], value=Float64[])
end

# Fake db
simulations=Dict{Int, Simulation}()

function simulationsAsDataFrame()
  if !isempty(simulations)
      data = [(id, simulation.status, simulation.start, simulation.stop) for (id, simulation) in simulations]
      return DataFrame(data, [:id, :status, :start, :stop])
  else
      return DataFrame()
  end
end

@app begin
  # needed for drawer layout:
  @in left_drawer_open = false
  @in ministate = true

  @out viewMode::ViewMode = LIST
  @in newButton = false
  @in runButton = false
  @in listButton = false
  @out id::Union{Nothing, Int} = nothing
  @out simulation::Simulation = Simulation()
  @in daterange = DateRange(today() - Day(2), today() - Day(1))

  @out tableData = DataTable(simulationsAsDataFrame())
  @in tablefilter = ""

  @out traces = []
  @out layout = PlotlyBase.Layout(
    title="A Scatter Plot",
    xaxis=attr(
        title="Value",
        showgrid=false,
        autorange = true
    ),
    yaxis=attr(
        title="Time",
        showgrid=true,
        autorange = true
    ),
    height = 680,
  )

  @onbutton listButton listButtonClicked()
  @onbutton newButton newButtonClicked()
  @onbutton runButton runButtonClicked()

  @onchange viewMode, simulation viewModeChanged()
end

include("controller.jl") # Note: handlers need to be after @app
include("../view_common.jl")

# loading from a file so that auto-reloading works:
@page("/simulations", p"simulations/view.jl", layout=LAYOUT)

end
