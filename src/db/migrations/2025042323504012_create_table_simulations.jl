module CreateTableSimulations

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:simulations) do
    [
      pk(:id)
      column(:status, :string, limit = 10, not_null = true)
      column(:start, :datetime, not_null = true)
      column(:stop, :datetime, not_null = true)
    ]
  end
end

function down()
  drop_table(:simulations)
end

end
