
function view_new()
    [
        header(class="st-header q-pa-sm", [
        h2(class="st-header__title text-h3",
                "Run a new simulation"
            ),
            p([
                btn("Run", class="q-mr-sm", @click(:runButton)),
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
