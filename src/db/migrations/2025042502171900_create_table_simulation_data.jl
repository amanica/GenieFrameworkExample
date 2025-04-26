module CreateTableSimulationData

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices, constraint

@info "Creating table simulationdata"

function up()
  create_table(:simulationdata) do
    [
      pk(:id)
      column(:simulation_id, :int
        # , constraint(:simulations, :id)
      )
      column(:datetime, :datetime, not_null = true)
      column(:value, :float, not_null = true)
    ]
  end

  # huh, this seems to add 2 indexes instead of
  # a multi-column index
  add_indices(:simulationdata, :simulation_id, :datetime)
end

function down()
  drop_table(:simulationdata)
end

end