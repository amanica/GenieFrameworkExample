
function view_list()
    [
        header(class="st-header q-pa-sm", [
            h1(APP_NAME),
            p("Example module that changes view mode using an enum."),
            h2(class="st-header__title text-h3",
                "Simulations:"
            ),
            p([
                btn("New", class="q-mr-sm", @click(:newButton))
            ])
        ]),
    ]
end
