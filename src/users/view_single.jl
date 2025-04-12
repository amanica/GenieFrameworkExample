function view_single()
    return [
        header(class="st-header q-pa-sm", [
            h2(class="st-header__title text-h3",
                "User: {{id}}"
            ),
            h3(class="st-header__title text-h3",
                "Name: {{user.name}}"
            ),
            p([
                btn("List", class="q-mr-sm", @click(:listButton))
            ])
        ])
    ]
end
