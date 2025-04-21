join([
    moduleToolbar("User", [
        btn("Add another", class="q-mr-sm", @click(:newButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
    ]),
    heading("Id: {{id}}"),
    h3(class="st-header__title text-h3",
        "Name: {{user.name}}"
    ),
])
