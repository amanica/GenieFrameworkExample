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
    * When clicking the add or list button for the first time on the page,
      the ui seems to get stuck and I'm not sure why,
      it must be some sort of initialization bug. If you refresh it comes right.
    * This seems very glitchy until all pages have been loaded :'(
"""

using ..GenieFrameworkExample # Only needed if you want to access project-wide globals
using GenieFramework, Stipple
using DataFrames
@genietools

Stipple.@kwdef mutable struct User
    id::Int
    name::AbstractString
end

# Fake db
users = Dict{Int, User}()

function usersAsDataFrame()
    if !isempty(users)
        data = [(id, user.name) for (id, user) in users]
        return DataFrame(data, [:id, :name])
    else
        # Create an empty DataFrame with predefined column names and types
        return DataFrame()#(id = Int[], name = String[])
    end
end

@app begin
    @out moduleInfo = MODULE_INFO
    @in newButton = false
    @in addButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @in user::User = User(0, "")

    @out tableData = DataTable(usersAsDataFrame())
    @in tablefilter = ""

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

        tableData = DataTable(usersAsDataFrame())
        # tableData.data = usersAsDataFrame()
        # @push tableData
        # I keep getting errors when using @push :'(
#         exception =
# │    MethodError: no method matching push!(::Main.GenieFrameworkExample.Users.var"Main.GenieFrameworkExample.Users_ReactiveModel!_1", ::StippleUI.Tables.DataTable{DataFrames.DataFrame})
# │    The function `push!` exists, but no method is defined for this combination of argument types.
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

include("view_list.jl")
include("view_new.jl")
include("view_single.jl")
include("controller.jl")

@page("/users", view_list, layout=LAYOUT)
@page("/users/new", view_new, layout=LAYOUT)
@page("/users/:id::Int#([0-9\\-]+)", view_single, post=updateIdFromUrl, layout=LAYOUT)

end
