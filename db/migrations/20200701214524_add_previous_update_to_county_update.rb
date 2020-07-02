Hanami::Model.migration do
  change do
    alter_table :county_updates do
      add_foreign_key :previous_update_id, :county_updates
    end
  end
end
