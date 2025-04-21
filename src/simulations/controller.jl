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
    traces = []
    simulation = Simulation(id=id,
        start=DateTime(daterange.start),
        stop=DateTime(daterange.stop))
    simulations[id] = simulation

    @async begin
        @info "Task started"
        sleep(1)

        @info "Task running"
        simulation.status = RUNNING
        value = abs(randn() * 100)
        @async @push simulation
        for (i, currentDate) in enumerate(simulation.start:Day(1):simulation.stop)
            value += randn() * 5
            @show i, currentDate, value
            push!(simulation.data, (time=currentDate, value=value))
            traces = [scatter(
                x=simulation.data[!, :time],
                y=simulation.data[!, :value],
                mode="lines+markers",
                name="Trace",
                line=attr(color="red")
            )]
            sleep(1)
        end
        @info "Task done"
        @show simulation.status = rand([SUCCESS,FAIL])
        @async @push simulation
        @info "Task ended"
    end
end