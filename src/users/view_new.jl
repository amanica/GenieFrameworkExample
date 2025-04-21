join([
    moduleToolbar("Add a new user", [
        btn("Add", class="q-mr-sm", @click(:addButton)),
        btn("List", class="q-mr-sm", @click(:listButton))
    ]),
])
