Stipple.Layout.page(
    model,
    [

    ################################################################################
    # This loads everything onto the screen, but conditionally hides it:
    # span(@showif(:viewMode == SINGLE),
    # include("simulations/view_single.jl")),
    # span(@showif(:viewMode == NEW),
    # include("simulations/view_new.jl")),
    # span(@showif(:viewMode == LIST),
    # include("simulations/view_list.jl")),
    ################################################################################

    ################################################################################
    # this syntax is supposed to load lazily,
    # but as far as I can tell everything is still loaded
    # https://vuejs.org/guide/essentials/conditional.html#v-show
    span(@if(:viewMode == SINGLE),
        include("simulations/view_single.jl")),
    span(@elseif(:viewMode == NEW),
        include("simulations/view_new.jl")),
    span(@else(),
        include("simulations/view_list.jl")),

    ################################################################################
])