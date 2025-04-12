module Simulations
const MODULE_INFO = """
Example module that changes view mode using an enum.
The run page also does some async action.
(Just re-run in vscode repl if changes are not picked up)

Pros:
  * Switch fast between modes without reload

Cons:
  * Loads all views into the browser with all the data
"""

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple
@genietools
@genietools

@enum ViewMode begin
    LIST
    NEW
    VIEW
end

@enum SimulationStatus INIT RUNNING SUCCESS FAIL
simulations=Dict{Int, SimulationStatus}

@app begin
    @out viewMode::ViewMode = LIST
    @in newButton = false
    @in runButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @out status::SimulationStatus = INIT

    @onbutton listButton listButtonClicked()
    @onbutton newButton newButtonClicked()
    @onbutton runButton runButtonClicked()
end

@created """
console.log('This app has just been created!');
document.querySelector('.layout_root').hidden = false;
"""

include("view.jl")
include("controller.jl") # Note: handlers need to be after @app

@page("/simulations", view, layout=LAYOUT)

end
