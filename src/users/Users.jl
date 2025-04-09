"""
Example module that changes view mode using re-directs.
(Just re-run in vscode repl if changes are not picked up)

Pros:
    * Does not loads all views into the browser with all the data

Cons:
    * Switch slower between modes with page reload causing a flicker
    * I think there is an extra roundtrip when updating the model,
      it seems it renders the page and then immediately updates it.
"""


module Users

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple
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
    @in newButton = false
    @in addButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @in user::User = User(0, "")

    @onbutton listButton begin
        @info "listButton"
        @run raw"window.location.href = '/users'"
    end

    @onbutton newButton begin
        @info "newButton"
        # redirect("/users/new") # this is not working :'(
        # Stipple.redirect("/users/new") # this is not working :'(
        # Stipple.redirect(:get_users_new) # this is not working :'(

        @run raw"window.location.href = '/users/new'"
    end

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

@page("/users", view_list)
@page("/users/new", view_new)
@page("/users/:id::Int#([0-9\\-]+)", view_single)

end
