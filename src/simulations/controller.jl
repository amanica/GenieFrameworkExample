include("../controller_common.jl")

@handler function listButtonClicked()
    @info "listButtonClicked"
    viewMode = LIST
end

@handler function viewModeChanged()
    @info "viewModeChanged $viewMode"
    if viewMode == LIST
        @info "updating table.."
        # tableData = DataTable(simulationsAsDataFrame())
        tableData.data = simulationsAsDataFrame()
        @async @push tableData
    end
end


# I'm not sure much is gained by specifying the relevant
# reactive variables, I'm guessing it will just do a tiny bit less work..
@handler (:viewMode,) function newButtonClicked()
    @info "newButtonClicked"
    viewMode = NEW
end


@handler function runButtonClicked()
    @info "runButtonClicked"

    id = rand(Int8)
    viewMode = SINGLE
    simulation = Simulation(id, INIT,
        DateTime(daterange.start),
        DateTime(daterange.stop))
    simulations[id] = simulation

    @async begin
        @info "Task started"
        sleep(2)

        @info "Task running"
        simulation.status = RUNNING
        @async @push simulation

        sleep(2)
        @info "Task done"
        @show simulation.status = rand([SUCCESS,FAIL])
        @async @push simulation
        @info "Task ended"
    end
end