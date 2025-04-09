
function view_single()
    [
        header(class="st-header q-pa-sm", [
            h1(APP_NAME),
            h2(class="st-header__title text-h3",
                "Simulation: {{uuid}}"
            ),
            h3(class="st-header__title text-h3",
                "Status: {{status}}"
            ),
            p([
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
