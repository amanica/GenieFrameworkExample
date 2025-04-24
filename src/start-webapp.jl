(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

if !contains(Base.active_project(), "GenieFrameworkExample")
    using Pkg
    Pkg.activate("..")
end

loaded_modules_str = "$(keys(Base.loaded_modules))"
is_debug_mode = contains(loaded_modules_str, "VSCodeDebugger")

using Genie
@show Genie.config.run_as_server = is_debug_mode
basedir = @__DIR__
configPath = joinpath(basedir, "config")
Genie.Configuration.config!(;
    path_config=configPath,
    path_env=joinpath(configPath, "env"),
    path_initializers=joinpath(configPath, "initializers"),
    path_build=joinpath(basedir, "../build"),
    app_env="dev"
)

# Genie.loadapp()
include("GenieFrameworkExample.jl")

Genie.isrunning() && down()
up()

# Genie.routes()
