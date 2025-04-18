# the last statement is returned by the import so
# this file returns a function that gets loaded by Genie
function view_new()
    [
        header(class="st-header q-pa-sm", [
            heading("Run a new simulation"),
            p([
                btn("Run", class="q-mr-sm", @click(:runButton)),
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
