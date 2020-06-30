Hanami::Model.migration do
  change do
    create_table :county_updates do
      primary_key :id

      foreign_key :county_id, :counties, on_delete: :cascade, null: false

      column :cases, Integer
      column :deaths, Integer
      column :ltc_cases, Integer
      column :ltc_deaths, Integer

      column :date, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index [:county_id, :date], unique: true
    end
  end
end
