
function view_new()
    [
        header(class="st-header q-pa-sm", [
            h2(class="st-header__title text-h3",
                "Add a new user"
            ),
            p([
                btn("Add", class="q-mr-sm", @click(:addButton)),
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
