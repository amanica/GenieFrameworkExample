module Users
const MODULE_INFO = """
Example module that changes view mode using re-directs.
(Just re-run the Users.jl module in vscode repl if changes are not picked up)

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
using GenieFramework, Stipple, FilePathsBase
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
        # return  DataFrame(id = Int[], name = String[])
        return DataFrame()
    end
end

@app begin
    # needed for drawer layout:
    @in left_drawer_open = false
    @in ministate = true

    @out moduleInfo = MODULE_INFO
    @in newButton = false
    @in addButton = false
    @in listButton = false
    @out id::Union{Nothing, Int} = nothing
    @out user::User = User(0, "")

    @out tableData = DataTable(usersAsDataFrame())
    @in tablefilter = ""

    @onbutton listButton listButtonClicked()
    @onbutton newButton newButtonClicked()
    @onbutton addButton addButtonClicked()

    @onchange id idChanged()
end

include("view_list.jl")
include("controller.jl")

# loading from a file so that auto-reloading works:
@page("/users", p"users/view_list.jl", layout=LAYOUT, post=updateTable)
@page("/users/new", p"users/view_new.jl", layout=LAYOUT)
@page("/users/:id::Int#([0-9\\-]+)", p"users/view_single.jl", post=updateIdFromUrl, layout=LAYOUT)

end
