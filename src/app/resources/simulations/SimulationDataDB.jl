module SimulationDataDB

import SearchLight: AbstractModel, DbId
import Base: @kwdef
using Dates

export SimulationData

@kwdef mutable struct SimulationData <: AbstractModel
  simulation_id::DbId
  date::DateTime
  value::Float64
end

end