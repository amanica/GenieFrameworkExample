"""
Example module that changes view mode using an enum.
(Just re-run in vscode repl if changes are not picked up)

Pros:
  * Switch fast between modes without reload

Cons:
  * Loads all views into the browser with all the data
"""
module Simulations

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple
@genietools

include("view_list.jl")
include("view_new.jl")
include("view_single.jl")

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

    @onbutton listButton begin
        @info "listButton"
        viewMode = LIST
    end

    @onbutton newButton begin
        @info "newButton"
        viewMode = NEW
    end

    @onbutton runButton begin
        @info "runButton"

        id = rand(Int8)
        status = RUNNING
        viewMode = VIEW

        @async begin
            @info "Task started"

            sleep(2)
            status = rand([SUCCESS,FAIL])

            simulations[id] = status
            @info "Task ended"
        end
    end
end

function ui()
    [
        span(view_single(), @if("viewMode == '$VIEW'")),
        span(view_new(), @elseif("viewMode == '$NEW'")),
        span(view_list(), @else(true)),
    ]
end

@page("/simulations", ui)

end
