module GenieFrameworkExample

export APP_NAME, LAYOUT

using GenieFramework, Stipple, FilePathsBase
@genietools

const APP_NAME = "An example GenieFramework project"
const LAYOUT = p"layout.jl" # need to load from file to get access to model

include("searchlight.jl")
include("app/resources/simulations/SimulationsDB.jl")
include("app/resources/simulations/SimulationDataDB.jl")

include("users/Users.jl")
include("simulations/Simulations.jl")


route("/") do
    redirect(:get_simulations)
end

end
