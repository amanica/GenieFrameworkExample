
function view_list()
    [
        header(class="st-header q-pa-sm", [
            h1(APP_NAME),
            p("Example module that changes view mode using redirects, but it is NOT working at the moment '( ."),
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
