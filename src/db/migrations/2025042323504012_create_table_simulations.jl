module CreateTableSimulations

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:simulations) do
    [
      primary_key()
      column(:status, :string, limit = 10)
      column(:start, :datetime)
      column(:stop, :datetime)
    ]
  end

  # add_index(:simulations, :column_name)
  # add_indices(:simulations, :column_name_1, :column_name_2)
end

function down()
  drop_table(:simulations)
end

end
