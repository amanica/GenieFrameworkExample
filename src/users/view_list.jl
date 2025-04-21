join([
    moduleToolbar("Users", [
        btn("New", class="q-mr-sm", @click(:newButton))
    ]),
    table(
        :tableData,
        flat = true,
        bordered = true,
        title = "Users",
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
])
