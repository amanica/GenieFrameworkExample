
page(model,
    StippleUI.layout(view="hHh lpr fff", [
        quasar(:header,
            style="padding: 0; height: 50px;",
            toolbar([
                btn(; dense=true, flat=true, round=true, icon="menu", @click("left_drawer_open = !left_drawer_open")),
                toolbartitle(APP_NAME)
            ])),
            drawer(bordered=true, fieldname="left_drawer_open", side="left",
            overlay=false,
            var":mini"="ministate", var"@mouseover"="ministate = false", var"@mouseout"="ministate = true", var"mini-to-overlay"=true,
            width=170,
            # breakpoint=200,
                             list(bordered=true, separator=true,
                                  [
                                   item(href = "/users",
                                        [
                                         itemsection(avatar=true, icon("badge")),
                                         itemsection("Users")
                                        ]),
                                   item(href = "/simulations",
                                        [
                                         itemsection(avatar=true, icon("filter_7")),
                                         itemsection("Simulations")
                                        ]),
                                  ]
                                 )),
        page_container([
            @yield
        ]),
        quasar(:footer, class = "q-pa-sm", [
            pre(MODULE_INFO)
        ])
    ]);
    title = APP_NAME,
    partial = false,

    # try to avoid really weird rendering of content until page is loaded
    @if(:isready), #did not seem to help reduce the weird initialization
    hidden = true,
    class = "layout_root"
)

