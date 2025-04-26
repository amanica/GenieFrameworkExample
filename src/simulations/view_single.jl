[
    moduleToolbar("Simulation", [
        btn("Run another", class="q-mr-sm", @click(:newButton)),
        btn("List", class="q-mr-sm", @click(:listButton))
    ]),
    row(class = "q-pa-sm", [
        card(class = "q-pa-sm col-12 col-md-4", [
            row([
                cell("Id"),
                cell("{{simulation.id.value}}")
            ]),
            row([
                cell("Status"),
                cell("{{simulation.status}}")
            ]),
            row([
                cell("Start"),
                cell("{{simulation.start}}")
            ]),
            row([
                cell("Stop"),
                cell("{{simulation.stop}}")
            ]),
            row([
                cell("What happens if we add a bit more text?"),
                cell("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam maximus suscipit nulla sodales feugiat.")
            ]),
        ]),
        card(class = "q-pa-sm col-12 col-md-8",
            [StipplePlotly.plot(:traces, layout=:layout, class="sync_data mb-4"
            )]),
        cell(class = "col-12 col-md-12",
            [
        "Maecenas venenatis turpis vitae risus commodo aliquam. Suspendisse non quam vel erat viverra gravida. Sed non tincidunt tortor. Aenean fringilla suscipit ex ac hendrerit."])
    ]),
]
