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
using SearchLight, SearchLightSQLite
using ..GenieFrameworkExample.SimulationsDB
using ..GenieFrameworkExample.SimulationDataDB
@genietools

@enum ViewMode begin
    LIST
    NEW
    SINGLE
end

function simulationsAsDataFrame()
  simulations = SearchLight.find(Simulation)
  if !isempty(simulations)
    data = [(sim.id.value, sim.status, sim.start, sim.stop) for sim in simulations]
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
  @out simulation::Union{Nothing,Simulation} = Simulation()
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


