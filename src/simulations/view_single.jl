
function view_single()
    [
        header(class="st-header q-pa-sm", [
            heading("Simulation"),
            p([
                btn("Run another", class="q-mr-sm", @click(:newButton)),
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ]),
        row([
            cell(class = "st-module col-shrink", [
                row([
                    cell("Id"),
                    cell("{{id}}")
                ]),
                row([
                    cell("Status"),
                    cell("{{simulation.status}}")
                ]),
                row([
                    cell("What happens if we add a bit more text?"),
                    cell("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam maximus suscipit nulla sodales feugiat.")
                ]),
            ]),
            cell(class = "col-grow", "")
        ]),
    ]
end
