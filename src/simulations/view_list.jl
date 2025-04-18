# the last statement is returned by the import so
# this file returns an array of html

# sweet we can call functions now \o/
function myheading(text)
    return heading(text * " !")
end

[
    header(class="st-header q-pa-sm", [
        myheading("Simulations"),
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
