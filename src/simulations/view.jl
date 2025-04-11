include("view_list.jl")
include("view_new.jl")
include("view_single.jl")

function view()
    [
        ################################################################################
        # This loads everything onto the screen, but conditionally hides it:
        # span(view_single(), @showif(:viewMode == VIEW)),
        # span(view_new(), @showif(:viewMode == NEW)),
        # span(view_list(), @showif(:viewMode == LIST)),

        ################################################################################
        # this syntax is supposed to load lazily,
        # but as far as I can tell everything is still loaded
        # https://vuejs.org/guide/essentials/conditional.html#v-show
        span(view_single(), @if(:viewMode == VIEW)),
        span(view_new(), @elseif(:viewMode == NEW)),
        span(view_list(), @else()),
    ]
end
