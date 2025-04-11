
@handler function listButtonClicked()
    @info "listButtonClicked"
    viewMode = LIST
end

@handler function newButtonClicked()
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