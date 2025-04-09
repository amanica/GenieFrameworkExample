(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

if !contains(Base.active_project(), "GenieFrameworkExample")
    using Pkg
    Pkg.activate("..")
end

loaded_modules_str = "$(keys(Base.loaded_modules))"
is_debug_mode = contains(loaded_modules_str, "VSCodeDebugger")

using Genie
@show Genie.config.run_as_server = is_debug_mode

Genie.loadapp()
Genie.isrunning() && down()
up()

# Genie.routes()
