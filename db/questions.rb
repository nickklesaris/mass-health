# What 3 towns have the highest population of citizens that are 65 years and older?

TownHealthRecord.select(:town).order("population_greater_than_65_2005 DESC").limit(3)

#SELECT town FROM town_health_records ORDER BY population_greater_than_65_2005 DESC LIMIT 3;
#---------------------------------------------------

# What 3 towns have the highest population of citizens that are 19 years and younger?

TownHealthRecord.select(:town).order("population_0_to_19_2005 DESC").limit(3)

#SELECT town FROM town_health_records ORDER BY population_0_to_19_2005 DESC LIMIT 3;
#---------------------------------------------------

# What 5 towns have the lowest per capita income?

TownHealthRecord.select(:town).order("per_capita_income_2000").limit(5)

#SELECT town FROM town_health_records ORDER BY per_capita_income_2000 ASC LIMIT 5;
#---------------------------------------------------

# Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?

TownHealthRecord.select(:town).where.not(town: 'Boston').order("percent_teen_births_2005_to_2008 DESC NULLS LAST").limit(1)

#SELECT town FROM town_health_records WHERE town NOT LIKE '%Boston%' AND town NOT LIKE '%Becket%' AND town NOT LIKE '%Beverly%' AND percent_teen_births_2005_to_2008 IS NOT NULL ORDER BY percent_teen_births_2005_to_2008 DESC LIMIT 1;
#---------------------------------------------------

# Omitting Boston, what town has the highest number of infant mortalities?

TownHealthRecord.select(:town).where.not(town: 'Boston').order("infant_mortality_rate_per_thousand_2005_to_2008 DESC NULLS LAST").limit(1)

#SELECT town, infant_mortality_rate_per_thousand_2005_to_2008 FROM town_health_records WHERE town NOT LIKE '%Boston%' AND infant_mortality_rate_per_thousand_2005_to_2008 IS NOT NULL ORDER BY infant_mortality_rate_per_thousand_2005_to_2008 DESC LIMIT 1;
#---------------------------------------------------

# Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?

TownHealthRecord.select(:town).where(town: TownHealthRecord.select(:town).order("per_capita_income_2000 DESC").limit(5)).order("persons_below_poverty_2000 DESC").limit(1)

#SELECT town FROM town_health_records WHERE town IN (SELECT town FROM town_health_records ORDER BY per_capita_income_2000 DESC LIMIT 5) ORDER BY persons_below_poverty_2000 DESC LIMIT 1;
#---------------------------------------------------

# Of the towns that start with the letter b, which has the highest population?

TownHealthRecord.select(:town).where("town ILIKE 'b%'").order("total_population_2005 DESC").limit(1)

#SELECT town FROM town_health_records WHERE town LIKE 'B%' AND total_population_2005 IS NOT NULL ORDER BY total_population_2005 DESC LIMIT 1;
#---------------------------------------------------

# Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?

#TownHealthRecord.select(:town).where(town: TownHealthRecord.select(:town).where("percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL").order("percent_publicly_financed_prenatal_care_2005_to_2008 DESC").limit(10).where(town: TownHealthRecord.select(:town).where("total_infant_deaths_2005_to_2008 IS NOT NULL").order("total_infant_deaths_2005_to_2008 DESC").limit(10))


#SELECT town FROM town_health_records WHERE town IN (SELECT town FROM town_health_records WHERE percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL ORDER BY percent_publicly_financed_prenatal_care_2005_to_2008 DESC LIMIT 10) AND town IN (SELECT town FROM town_health_records WHERE total_infant_deaths_2005_to_2008 IS NOT NULL ORDER BY total_infant_deaths_2005_to_2008 DESC LIMIT 10);
#---------------------------------------------------

# Which town has the highest percent multiple births?

TownHealthRecord.select(:town).where("percent_multiple_births_2005_to_2008 IS NOT NULL").order("percent_multiple_births_2005_to_2008 DESC").limit(1)

#SELECT town FROM town_health_records WHERE percent_multiple_births_2005_to_2008 IS NOT NULL ORDER BY percent_multiple_births_2005_to_2008 DESC LIMIT 1;
#---------------------------------------------------

# What is the percent adequacy of prenatal care in that town?

#SELECT percent_adequacy_pre_natal_care FROM town_health_records WHERE percent_multiple_births_2005_to_2008 IS NOT NULL ORDER BY percent_multiple_births_2005_to_2008 DESC LIMIT 1;
#---------------------------------------------------

# Excluding towns that start with W, how many towns are part of this data?

TownHealthRecord.where("town NOT ILIKE 'w%'").count(:town)

#SELECT DISTINCT count('town') FROM town_health_records WHERE town NOT LIKE 'W%' AND town IS NOT NULL;
#---------------------------------------------------

# How many towns have a lower per capita income than that of Boston?

TownHealthRecord.where("per_capita_income_2000 < (SELECT per_capita_income_2000 FROM town_health_records WHERE town = 'Boston')").count(:town)

#SELECT count(*) FROM town_health_records WHERE per_capita_income_2000 < (SELECT per_capita_income_2000 FROM town_health_records WHERE town = 'Boston');
