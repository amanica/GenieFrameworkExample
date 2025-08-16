# the last statement is returned by the import so
# this file returns a function that gets loaded by Genie
FORM_LEFT = 3
FORM_RIGHT = 9
function view_new()
    [
        moduleToolbar("Run a new simulation", [
            btn("Run", class="q-mr-sm", @click(:runButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
        ]),
        row(class = "q-pa-sm", [
            card(class = "q-pa-sm col-12 col-md-7", [
                row([
                    cell(size = FORM_LEFT, [p("Date range", class="text-h5"),
                        p("(End date is exclusive)", class="text-subtitle1")
                    ]),
                    datepicker(size = FORM_RIGHT, :daterange, range = true, todaybtn = true,
                        # title="", # this obscures the summary eg "2 days"
                        # subtitle="", # this obscures the current month
                        landscape = true,
                        # color = "red",
                        events = ["2025/05/03","2025/05/10"], # TODO: add today and next week
                        # eventsfn! = "(date) => date === '2025/05/17'", could not get this to work
                        # eventcolor = "green",
                        event__color! = "(date) => date[9] % 2 === 0 ? 'green' : 'orange'",
                        navmaxyearmonth=Dates.format(today(), "yyyy/mm"))
                ]),
            ])
        ]),
    ]
end
