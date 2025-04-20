Stipple.Layout.page(model,[
    header(class="st-header q-pa-sm", [
        heading("User: {{id}}"),
        h3(class="st-header__title text-h3",
            "Name: {{user.name}}"
        ),
        p([
            btn("Add another", class="q-mr-sm", @click(:newButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
        ])
    ])
])
