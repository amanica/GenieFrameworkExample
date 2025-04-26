using Genie, SearchLight, SearchLightSQLite

function Genie.Renderer.Json.JSON3.StructTypes.StructType(::Type{T}) where {T<:SearchLight.AbstractModel}
  Genie.Renderer.Json.JSON3.StructTypes.Struct()
end

function Genie.Renderer.Json.JSON3.StructTypes.StructType(::Type{SearchLight.DbId})
  Genie.Renderer.Json.JSON3.StructTypes.Struct()
end

function Base.convert(::Type{DateTime}, value::AbstractString)
  try
    return DateTime(value, "yyyy-mm-ddTHH:MM:SS")
  catch e
    @error "Failed to convert string to DateTime: $value" exception=e
    rethrow(e)
  end
end

@info "Loading SearchLight configuration"
SearchLight.Configuration.load(joinpath(pwd(), "db/connection.yml"))
@show CONNECTION = SearchLight.connect()
try
  SearchLight.Migrations.init()
catch e
  # @error "Could not init migration: $e"
end
SearchLight.Migrations.allup()
