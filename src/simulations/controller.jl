include("../controller_common.jl")

@handler function listButtonClicked()
    @info "listButtonClicked"
    viewMode = LIST
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