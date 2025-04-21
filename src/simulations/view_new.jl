# the last statement is returned by the import so
# this file returns a function that gets loaded by Genie
function view_new()
    [
        moduleToolbar("Run a new simulation", [
            btn("Run", class="q-mr-sm", @click(:runButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
        ]),
        row(class = "q-pa-sm", [
            card(class = "q-ma-sm q-pa-sm col-12 col-md-4", [
                row([
                    cell("Date range"),
                    datepicker(:daterange, range = true, todaybtn = true)
                ]),
            ])
        ]),
    ]
end
