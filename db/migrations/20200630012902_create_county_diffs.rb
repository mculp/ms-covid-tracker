Hanami::Model.migration do
  change do
    create_table :county_diffs do
      primary_key :id

      column :cases, Integer
      column :deaths, Integer
      column :ltc_cases, Integer
      column :ltc_deaths, Integer

      column :date, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
