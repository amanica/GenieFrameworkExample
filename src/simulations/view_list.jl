
function view_list()
    [
        header(class="st-header q-pa-sm", [
            h2(class="st-header__title text-h3",
                "Simulations:"
            ),
            #TODO: show simulation list
            p([
                btn("New", class="q-mr-sm", @click(:newButton))
            ])
        ]),
    ]
end
