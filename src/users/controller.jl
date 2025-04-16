include("../controller_common.jl")

function jsredirect(path)
    return """window.location.href = '$path'"""
end

@handler function listButtonClicked()
    @info "listButtonClicked"
    @run raw"window.location.href = '/users'"
end

@handler function newButtonClicked()
    @info "newButtonClicked"
    # redirect("/users/new") # this is not working :'(
    # Stipple.redirect("/users/new") # this is not working :'(
    # Stipple.redirect(:get_users_new) # this is not working :'(

    @run jsredirect("/users/new")
end

@handler function addButtonClicked()
    @info "addButtonClicked"

    newid = rand(Int8)
    name = rand(["Reuben", "Simeon", "Levi", "Judah", "Dan", "Naphtali", "Gad", "Asher", "Issachar", "Zebulun", "Joseph", "Benjamin", "Simon", "Andrew", "James", "John", "Philip", "Bartholomew", "Thomas", "Matthew", "Thaddaeus", "Matthias"])
    user = User(newid, name)
    @info "adding $user"
    users[newid] = user
    id = newid
    @run """window.location.href = '/users/$id'"""


    # tableData.data = usersAsDataFrame()
    # @push tableData
    # I keep getting errors when using @push :'(
#         exception =
# │    MethodError: no method matching push!(::Main.GenieFrameworkExample.Users.var"Main.GenieFrameworkExample.Users_ReactiveModel!_1", ::StippleUI.Tables.DataTable{DataFrames.DataFrame})
# │    The function `push!` exists, but no method is defined for this combination of argument types.
end

@handler function idChanged()
    @info "id changed to $id"
    if !isnothing(id)
        if !haskey(users, id)
            throw(Genie.Exceptions.NotFoundException("user id"))
        end
        user = users[id]
    end
end

@handler function updateIdFromUrl()
    paramid = params(:id)

    # needed to update the model if we are coming in from an url param
    if id != paramid
        id = paramid
    end
    return nothing
end

@handler function updateTable()
    tableData = DataTable(usersAsDataFrame())
    return nothing
end
