
function view_list()
    [
        header(class="st-header q-pa-sm", [
            heading("Simulations:"),
            #TODO: show simulation list
            p([
                btn("New", class="q-mr-sm", @click(:newButton))
            ])
        ]),
    ]
end
