[
    moduleToolbar("Simulation", [
        btn("Run another", class="q-mr-sm", @click(:newButton)),
        btn("List", class="q-mr-sm", @click(:listButton))
    ]),
    row(class = "q-pa-sm", [
        card(class = "q-pa-sm col-12 col-md-4", [
            row(class = "q-pa-xs", [
                cell("Id"),
                cell("{{simulation.id.value}}")
            ]),
            row(class = "q-pa-xs", [
                cell("Status"),
                cell("{{simulation.status}}")
            ]),
            row(class = "q-pa-xs", [
                cell("Start"),
                cell("{{simulation.start}}")
            ]),
            row(class = "q-pa-xs", [
                cell("Stop"),
                cell("{{simulation.stop}}")
            ]),
            row(class = "q-pa-xs", [
                cell("What happens if we add a bit more text?"),
                cell("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam maximus suscipit nulla sodales feugiat.")
            ]),
            row(class = "q-pa-xs", [
                cell("Progress Badge"),
                cell([
                    # this is not working :'(
                    # badge(
                    #     "{{simulation_progress*100}}%",
                    #     transparent=true
                    # ),
                    quasar(:badge,
                        htmldiv("{{simulation_progress*100}}%"),
                        transparent=true,
                    ),
                ])
            ]),
            row(class = "q-pa-xs", [
                cell("Progress Knob"),
                cell([
                    knob(0:1:100, :simulation_progressPercent,
                        "{{simulation_progress*100}}%",
                        class="text-light-blue",
                        color = "primary",
                        track__color = "grey-3",
                        thickness=0.33, # this causes a warning:
                        #vue.global.js:1612 [Vue warn]: Invalid prop: type check failed for prop "thickness". Expected Number with value 0.33, got String with value "0.33".
                        show__value=true,
                        readonly=true,
                    ),
                ])
            ]),
            row(class = "q-pa-xs", [
                cell("Linear Progress"),
                cell([
                    quasar(:linear__progress,
                        cell(
                            quasar(:badge,
                                htmldiv("{{simulation_progress*100}}%"),
                                transparent=true,
                            ),
                            class = "absolute-full flex flex-center"
                        ),
                        value=:simulation_progress,
                        # value=:simulation_progressPercent/100.0, # this is not working :'(
                        size="25px",
                        stripe=true,
                        rounded=true,
                    )
                ])
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
