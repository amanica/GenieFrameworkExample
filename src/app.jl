module GenieFrameworkExample
export APP_NAME

using GenieFramework
@genietools

const APP_NAME = "An example GenieFramework project"

include("users/Users.jl")
include("simulations/Simulations.jl")

route("/") do
    serve_static_file("index.html")
end

end
