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

@event :table_row_clicked begin
  @info ":table_row_clicked"
  try
    selectedSimulationId = event["row_data"]["id"]
    @info "Selected simulation: $selectedSimulationId"

    @show whereclause = SQLWhereExpression("id = ?", selectedSimulationId)
    @show simulations = SearchLight.find(Simulation, whereclause)
    if isempty(simulations)
        @run notifyError("Unknown simulation id: $selectedSimulationId")
    else
        @info "Loaded simulation: $simulation"
        viewMode = SINGLE
        simulation = simulations[1]

        # TODO: load simulation data
    end
  catch e
    trace=Base.catch_backtrace()
    show(stdout, MIME"text/plain"(), stacktrace(trace))
    @error "Error loading simulation: $e"
    @run notifyError("Error loading simulation: $selectedSimulationId")
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
    # id = rand(Int8)
    viewMode = SINGLE
    traces = []

    simulation = Simulation(
        # id=DbId(id),
        start=DateTime(daterange.start),
        stop=DateTime(daterange.stop)
    )
    SearchLight.save(simulation)

    @async begin
        try
            @info "Task started"
            sleep(1)

            @info "Task running"
            setStatus(simulation, SimulationsDB.RUNNING)
            simulation = SearchLight.save!(simulation) # get id back
            value = abs(randn() * 100)
            data::DataFrame = DataFrame(time=DateTime[], value=Float64[])
            @async @push simulation
            for (i, currentDate) in enumerate(simulation.start:Day(1):simulation.stop)
                value += randn() * 5
                @show i, currentDate, value
                push!(data, (time=currentDate, value=value))
                traces = [scatter(
                    x=data[!, :time],
                    y=data[!, :value],
                    mode="lines+markers",
                    name="Trace",
                    line=attr(color="red")
                )]
                sleep(1)
            end
            @info "Task done"
            setStatus(simulation, rand([SimulationsDB.SUCCESS, SimulationsDB.FAIL]))
            @async @push simulation
            SearchLight.save(simulation)
            # TODO: save simulation data
            @info "Task ended"
        catch e
            @error "Task failed: $e"
            setStatus(simulation, SimulationsDB.FAIL)
            SearchLight.save(simulation)
            @async @push simulation
        end
    end
end