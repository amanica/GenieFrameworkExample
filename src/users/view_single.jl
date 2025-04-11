function view_single()

    # needed to update the model if we are coming in from an url param
    paramid = params(:id)
    model = @init
    if model.id[] != paramid
        model.id[] = paramid
    end

    [
        header(class="st-header q-pa-sm", [
            h1(APP_NAME),
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
