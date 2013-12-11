require 'csv'

datafile = Rails.root + 'db/data/mass_health_data.csv'

# TownHealthRecord.destroy_all

CSV.foreach(datafile, headers: true) do |row|

  row.each do |col|
    unless col[1] == nil
      col[1].gsub!('$', '')
      col[1].gsub!(',', '')
      col[1] = nil if col[1] == 'NA'
    end

  end

  TownHealthRecord.find_or_create_by(
    town: row[0],
    total_population_2005: row[1],
    population_0_to_19_2005: row[2],
    population_greater_than_65_2005: row[3],
    per_capita_income_2000: row[4],
    persons_below_poverty_2000: row[5],
    percent_persons_below_poverty_2000: row[6],
    percent_adequacy_pre_natal_care: row[7],
    percent_c_section_delivery_2005_to_2008: row[8],
    total_infant_deaths_2005_to_2008: row[9],
    infant_mortality_rate_per_thousand_2005_to_2008: row[10],
    percent_low_birthweight_2005_to_2008: row[11],
    percent_multiple_births_2005_to_2008: row[12],
    percent_publicly_financed_prenatal_care_2005_to_2008: row[13],
    percent_teen_births_2005_to_2008: row[14]
    )
end