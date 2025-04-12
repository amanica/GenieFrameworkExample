
# moduleInfo = :MODULE_INFO ∈ names(@__MODULE__; all=true) ? (@__MODULE__).MODULE_INFO : ""
# moduleInfo = ""
page(model, [
            h1(APP_NAME),
            @yield,
            pre(MODULE_INFO)
        ];
        title = APP_NAME,
        partial = false,

        # try to avoid really weird rendering of content until page is loaded
        # @if(:isready) did not seem to help
        hidden = true,
        class = "layout_root"
    )

