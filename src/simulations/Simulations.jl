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
using DataFrames, Dates
using GenieFramework, Stipple, Stipple.ReactiveTools, FilePathsBase
using PlotlyBase, StipplePlotly
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

function createPlotLayout()
    return PlotlyBase.Layout(
        title="A Scatter Plot",
        xaxis=attr(
            title="Time",
            showgrid=false,
            autorange = true
        ),
        yaxis=attr(
            title="Value",
            showgrid=true,
            autorange = true
        ),
        height = 680,
    )
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
  @out simulation_progressPercent::Float16 = 0
  @in daterange = DateRange(today() - Day(2), today() - Day(1))

  @out tableData = DataTable(simulationsAsDataFrame())
  @in tablefilter = ""

  @in plot = Plot(GenericTrace{Dict{Symbol,Any}}[], createPlotLayout())
  @in plot_selected = Dict{String, Any}()
  @in plot_click = Dict{String, Any}()
  @in plot_hover = Dict{String, Any}()
  @in plot_relayout = Dict{String, Any}()
  @in plot_cursor = Dict{String, Any}()

  @onbutton listButton listButtonClicked()
  @onbutton newButton newButtonClicked()
  @onbutton runButton runButtonClicked()

  @onchange viewMode, simulation viewModeChanged()

  @onchange plot_selected begin
      @show "plot_selected: $plot_selected"
      haskey(plot_selected, "points") && @info "Selection: $(getindex.(plot_selected["points"], "pointIndex"))"
  end

  @onchange plot_click begin
      @info "plot_click $plot_click"
      haskey(plot_click, "points") && @info "clicked $(plot_click["points"][1]["x"]):$(plot_click["points"][1]["y"])"
  end

  @onchange plot_hover begin
      # @show "plot_hover: $plot_hover"
      haskey(plot_hover, "points") && @info "hovered over $(plot_hover["points"][1]["x"]):$(plot_hover["points"][1]["y"])"
  end

  @onchange plot_cursor begin
      @info "$plot_cursor"
      @info "cursor moved to $(plot_cursor["cursor"]["x"]):$(plot_cursor["cursor"]["y"])"
  end

  @onchange plot_relayout begin
      @info "plot_relayout $plot_relayout"
  end
end

@mounted watchplots()

include("controller.jl") # Note: handlers need to be after @app
include("../view_common.jl")

# loading from a file so that auto-reloading works:
@page("/simulations", p"simulations/view.jl", layout=LAYOUT)

end


