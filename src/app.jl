module GenieFrameworkExample
export APP_NAME

using GenieFramework
@genietools

const APP_NAME = "An example GenieFramework project"

include("simulations/Simulations.jl")

# route("/") do
#     serve_static_file("welcome.html")
# end
route("/") do
    redirect(:get_simulations)
end

end
