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
using GenieFramework, Stipple
@genietools

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
            if !haskey(users, id)
                throw(Genie.Exceptions.NotFoundException("user id"))
            end
            user = users[id]
        end
    end
end

@created """
console.log('This app has just been created!');
document.querySelector('.layout_root').hidden = false;
"""

include("view_list.jl")
include("view_new.jl")
include("view_single.jl")
include("controller.jl")

@page("/users", view_list, layout=LAYOUT)
@page("/users/new", view_new, layout=LAYOUT)
@page("/users/:id::Int#([0-9\\-]+)", view_single, post=updateIdFromUrl, layout=LAYOUT)
# @page("/users/:id::Int#([0-9\\-]+)", p"users/view_single.jl", pre=updateId, layout=LAYOUT)

end
