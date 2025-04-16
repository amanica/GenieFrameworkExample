
function view_single()
    [
        header(class="st-header q-pa-sm", [
            heading("Simulation: {{id}}"),
            h3(class="st-header__title text-h3",
                "Status: {{simulation.status}}"
            ),
            p([
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
