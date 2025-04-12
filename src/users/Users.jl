module Users
const MODULE_INFO = """
Example module that changes view mode using re-directs.
(Just re-run in vscode repl if changes are not picked up)

Pros:
    * Does not loads all views into the browser with all the data

Cons:
    * Switch slower between modes with page reload causing a flicker
    * I think there is an extra round-trip when updating the model,
      it seems it renders the page and then immediately updates it.
"""

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple, FilePathsBase
@genietools

include("view_list.jl")
include("view_new.jl")
include("view_single.jl")

Stipple.@kwdef mutable struct User
    id::Int
    name::AbstractString
end

# Fake db
users = Dict{Int, User}()

@app begin
    @out moduleInfo = MODULE_INFO
    @in newButton = false
    @in addButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @in user::User = User(0, "")

    @onbutton listButton begin
        @info "listButton"
        @run raw"window.location.href = '/users'"
    end

    @onbutton newButton newButtonClicked()

    @onbutton addButton begin
        @info "addButton"

        newid = rand(Int8)
        name = rand(["Reuben", "Simeon", "Levi", "Judah", "Dan", "Naphtali", "Gad", "Asher", "Issachar", "Zebulun", "Joseph", "Benjamin", "Simon", "Andrew", "James", "John", "Philip", "Bartholomew", "Thomas", "Matthew", "Thaddaeus", "Matthias"])
        user = User(newid, name)
        @info "adding $user"
        users[newid] = user
        id = newid
        @run """window.location.href = '/users/$id'"""
    end

    @onchange id begin
        @info "id changed to $id"
        if !isnothing(id)
            user = users[id]
        end
    end
end

# TODO: move to controller..
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

function updateId()
    @show paramid = params(:id)

    # needed to update the model if we are coming in from an url param
    model = @init
    if model.id[] != paramid
        model.id[] = paramid
    end
    return nothing
end

_layout=p"layout.jl"
@page("/users", view_list, layout=_layout)
@page("/users/new", view_new, layout=_layout)
@page("/users/:id::Int#([0-9\\-]+)", view_single, pre=updateId, layout=_layout)
# @page("/users/:id::Int#([0-9\\-]+)", p"users/view_single.jl", pre=updateId, layout=_layout)


end
