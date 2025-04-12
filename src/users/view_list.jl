
function view_list()
    [
        header(class="st-header q-pa-sm", [
            # pre(MODULE_INFO),
            # p("view info: {{moduleInfo}}"),
            h2(class="st-header__title text-h3",
                "Users:"
            ),
            #TODO: show user list
            p([
                btn("New", class="q-mr-sm", @click(:newButton))
            ])
        ]),
    ]
end
