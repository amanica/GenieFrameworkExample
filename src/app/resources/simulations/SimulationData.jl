module SimulationData

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export SimulationData

@kwdef mutable struct SimulationData <: AbstractModel
  simulation_id::DbId
  date::DateTime
  value::Float64
end

end