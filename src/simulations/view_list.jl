# the last statement is returned by the import so
# this file returns an array of html
[
    moduleToolbar("Simulations", [
        btn("New", class="q-mr-sm", @click(:newButton))
    ]),
    card(class = "q-ma-sm q-pa-sm", Stipple.table(
        :tableData,
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
        );
        @on(:row__click, :table_row_clicked, [:addTableInfo, :addClickInfo]),
        flat = true,
        bordered = true,
        # title = "Simulations",
        var"row-key" = "id",
        filter = :tablefilter,
        # hideheader = "",
    ))
]
