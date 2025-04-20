
Stipple.Layout.page(model,[
    header(class="st-header q-pa-sm", [
        heading("Add a new user:"),
        p([
            btn("Add", class="q-mr-sm", @click(:addButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
        ])
    ])
])