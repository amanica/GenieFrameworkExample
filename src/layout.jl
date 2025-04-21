
page(model,
    StippleUI.layout(view="hHh Lpr lff", [
        h1(class="st-header q-pa-sm", APP_NAME),
        @yield,
        pre(MODULE_INFO)
    ]);
    title = APP_NAME,
    partial = false,

    # try to avoid really weird rendering of content until page is loaded
    @if(:isready), #did not seem to help reduce the weird initialization
    hidden = true,
    class = "layout_root"
)

