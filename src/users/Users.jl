"""
Example module that changes view mode using re-directs.
(Just re-run in vscode repl if changes are not picked up)

Pros:
    * Does not loads all views into the browser with all the data

Cons:
    * Switch slower between modes with reload
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

users = Vector{User}()

@app begin
    @in newButton = false
    @in addButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing

    @onbutton listButton begin
        @info "listButton"
        redirect(:get_users) # FIXME: this is not working :'(
    end

    @onbutton newButton begin
        @info "newButton"
        Stipple.redirect("/users/new") # FIXME: this is not working :'(
        Stipple.redirect(:get_users_new) # FIXME: this is not working :'(
    end

    @onbutton addButton begin
        @info "addButton"

        id = rand(Int8)
        name = rand(["Reuben", "Simeon", "Levi", "Judah", "Dan", "Naphtali", "Gad", "Asher", "Issachar", "Zebulun", "Joseph", "Benjamin", "Simon", "Andrew", "James", "John", "Philip", "Bartholomew", "Thomas", "Matthew", "Thaddaeus", "Matthias"])
        user = User(id, name)
        @info "adding $user"
        push!(users, user)
        redirect(:get_users_single) # FIXME: this is not working :'(
    end
end

@page("/users", view_list)
@page("/users/new", view_new)
@page("/users/single", view_single)

end
