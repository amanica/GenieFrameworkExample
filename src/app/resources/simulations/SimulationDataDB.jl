module SimulationDataDB

import SearchLight: AbstractModel, DbId
import Base: @kwdef
using Dates

export SimulationData

@kwdef mutable struct SimulationData <: AbstractModel
  id::DbId = DbId()
  simulation_id::DbId = DbId()
  datetime::DateTime = now()
  value::Float64 = 0.0
end

end