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

        # Load simulation data
        sim_data_whereclause = SQLWhereExpression("simulation_id = ?", selectedSimulationId)
        simulation_data = SearchLight.find(SimulationData, sim_data_whereclause)

        if isempty(simulation_data)
            traces = []
        else
            @show simulation_data
            data = DataFrame(time=[row.datetime for row in simulation_data], value=[row.value for row in simulation_data])
            traces = [scatter(
                x=data[!, :time],
                y=data[!, :value],
                mode="lines+markers",
                name="Trace",
                line=attr(color="red")
            )]
        end

        @async @push traces
    end
  catch e
    trace=Base.catch_backtrace()
    @error "Error loading simulation: $e"
    show(stdout, MIME"text/plain"(), stacktrace(trace))
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
    viewMode = SINGLE
    traces = []

    simulation = Simulation(
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
            saved_simulation = SearchLight.save!(simulation) # get id back
            simulation.id = saved_simulation.id #not assigning directly as reactive ui freaks out
            @async @push simulation
            value = abs(randn() * 100)
            data::DataFrame = DataFrame(time=DateTime[], value=Float64[])
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
            #setStatus(simulation[], rand([SimulationsDB.SUCCESS, SimulationsDB.FAIL])) #not sure why things freak out if I use a method
            simulation.status = string(rand([SimulationsDB.SUCCESS, SimulationsDB.FAIL]))
            @async @push simulation

            SearchLight.save(simulation)
            if simulation.status == string(SimulationsDB.SUCCESS)
                @info "Saving simulation data"
                for row in eachrow(data)
                    sim_data = SimulationData(
                        simulation_id=simulation.id,
                        datetime=row[:time],
                        value=row[:value]
                    )
                    SearchLight.save(sim_data)
                end
            end
            @info "Task ended"
        catch e
            trace=Base.catch_backtrace()
            @error "Task failed: $e"
            show(stdout, MIME"text/plain"(), stacktrace(trace))
            # setStatus(simulation, SimulationsDB.FAIL)
            simulation.status = string(SimulationsDB.FAIL)
            @async @push simulation
            SearchLight.save(simulation)
        end
    end
end