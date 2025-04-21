# the last statement is returned by the import so
# this file returns an array of html

[
    moduleToolbar("Simulations", [
        btn("New", class="q-mr-sm", @click(:newButton))
    ]),
    Stipple.table(
        :tableData,
        flat = true,
        bordered = true,
        # title = "Simulations",
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
]
