
function view_list()
    [
        header(class="st-header q-pa-sm", [
            heading("Simulations:"),
            #TODO: show simulation list
            p([
                btn("New", class="q-mr-sm", @click(:newButton))
            ]),
            table(
                :tableData,
                flat = true,
                bordered = true,
                title = "Simulations",
                var"row-key" = "id",
                filter = :tablefilter,
                hideheader = "",
                template(
                    var"v-slot:top-right" = "",
                    textfield(
                        "",
                        :tablefilter,
                        dense = true,
                        debounce = "300",
                        placeholder = "Search",
                        [template(var"v-slot:append" = true, icon("search"))],
                    ),
                ),
            )
        ]),
    ]
end
