module Simulations

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Simulation

@kwdef mutable struct Simulation <: AbstractModel
  id::DbId = DbId()
  status::SimulationStatus = INIT
  start::DateTime = today() - Day(2)
  stop::DateTime = today() - Day(1)
  # data::DataFrame = DataFrame(time=DateTime[], value=Float64[])
end

# Explicit table name override
SearchLight.get_table_name(::Type{SimModel}) = "simulations"  # [3]

end
