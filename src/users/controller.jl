include("../controller_common.jl")

function jsredirect(path)
    return """window.location.href = '$path'"""
end

@handler function newButtonClicked()
    @info "newButtonClicked"
    # redirect("/users/new") # this is not working :'(
    # Stipple.redirect("/users/new") # this is not working :'(
    # Stipple.redirect(:get_users_new) # this is not working :'(

    @run jsredirect("/users/new")
end

@handler function updateIdFromUrl()
    paramid = params(:id)

    # needed to update the model if we are coming in from an url param
    if id != paramid
        id = paramid
    end
    return nothing
end
