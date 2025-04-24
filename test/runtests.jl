using Test

# using Genie

# basedir = joinpath(@__DIR__, "../src")
# (pwd() != basedir) && cd(basedir) # allow starting app from bin/ dir

# configPath = joinpath(basedir, "config")
# Genie.Configuration.config!(;
#     path_config=configPath,
#     path_env=joinpath(configPath, "env"),
#     path_initializers=joinpath(configPath, "initializers"),
#     path_build=joinpath(basedir, "../build"),
#     app_env="dev"
# )
# include("../src/GenieFrameworkExample.jl")
# using GenieFrameworkExample

include("simulations_test.jl")