Hanami::Model.migration do
  up do
    execute <<~SQL
      create or replace view county_with_latest_updates as (
        with
          county_updates_with_number as
          (
            select
            row_number() over (partition by county_id order by date desc) as row_number,
            *
            from county_updates
          ),
          latest_update as
          (
            select county_id, cases, deaths, date
            from county_updates_with_number
            where county_updates_with_number.row_number = 1
          ),
          previous_update as
          (
            select county_id, cases, deaths, date
            from county_updates_with_number
            where county_updates_with_number.row_number = 2
          )

        select
          counties.name as county_name,
          latest_update.cases - previous_update.cases as new_cases,
          latest_update.deaths - previous_update.deaths as new_deaths,
          latest_update.cases,
          latest_update.deaths,
          latest_update.county_id,
          latest_update.date
        from latest_update
        inner join previous_update on latest_update.county_id = previous_update.county_id
        inner join counties on latest_update.county_id = counties.id
        order by new_cases desc
      )
    SQL
  end

  down do
    execute 'drop view county_with_latest_updates'
  end
end
