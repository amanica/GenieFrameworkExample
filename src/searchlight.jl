using Genie, SearchLight, SearchLightSQLite

function Genie.Renderer.Json.JSON3.StructTypes.StructType(::Type{T}) where {T<:SearchLight.AbstractModel}
  Genie.Renderer.Json.JSON3.StructTypes.Struct()
end

function Genie.Renderer.Json.JSON3.StructTypes.StructType(::Type{SearchLight.DbId})
  Genie.Renderer.Json.JSON3.StructTypes.Struct()
end

@info "Loading SearchLight configuration"
SearchLight.Configuration.load(joinpath(pwd(), "db/connection.yml"))
@show CONNECTION = SearchLight.connect()
try
  SearchLight.Migrations.init()
catch e
  # @error "Could not init migration: $e"
end
# SearchLight.Migrations.up()
