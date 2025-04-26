module SimulationsDB

import SearchLight: AbstractModel, DbId
import Base: @kwdef
using Dates

export Simulation, SimulationStatus

@enum SimulationStatus INIT RUNNING SUCCESS FAIL

@kwdef mutable struct Simulation <: AbstractModel
  id::DbId = DbId()
  status::SimulationStatus = INIT
  start::DateTime = today() - Day(2)
  stop::DateTime = today() - Day(1)
end

# I could not find an easy way to do this yet :(
# maybe Julia needs to maintain a map for easy lookups..
function parseEnum(enum::Type{E},
  enumString::AbstractString, default::Union{E,Nothing}=nothing) where {E}
  #println("Looking for element of $enum: $enumString")
  for e in instances(enum)
      if "$e" == enumString
          return e
      end
  end
  if default !== nothing
      return default
  end
  error("Could not find element of $enum: $enumString")
end

function Base.convert(::Type{SimulationStatus}, value::AbstractString)
  try
    return parseEnum(SimulationStatus, value)
  catch e
    @error "Failed to convert string to SimulationStatus: $value" exception=e
    rethrow(e)
  end
end

end
