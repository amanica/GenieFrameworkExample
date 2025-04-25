module CreateTableSimulationData

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices, constraint

@info "Creating table simulation_data"

function up()
  create_table(:simulation_data) do
    [
      pk(:id)
      column(:simulation_id, :int
        # , constraint(:simulations, :id)
      )
      column(:date, :datetime, not_null = true)
      column(:value, :float, not_null = true)
    ]
  end

  # huh, this seems to add 2 indexes instead of
  # a multi-column index
  add_indices(:simulation_data, :simulation_id, :date)
end

function down()
  drop_table(:simulation_data)
end

end