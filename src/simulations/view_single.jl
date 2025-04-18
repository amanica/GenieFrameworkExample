[
    header(class="st-header q-pa-md", [
        heading("Simulation"),
        p([
            btn("Run another", class="q-mr-sm", @click(:newButton)),
            btn("List", class="q-mr-sm", @click(:listButton))
        ])
    ]),
    row([
        cell(class = "st-module col-12 col-md-3", [
            row([
                cell("Id"),
                cell("{{id}}")
            ]),
            row([
                cell("Status"),
                cell("{{simulation.status}}")
            ]),
            row([
                cell("What happens if we add a bit more text?"),
                cell("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam maximus suscipit nulla sodales feugiat.")
            ]),
        ]),
        cell(class = "col-12 col-md-9", "Maecenas venenatis turpis vitae risus commodo aliquam. Suspendisse non quam vel erat viverra gravida. Sed non tincidunt tortor. Aenean fringilla suscipit ex ac hendrerit.")
    ]),
]
