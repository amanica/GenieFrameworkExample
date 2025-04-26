module SimulationsDB

import SearchLight: AbstractModel, DbId
import Base: @kwdef
using Dates

export Simulation, setStatus

@enum SimulationStatus INIT RUNNING SUCCESS FAIL

@kwdef mutable struct Simulation <: AbstractModel
  id::DbId = DbId()
  status::AbstractString = string(INIT) #TODO: use enum
  start::DateTime = today() - Day(2)
  stop::DateTime = today() - Day(1)
end

function setStatus(simulation::Simulation, status::SimulationStatus)
  simulation.status = string(status)
end

end
