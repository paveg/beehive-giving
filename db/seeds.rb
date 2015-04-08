# Create application processes
ApplicationProcess.destroy_all
[
  "Eligibility form",
  "Enquiry form",
  "Email enquiry",
  "Phone enquiry",
  "Inital call",
  "Initial meeting",
  "Concept note",
  "Stage 1 application",
  "Stage 2 application",
  "Stage 3 application",
  "Interview",
  "Site visit",
  "Pitch",
  "Public vote",
  "Panel vote",
  "Follow on questions"
].each do |state|
  ApplicationProcess.create(label:state)
end

# Create appliation supports
ApplicationSupport.destroy_all
[
  "Email",
  "Contact number",
  "Guidance document"
].each do |state|
  ApplicationSupport.create(label:state)
end

# Create reporting requirements
ReportingRequirement.destroy_all
[
  "End of funding",
  "Mid-point",
  "Annually"
].each do |state|
  ReportingRequirement.create(label:state)
end

# Create implementors
Implementor.destroy_all
[
  "Paid staff",
  "Volunteers",
  "Beneficiaries",
  "Third parties",
  "Other"
].each do |state|
  Implementor.create(label:state)
end
#
# # Create beneficiaries
# Beneficiary.destroy_all
# [
#   "People with disabilities",
#   "People with physical diseases or disorders",
#   "People with mental diseases or disorders",
#   "People in education",
#   "Unemployed people",
#   "People with income poverty",
#   "People from a particular ethnic background",
#   "People affected by or involved with criminal activities",
#   "People with housing/shelter challenges",
#   "People with family or relationship challenges",
#   "People with a specific sexual orientation",
#   "People with specific religious or spiritual beliefs",
#   "People affected by disasters",
#   "People with water/sanitation access challenges",
#   "People with food access challenges",
#   "Animals/Wildlife",
#   "The environment",
#   "Organisations",
#   "Other"
# ].each do |state|
#   Beneficiary.create(label:state)
# end
#
# # Create implementations
# Implementation.destroy_all
# [
#   "Buildings/Facilities to Beneficiary",
#   "Campaign to Beneficiary",
#   "Finance to Beneficiary",
#   "Membership to Beneficiary",
#   "Product to Beneficiary",
#   "Research to Beneficiary",
#   "Service to Beneficiary",
#   "Software to Beneficiary",
#   "Other"
# ].each do |state|
#   Implementation.create(label:state)
# end
#

# Create countries
Country.destroy_all

Country.create(:name => 'United Kingdom', :iso3 => 'GBR', :iso2 => 'GB', :numcode => 826)
Country.create(:name => 'Ethiopia', :iso3 => 'ETH', :iso2 => 'ET', :numcode => 231)
Country.create(:name => 'Kenya', :iso3 => 'KEN', :iso2 => 'KE', :numcode => 404)
Country.create(:name => 'Uganda', :iso3 => 'UGA', :iso2 => 'UG', :numcode => 800)
Country.create(:name => 'Other', :iso3 => 'N/A', :iso2 => 'NA', :numcode => 000)

# # Create districts
# District.destroy_all
#
# District.create(country_id: 5, label: 'Other', district: 'Other', iso: 'Other')
#
# District.create(country_id: 1, label: 'United Kingdom - Buckinghamshire', district: 'Buckinghamshire', iso: 'GB-BKM')
# District.create(country_id: 1, label: 'United Kingdom - Cambridgeshire', district: 'Cambridgeshire', iso: 'GB-CAM')
# District.create(country_id: 1, label: 'United Kingdom - Cumbria', district: 'Cumbria', iso: 'GB-CMA')
# District.create(country_id: 1, label: 'United Kingdom - Derbyshire', district: 'Derbyshire', iso: 'GB-DBY')
# District.create(country_id: 1, label: 'United Kingdom - Devon', district: 'Devon', iso: 'GB-DEV')
# District.create(country_id: 1, label: 'United Kingdom - Dorset', district: 'Dorset', iso: 'GB-DOR')
# District.create(country_id: 1, label: 'United Kingdom - East Sussex', district: 'East Sussex', iso: 'GB-ESX')
# District.create(country_id: 1, label: 'United Kingdom - Essex', district: 'Essex', iso: 'GB-ESS')
# District.create(country_id: 1, label: 'United Kingdom - Gloucestershire', district: 'Gloucestershire', iso: 'GB-GLS')
# District.create(country_id: 1, label: 'United Kingdom - Hampshire', district: 'Hampshire', iso: 'GB-HAM')
# District.create(country_id: 1, label: 'United Kingdom - Hertfordshire', district: 'Hertfordshire', iso: 'GB-HRT')
# District.create(country_id: 1, label: 'United Kingdom - Kent', district: 'Kent', iso: 'GB-KEN')
# District.create(country_id: 1, label: 'United Kingdom - Lancashire', district: 'Lancashire', iso: 'GB-LAN')
# District.create(country_id: 1, label: 'United Kingdom - Leicestershire', district: 'Leicestershire', iso: 'GB-LEC')
# District.create(country_id: 1, label: 'United Kingdom - Lincolnshire', district: 'Lincolnshire', iso: 'GB-LIN')
# District.create(country_id: 1, label: 'United Kingdom - Norfolk', district: 'Norfolk', iso: 'GB-NFK')
# District.create(country_id: 1, label: 'United Kingdom - North Yorkshire', district: 'North Yorkshire', iso: 'GB-NYK')
# District.create(country_id: 1, label: 'United Kingdom - Northamptonshire', district: 'Northamptonshire', iso: 'GB-NTH')
# District.create(country_id: 1, label: 'United Kingdom - Nottinghamshire', district: 'Nottinghamshire', iso: 'GB-NTT')
# District.create(country_id: 1, label: 'United Kingdom - Oxfordshire', district: 'Oxfordshire', iso: 'GB-OXF')
# District.create(country_id: 1, label: 'United Kingdom - Somerset', district: 'Somerset', iso: 'GB-SOM')
# District.create(country_id: 1, label: 'United Kingdom - Staffordshire', district: 'Staffordshire', iso: 'GB-STS')
# District.create(country_id: 1, label: 'United Kingdom - Suffolk', district: 'Suffolk', iso: 'GB-SFK')
# District.create(country_id: 1, label: 'United Kingdom - Surrey', district: 'Surrey', iso: 'GB-SRY')
# District.create(country_id: 1, label: 'United Kingdom - Warwickshire', district: 'Warwickshire', iso: 'GB-WAR')
# District.create(country_id: 1, label: 'United Kingdom - West Sussex', district: 'West Sussex', iso: 'GB-WSX')
# District.create(country_id: 1, label: 'United Kingdom - Worcestershire', district: 'Worcestershire', iso: 'GB-WOR')
# District.create(country_id: 1, label: 'United Kingdom - London, City of', district: 'London, City of', iso: 'GB-LND')
# District.create(country_id: 1, label: 'United Kingdom - Barking and Dagenham', district: 'Barking and Dagenham', iso: 'GB-BDG')
# District.create(country_id: 1, label: 'United Kingdom - Barnet', district: 'Barnet', iso: 'GB-BNE')
# District.create(country_id: 1, label: 'United Kingdom - Bexley', district: 'Bexley', iso: 'GB-BEX')
# District.create(country_id: 1, label: 'United Kingdom - Brent', district: 'Brent', iso: 'GB-BEN')
# District.create(country_id: 1, label: 'United Kingdom - Bromley', district: 'Bromley', iso: 'GB-BRY')
# District.create(country_id: 1, label: 'United Kingdom - Camden', district: 'Camden', iso: 'GB-CMD')
# District.create(country_id: 1, label: 'United Kingdom - Croydon', district: 'Croydon', iso: 'GB-CRY')
# District.create(country_id: 1, label: 'United Kingdom - Ealing', district: 'Ealing', iso: 'GB-EAL')
# District.create(country_id: 1, label: 'United Kingdom - Enfield', district: 'Enfield', iso: 'GB-ENF')
# District.create(country_id: 1, label: 'United Kingdom - Greenwich', district: 'Greenwich', iso: 'GB-GRE')
# District.create(country_id: 1, label: 'United Kingdom - Hackney', district: 'Hackney', iso: 'GB-HCK')
# District.create(country_id: 1, label: 'United Kingdom - Hammersmith and Fulham', district: 'Hammersmith and Fulham', iso: 'GB-HMF')
# District.create(country_id: 1, label: 'United Kingdom - Haringey', district: 'Haringey', iso: 'GB-HRY')
# District.create(country_id: 1, label: 'United Kingdom - Harrow', district: 'Harrow', iso: 'GB-HRW')
# District.create(country_id: 1, label: 'United Kingdom - Havering', district: 'Havering', iso: 'GB-HAV')
# District.create(country_id: 1, label: 'United Kingdom - Hillingdon', district: 'Hillingdon', iso: 'GB-HIL')
# District.create(country_id: 1, label: 'United Kingdom - Hounslow', district: 'Hounslow', iso: 'GB-HNS')
# District.create(country_id: 1, label: 'United Kingdom - Islington', district: 'Islington', iso: 'GB-ISL')
# District.create(country_id: 1, label: 'United Kingdom - Kensington and Chelsea', district: 'Kensington and Chelsea', iso: 'GB-KEC')
# District.create(country_id: 1, label: 'United Kingdom - Kingston upon Thames', district: 'Kingston upon Thames', iso: 'GB-KTT')
# District.create(country_id: 1, label: 'United Kingdom - Lambeth', district: 'Lambeth', iso: 'GB-LBH')
# District.create(country_id: 1, label: 'United Kingdom - Lewisham', district: 'Lewisham', iso: 'GB-LEW')
# District.create(country_id: 1, label: 'United Kingdom - Merton', district: 'Merton', iso: 'GB-MRT')
# District.create(country_id: 1, label: 'United Kingdom - Newham', district: 'Newham', iso: 'GB-NWM')
# District.create(country_id: 1, label: 'United Kingdom - Redbridge', district: 'Redbridge', iso: 'GB-RDB')
# District.create(country_id: 1, label: 'United Kingdom - Richmond upon Thames', district: 'Richmond upon Thames', iso: 'GB-RIC')
# District.create(country_id: 1, label: 'United Kingdom - Southwark', district: 'Southwark', iso: 'GB-SWK')
# District.create(country_id: 1, label: 'United Kingdom - Sutton', district: 'Sutton', iso: 'GB-STN')
# District.create(country_id: 1, label: 'United Kingdom - Tower Hamlets', district: 'Tower Hamlets', iso: 'GB-TWH')
# District.create(country_id: 1, label: 'United Kingdom - Waltham Forest', district: 'Waltham Forest', iso: 'GB-WFT')
# District.create(country_id: 1, label: 'United Kingdom - Wandsworth', district: 'Wandsworth', iso: 'GB-WND')
# District.create(country_id: 1, label: 'United Kingdom - Westminster', district: 'Westminster', iso: 'GB-WSM')
# District.create(country_id: 1, label: 'United Kingdom - Barnsley', district: 'Barnsley', iso: 'GB-BNS')
# District.create(country_id: 1, label: 'United Kingdom - Birmingham', district: 'Birmingham', iso: 'GB-BIR')
# District.create(country_id: 1, label: 'United Kingdom - Bolton', district: 'Bolton', iso: 'GB-BOL')
# District.create(country_id: 1, label: 'United Kingdom - Bradford', district: 'Bradford', iso: 'GB-BRD')
# District.create(country_id: 1, label: 'United Kingdom - Bury', district: 'Bury', iso: 'GB-BUR')
# District.create(country_id: 1, label: 'United Kingdom - Calderdale', district: 'Calderdale', iso: 'GB-CLD')
# District.create(country_id: 1, label: 'United Kingdom - Coventry', district: 'Coventry', iso: 'GB-COV')
# District.create(country_id: 1, label: 'United Kingdom - Doncaster', district: 'Doncaster', iso: 'GB-DNC')
# District.create(country_id: 1, label: 'United Kingdom - Dudley', district: 'Dudley', iso: 'GB-DUD')
# District.create(country_id: 1, label: 'United Kingdom - Gateshead', district: 'Gateshead', iso: 'GB-GAT')
# District.create(country_id: 1, label: 'United Kingdom - Kirklees', district: 'Kirklees', iso: 'GB-KIR')
# District.create(country_id: 1, label: 'United Kingdom - Knowsley', district: 'Knowsley', iso: 'GB-KWL')
# District.create(country_id: 1, label: 'United Kingdom - Leeds', district: 'Leeds', iso: 'GB-LDS')
# District.create(country_id: 1, label: 'United Kingdom - Liverpool', district: 'Liverpool', iso: 'GB-LIV')
# District.create(country_id: 1, label: 'United Kingdom - Manchester', district: 'Manchester', iso: 'GB-MAN')
# District.create(country_id: 1, label: 'United Kingdom - Newcastle upon Tyne', district: 'Newcastle upon Tyne', iso: 'GB-NET')
# District.create(country_id: 1, label: 'United Kingdom - North Tyneside', district: 'North Tyneside', iso: 'GB-NTY')
# District.create(country_id: 1, label: 'United Kingdom - Oldham', district: 'Oldham', iso: 'GB-OLD')
# District.create(country_id: 1, label: 'United Kingdom - Rochdale', district: 'Rochdale', iso: 'GB-RCH')
# District.create(country_id: 1, label: 'United Kingdom - Rotherham', district: 'Rotherham', iso: 'GB-ROT')
# District.create(country_id: 1, label: 'United Kingdom - St. Helens', district: 'St. Helens', iso: 'GB-SHN')
# District.create(country_id: 1, label: 'United Kingdom - Salford', district: 'Salford', iso: 'GB-SLF')
# District.create(country_id: 1, label: 'United Kingdom - Sandwell', district: 'Sandwell', iso: 'GB-SAW')
# District.create(country_id: 1, label: 'United Kingdom - Sefton', district: 'Sefton', iso: 'GB-SFT')
# District.create(country_id: 1, label: 'United Kingdom - Sheffield', district: 'Sheffield', iso: 'GB-SHF')
# District.create(country_id: 1, label: 'United Kingdom - Solihull', district: 'Solihull', iso: 'GB-SOL')
# District.create(country_id: 1, label: 'United Kingdom - South Tyneside', district: 'South Tyneside', iso: 'GB-STY')
# District.create(country_id: 1, label: 'United Kingdom - Stockport', district: 'Stockport', iso: 'GB-SKP')
# District.create(country_id: 1, label: 'United Kingdom - Sunderland', district: 'Sunderland', iso: 'GB-SND')
# District.create(country_id: 1, label: 'United Kingdom - Tameside', district: 'Tameside', iso: 'GB-TAM')
# District.create(country_id: 1, label: 'United Kingdom - Trafford', district: 'Trafford', iso: 'GB-TRF')
# District.create(country_id: 1, label: 'United Kingdom - Wakefield', district: 'Wakefield', iso: 'GB-WKF')
# District.create(country_id: 1, label: 'United Kingdom - Walsall', district: 'Walsall', iso: 'GB-WLL')
# District.create(country_id: 1, label: 'United Kingdom - Wigan', district: 'Wigan', iso: 'GB-WGN')
# District.create(country_id: 1, label: 'United Kingdom - Wirral', district: 'Wirral', iso: 'GB-WRL')
# District.create(country_id: 1, label: 'United Kingdom - Wolverhampton', district: 'Wolverhampton', iso: 'GB-WLV')
# District.create(country_id: 1, label: 'United Kingdom - Bath and North East Somerset', district: 'Bath and North East Somerset', iso: 'GB-BAS')
# District.create(country_id: 1, label: 'United Kingdom - Bedford', district: 'Bedford', iso: 'GB-BDF')
# District.create(country_id: 1, label: 'United Kingdom - Blackburn with Darwen', district: 'Blackburn with Darwen', iso: 'GB-BBD')
# District.create(country_id: 1, label: 'United Kingdom - Blackpool', district: 'Blackpool', iso: 'GB-BPL')
# District.create(country_id: 1, label: 'United Kingdom - Bournemouth', district: 'Bournemouth', iso: 'GB-BMH')
# District.create(country_id: 1, label: 'United Kingdom - Bracknell Forest', district: 'Bracknell Forest', iso: 'GB-BRC')
# District.create(country_id: 1, label: 'United Kingdom - Brighton and Hove', district: 'Brighton and Hove', iso: 'GB-BNH')
# District.create(country_id: 1, label: 'United Kingdom - Bristol, City of', district: 'Bristol, City of', iso: 'GB-BST')
# District.create(country_id: 1, label: 'United Kingdom - Central Bedfordshire', district: 'Central Bedfordshire', iso: 'GB-CBF')
# District.create(country_id: 1, label: 'United Kingdom - Cheshire East', district: 'Cheshire East', iso: 'GB-CHE')
# District.create(country_id: 1, label: 'United Kingdom - Cheshire West and Chester', district: 'Cheshire West and Chester', iso: 'GB-CHW')
# District.create(country_id: 1, label: 'United Kingdom - Cornwall', district: 'Cornwall', iso: 'GB-CON')
# District.create(country_id: 1, label: 'United Kingdom - Darlington', district: 'Darlington', iso: 'GB-DAL')
# District.create(country_id: 1, label: 'United Kingdom - Derby', district: 'Derby', iso: 'GB-DER')
# District.create(country_id: 1, label: 'United Kingdom - Durham, County', district: 'Durham, County', iso: 'GB-DUR')
# District.create(country_id: 1, label: 'United Kingdom - East Riding of Yorkshire', district: 'East Riding of Yorkshire', iso: 'GB-ERY')
# District.create(country_id: 1, label: 'United Kingdom - Halton', district: 'Halton', iso: 'GB-HAL')
# District.create(country_id: 1, label: 'United Kingdom - Hartlepool', district: 'Hartlepool', iso: 'GB-HPL')
# District.create(country_id: 1, label: 'United Kingdom - Herefordshire', district: 'Herefordshire', iso: 'GB-HEF')
# District.create(country_id: 1, label: 'United Kingdom - Isle of Wight', district: 'Isle of Wight', iso: 'GB-IOW')
# District.create(country_id: 1, label: 'United Kingdom - Isles of Scilly', district: 'Isles of Scilly', iso: 'GB-IOS')
# District.create(country_id: 1, label: 'United Kingdom - Kingston upon Hull', district: 'Kingston upon Hull', iso: 'GB-KHL')
# District.create(country_id: 1, label: 'United Kingdom - Leicester', district: 'Leicester', iso: 'GB-LCE')
# District.create(country_id: 1, label: 'United Kingdom - Luton', district: 'Luton', iso: 'GB-LUT')
# District.create(country_id: 1, label: 'United Kingdom - Medway', district: 'Medway', iso: 'GB-MDW')
# District.create(country_id: 1, label: 'United Kingdom - Middlesbrough', district: 'Middlesbrough', iso: 'GB-MDB')
# District.create(country_id: 1, label: 'United Kingdom - Milton Keynes', district: 'Milton Keynes', iso: 'GB-MIK')
# District.create(country_id: 1, label: 'United Kingdom - North East Lincolnshire', district: 'North East Lincolnshire', iso: 'GB-NEL')
# District.create(country_id: 1, label: 'United Kingdom - North Lincolnshire', district: 'North Lincolnshire', iso: 'GB-NLN')
# District.create(country_id: 1, label: 'United Kingdom - North Somerset', district: 'North Somerset', iso: 'GB-NSM')
# District.create(country_id: 1, label: 'United Kingdom - Northumberland', district: 'Northumberland', iso: 'GB-NBL')
# District.create(country_id: 1, label: 'United Kingdom - Nottingham', district: 'Nottingham', iso: 'GB-NGM')
# District.create(country_id: 1, label: 'United Kingdom - Peterborough', district: 'Peterborough', iso: 'GB-PTE')
# District.create(country_id: 1, label: 'United Kingdom - Plymouth', district: 'Plymouth', iso: 'GB-PLY')
# District.create(country_id: 1, label: 'United Kingdom - Poole', district: 'Poole', iso: 'GB-POL')
# District.create(country_id: 1, label: 'United Kingdom - Portsmouth', district: 'Portsmouth', iso: 'GB-POR')
# District.create(country_id: 1, label: 'United Kingdom - Reading', district: 'Reading', iso: 'GB-RDG')
# District.create(country_id: 1, label: 'United Kingdom - Redcar and Cleveland', district: 'Redcar and Cleveland', iso: 'GB-RCC')
# District.create(country_id: 1, label: 'United Kingdom - Rutland', district: 'Rutland', iso: 'GB-RUT')
# District.create(country_id: 1, label: 'United Kingdom - Shropshire', district: 'Shropshire', iso: 'GB-SHR')
# District.create(country_id: 1, label: 'United Kingdom - Slough', district: 'Slough', iso: 'GB-SLG')
# District.create(country_id: 1, label: 'United Kingdom - South Gloucestershire', district: 'South Gloucestershire', iso: 'GB-SGC')
# District.create(country_id: 1, label: 'United Kingdom - Southampton', district: 'Southampton', iso: 'GB-STH')
# District.create(country_id: 1, label: 'United Kingdom - Southend-on-Sea', district: 'Southend-on-Sea', iso: 'GB-SOS')
# District.create(country_id: 1, label: 'United Kingdom - Stockton-on-Tees', district: 'Stockton-on-Tees', iso: 'GB-STT')
# District.create(country_id: 1, label: 'United Kingdom - Stoke-on-Trent', district: 'Stoke-on-Trent', iso: 'GB-STE')
# District.create(country_id: 1, label: 'United Kingdom - Swindon', district: 'Swindon', iso: 'GB-SWD')
# District.create(country_id: 1, label: 'United Kingdom - Telford and Wrekin', district: 'Telford and Wrekin', iso: 'GB-TFW')
# District.create(country_id: 1, label: 'United Kingdom - Thurrock', district: 'Thurrock', iso: 'GB-THR')
# District.create(country_id: 1, label: 'United Kingdom - Torbay', district: 'Torbay', iso: 'GB-TOB')
# District.create(country_id: 1, label: 'United Kingdom - Warrington', district: 'Warrington', iso: 'GB-WRT')
# District.create(country_id: 1, label: 'United Kingdom - West Berkshire', district: 'West Berkshire', iso: 'GB-WBK')
# District.create(country_id: 1, label: 'United Kingdom - Wiltshire', district: 'Wiltshire', iso: 'GB-WIL')
# District.create(country_id: 1, label: 'United Kingdom - Windsor and Maidenhead', district: 'Windsor and Maidenhead', iso: 'GB-WNM')
# District.create(country_id: 1, label: 'United Kingdom - Wokingham', district: 'Wokingham', iso: 'GB-WOK')
# District.create(country_id: 1, label: 'United Kingdom - York', district: 'York', iso: 'GB-YOR')
# District.create(country_id: 1, label: 'United Kingdom - Antrim', district: 'Antrim', iso: 'GB-ANT')
# District.create(country_id: 1, label: 'United Kingdom - Ards', district: 'Ards', iso: 'GB-ARD')
# District.create(country_id: 1, label: 'United Kingdom - Armagh', district: 'Armagh', iso: 'GB-ARM')
# District.create(country_id: 1, label: 'United Kingdom - Ballymena', district: 'Ballymena', iso: 'GB-BLA')
# District.create(country_id: 1, label: 'United Kingdom - Ballymoney', district: 'Ballymoney', iso: 'GB-BLY')
# District.create(country_id: 1, label: 'United Kingdom - Banbridge', district: 'Banbridge', iso: 'GB-BNB')
# District.create(country_id: 1, label: 'United Kingdom - Belfast', district: 'Belfast', iso: 'GB-BFS')
# District.create(country_id: 1, label: 'United Kingdom - Carrickfergus', district: 'Carrickfergus', iso: 'GB-CKF')
# District.create(country_id: 1, label: 'United Kingdom - Castlereagh', district: 'Castlereagh', iso: 'GB-CSR')
# District.create(country_id: 1, label: 'United Kingdom - Coleraine', district: 'Coleraine', iso: 'GB-CLR')
# District.create(country_id: 1, label: 'United Kingdom - Cookstown', district: 'Cookstown', iso: 'GB-CKT')
# District.create(country_id: 1, label: 'United Kingdom - Craigavon', district: 'Craigavon', iso: 'GB-CGV')
# District.create(country_id: 1, label: 'United Kingdom - Derry', district: 'Derry', iso: 'GB-DRY')
# District.create(country_id: 1, label: 'United Kingdom - Down', district: 'Down', iso: 'GB-DOW')
# District.create(country_id: 1, label: 'United Kingdom - Dungannon and South Tyrone', district: 'Dungannon and South Tyrone', iso: 'GB-DGN')
# District.create(country_id: 1, label: 'United Kingdom - Fermanagh', district: 'Fermanagh', iso: 'GB-FER')
# District.create(country_id: 1, label: 'United Kingdom - Larne', district: 'Larne', iso: 'GB-LRN')
# District.create(country_id: 1, label: 'United Kingdom - Limavady', district: 'Limavady', iso: 'GB-LMV')
# District.create(country_id: 1, label: 'United Kingdom - Lisburn', district: 'Lisburn', iso: 'GB-LSB')
# District.create(country_id: 1, label: 'United Kingdom - Magherafelt', district: 'Magherafelt', iso: 'GB-MFT')
# District.create(country_id: 1, label: 'United Kingdom - Moyle', district: 'Moyle', iso: 'GB-MYL')
# District.create(country_id: 1, label: 'United Kingdom - Newry and Mourne District', district: 'Newry and Mourne District', iso: 'GB-NYM')
# District.create(country_id: 1, label: 'United Kingdom - Newtownabbey', district: 'Newtownabbey', iso: 'GB-NTA')
# District.create(country_id: 1, label: 'United Kingdom - North Down', district: 'North Down', iso: 'GB-NDN')
# District.create(country_id: 1, label: 'United Kingdom - Omagh', district: 'Omagh', iso: 'GB-OMH')
# District.create(country_id: 1, label: 'United Kingdom - Strabane', district: 'Strabane', iso: 'GB-STB')
# District.create(country_id: 1, label: 'United Kingdom - Aberdeen City', district: 'Aberdeen City', iso: 'GB-ABE')
# District.create(country_id: 1, label: 'United Kingdom - Aberdeenshire', district: 'Aberdeenshire', iso: 'GB-ABD')
# District.create(country_id: 1, label: 'United Kingdom - Angus', district: 'Angus', iso: 'GB-ANS')
# District.create(country_id: 1, label: 'United Kingdom - Argyll and Bute', district: 'Argyll and Bute', iso: 'GB-AGB')
# District.create(country_id: 1, label: 'United Kingdom - Clackmannanshire', district: 'Clackmannanshire', iso: 'GB-CLK')
# District.create(country_id: 1, label: 'United Kingdom - Dumfries and Galloway', district: 'Dumfries and Galloway', iso: 'GB-DGY')
# District.create(country_id: 1, label: 'United Kingdom - Dundee City', district: 'Dundee City', iso: 'GB-DND')
# District.create(country_id: 1, label: 'United Kingdom - East Ayrshire', district: 'East Ayrshire', iso: 'GB-EAY')
# District.create(country_id: 1, label: 'United Kingdom - East Dunbartonshire', district: 'East Dunbartonshire', iso: 'GB-EDU')
# District.create(country_id: 1, label: 'United Kingdom - East Lothian', district: 'East Lothian', iso: 'GB-ELN')
# District.create(country_id: 1, label: 'United Kingdom - East Renfrewshire', district: 'East Renfrewshire', iso: 'GB-ERW')
# District.create(country_id: 1, label: 'United Kingdom - Edinburgh, City of', district: 'Edinburgh, City of', iso: 'GB-EDH')
# District.create(country_id: 1, label: 'United Kingdom - Eilean Siar', district: 'Eilean Siar', iso: 'GB-ELS')
# District.create(country_id: 1, label: 'United Kingdom - Falkirk', district: 'Falkirk', iso: 'GB-FAL')
# District.create(country_id: 1, label: 'United Kingdom - Fife', district: 'Fife', iso: 'GB-FIF')
# District.create(country_id: 1, label: 'United Kingdom - Glasgow City', district: 'Glasgow City', iso: 'GB-GLG')
# District.create(country_id: 1, label: 'United Kingdom - Highland', district: 'Highland', iso: 'GB-HLD')
# District.create(country_id: 1, label: 'United Kingdom - Inverclyde', district: 'Inverclyde', iso: 'GB-IVC')
# District.create(country_id: 1, label: 'United Kingdom - Midlothian', district: 'Midlothian', iso: 'GB-MLN')
# District.create(country_id: 1, label: 'United Kingdom - Moray', district: 'Moray', iso: 'GB-MRY')
# District.create(country_id: 1, label: 'United Kingdom - North Ayrshire', district: 'North Ayrshire', iso: 'GB-NAY')
# District.create(country_id: 1, label: 'United Kingdom - North Lanarkshire', district: 'North Lanarkshire', iso: 'GB-NLK')
# District.create(country_id: 1, label: 'United Kingdom - Orkney Islands', district: 'Orkney Islands', iso: 'GB-ORK')
# District.create(country_id: 1, label: 'United Kingdom - Perth and Kinross', district: 'Perth and Kinross', iso: 'GB-PKN')
# District.create(country_id: 1, label: 'United Kingdom - Renfrewshire', district: 'Renfrewshire', iso: 'GB-RFW')
# District.create(country_id: 1, label: 'United Kingdom - Scottish Borders, The', district: 'Scottish Borders, The', iso: 'GB-SCB')
# District.create(country_id: 1, label: 'United Kingdom - Shetland Islands', district: 'Shetland Islands', iso: 'GB-ZET')
# District.create(country_id: 1, label: 'United Kingdom - South Ayrshire', district: 'South Ayrshire', iso: 'GB-SAY')
# District.create(country_id: 1, label: 'United Kingdom - South Lanarkshire', district: 'South Lanarkshire', iso: 'GB-SLK')
# District.create(country_id: 1, label: 'United Kingdom - Stirling', district: 'Stirling', iso: 'GB-STG')
# District.create(country_id: 1, label: 'United Kingdom - West Dunbartonshire', district: 'West Dunbartonshire', iso: 'GB-WDU')
# District.create(country_id: 1, label: 'United Kingdom - West Lothian', district: 'West Lothian', iso: 'GB-WLN')
# District.create(country_id: 1, label: 'United Kingdom - Blaenau Gwent', district: 'Blaenau Gwent', iso: 'GB-BGW')
# District.create(country_id: 1, label: 'United Kingdom - Bridgend', district: 'Bridgend', iso: 'GB-BGE')
# District.create(country_id: 1, label: 'United Kingdom - Caerphilly', district: 'Caerphilly', iso: 'GB-CAY')
# District.create(country_id: 1, label: 'United Kingdom - Cardiff', district: 'Cardiff', iso: 'GB-CRF')
# District.create(country_id: 1, label: 'United Kingdom - Carmarthenshire', district: 'Carmarthenshire', iso: 'GB-CMN')
# District.create(country_id: 1, label: 'United Kingdom - Ceredigion', district: 'Ceredigion', iso: 'GB-CGN')
# District.create(country_id: 1, label: 'United Kingdom - Conwy', district: 'Conwy', iso: 'GB-CWY')
# District.create(country_id: 1, label: 'United Kingdom - Denbighshire', district: 'Denbighshire', iso: 'GB-DEN')
# District.create(country_id: 1, label: 'United Kingdom - Flintshire', district: 'Flintshire', iso: 'GB-FLN')
# District.create(country_id: 1, label: 'United Kingdom - Gwynedd', district: 'Gwynedd', iso: 'GB-GWN')
# District.create(country_id: 1, label: 'United Kingdom - Isle of Anglesey', district: 'Isle of Anglesey', iso: 'GB-AGY')
# District.create(country_id: 1, label: 'United Kingdom - Merthyr Tydfil', district: 'Merthyr Tydfil', iso: 'GB-MTY')
# District.create(country_id: 1, label: 'United Kingdom - Monmouthshire', district: 'Monmouthshire', iso: 'GB-MON')
# District.create(country_id: 1, label: 'United Kingdom - Neath Port Talbot', district: 'Neath Port Talbot', iso: 'GB-NTL')
# District.create(country_id: 1, label: 'United Kingdom - Newport', district: 'Newport', iso: 'GB-NWP')
# District.create(country_id: 1, label: 'United Kingdom - Pembrokeshire', district: 'Pembrokeshire', iso: 'GB-PEM')
# District.create(country_id: 1, label: 'United Kingdom - Powys', district: 'Powys', iso: 'GB-POW')
# District.create(country_id: 1, label: 'United Kingdom - Rhondda, Cynon, Taff', district: 'Rhondda, Cynon, Taff', iso: 'GB-RCT')
# District.create(country_id: 1, label: 'United Kingdom - Swansea', district: 'Swansea', iso: 'GB-SWA')
# District.create(country_id: 1, label: 'United Kingdom - Torfaen', district: 'Torfaen', iso: 'GB-TOF')
# District.create(country_id: 1, label: 'United Kingdom - Vale of Glamorgan, The', district: 'Vale of Glamorgan, The', iso: 'GB-VGL')
# District.create(country_id: 1, label: 'United Kingdom - Wrexham', district: 'Wrexham', iso: 'GB-WRX')
#
# District.create(country_id: 2, label: 'Ethiopia - Addis Ababa', district: 'Addis Ababa', iso: 'ET-AA')
# District.create(country_id: 2, label: 'Ethiopia - Dire Dawa', district: 'Dire Dawa', iso: 'ET-DD')
# District.create(country_id: 2, label: 'Ethiopia - Afar', district: 'Afar', iso: 'ET-AF')
# District.create(country_id: 2, label: 'Ethiopia - Amara', district: 'Amara', iso: 'ET-AM')
# District.create(country_id: 2, label: 'Ethiopia - Benshangul-Gumaz', district: 'Benshangul-Gumaz', iso: 'ET-BE')
# District.create(country_id: 2, label: 'Ethiopia - Gambela Peoples', district: 'Gambela Peoples', iso: 'ET-GA')
# District.create(country_id: 2, label: 'Ethiopia - Harari People', district: 'Harari People', iso: 'ET-HA')
# District.create(country_id: 2, label: 'Ethiopia - Oromia', district: 'Oromia', iso: 'ET-OR')
# District.create(country_id: 2, label: 'Ethiopia - Somali', district: 'Somali', iso: 'ET-SO')
# District.create(country_id: 2, label: 'Ethiopia - Tigrai', district: 'Tigrai', iso: 'ET-TI')
# District.create(country_id: 2, label: 'Ethiopia - Southern Nations, Nationalities and Peoples', district: 'Southern Nations, Nationalities and Peoples', iso: 'ET-SN')
#
# District.create(country_id: 3, label: "Kenya - Mombasa", district: "Mombasa", iso: 'KE-01')
# District.create(country_id: 3, label: "Kenya - Kwale", district: "Kwale", iso: 'KE-02')
# District.create(country_id: 3, label: "Kenya - Kilifi", district: "Kilifi", iso: 'KE-03')
# District.create(country_id: 3, label: "Kenya - Tana River", district: "Tana River", iso: 'KE-04')
# District.create(country_id: 3, label: "Kenya - Lamu", district: "Lamu", iso: 'KE-05')
# District.create(country_id: 3, label: "Kenya - Taita-Taveta", district: "Taita-Taveta", iso: 'KE-06')
# District.create(country_id: 3, label: "Kenya - Garissa", district: "Garissa", iso: 'KE-07')
# District.create(country_id: 3, label: "Kenya - Wajir", district: "Wajir", iso: 'KE-08')
# District.create(country_id: 3, label: "Kenya - Mandera", district: "Mandera", iso: 'KE-09')
# District.create(country_id: 3, label: "Kenya - Marsabit", district: "Marsabit", iso: 'KE-10')
# District.create(country_id: 3, label: "Kenya - Isiolo", district: "Isiolo", iso: 'KE-11')
# District.create(country_id: 3, label: "Kenya - Meru", district: "Meru", iso: 'KE-12')
# District.create(country_id: 3, label: "Kenya - Tharaka-Nithi", district: "Tharaka-Nithi", iso: 'KE-13')
# District.create(country_id: 3, label: "Kenya - Embu", district: "Embu", iso: 'KE-14')
# District.create(country_id: 3, label: "Kenya - Kitui", district: "Kitui", iso: 'KE-15')
# District.create(country_id: 3, label: "Kenya - Machakos", district: "Machakos", iso: 'KE-16')
# District.create(country_id: 3, label: "Kenya - Makueni", district: "Makueni", iso: 'KE-17')
# District.create(country_id: 3, label: "Kenya - Nyandarua", district: "Nyandarua", iso: 'KE-18')
# District.create(country_id: 3, label: "Kenya - Nyeri", district: "Nyeri", iso: 'KE-19')
# District.create(country_id: 3, label: "Kenya - Kirinyaga", district: "Kirinyaga", iso: 'KE-20')
# District.create(country_id: 3, label: "Kenya - Murang'a", district: "Murang'a", iso: 'KE-21')
# District.create(country_id: 3, label: "Kenya - Kiambu", district: "Kiambu", iso: 'KE-22')
# District.create(country_id: 3, label: "Kenya - Turkana", district: "Turkana", iso: 'KE-23')
# District.create(country_id: 3, label: "Kenya - Westpokot", district: "Westpokot", iso: 'KE-24')
# District.create(country_id: 3, label: "Kenya - Samburu", district: "Samburu", iso: 'KE-25')
# District.create(country_id: 3, label: "Kenya - Trans Nzoia", district: "Trans Nzoia", iso: 'KE-26')
# District.create(country_id: 3, label: "Kenya - Uasin Gishu", district: "Uasin Gishu", iso: 'KE-27')
# District.create(country_id: 3, label: "Kenya - Elgeyo-Marakwet", district: "Elgeyo-Marakwet", iso: 'KE-28')
# District.create(country_id: 3, label: "Kenya - Nandi", district: "Nandi", iso: 'KE-29')
# District.create(country_id: 3, label: "Kenya - Baringo", district: "Baringo", iso: 'KE-30')
# District.create(country_id: 3, label: "Kenya - Laikipia", district: "Laikipia", iso: 'KE-31')
# District.create(country_id: 3, label: "Kenya - Nakuru", district: "Nakuru", iso: 'KE-32')
# District.create(country_id: 3, label: "Kenya - Narok", district: "Narok", iso: 'KE-33')
# District.create(country_id: 3, label: "Kenya - Kajiado", district: "Kajiado", iso: 'KE-34')
# District.create(country_id: 3, label: "Kenya - Kericho", district: "Kericho", iso: 'KE-35')
# District.create(country_id: 3, label: "Kenya - Bomet", district: "Bomet", iso: 'KE-36')
# District.create(country_id: 3, label: "Kenya - Kakamega", district: "Kakamega", iso: 'KE-37')
# District.create(country_id: 3, label: "Kenya - Vihiga", district: "Vihiga", iso: 'KE-38')
# District.create(country_id: 3, label: "Kenya - Bungoma", district: "Bungoma", iso: 'KE-39')
# District.create(country_id: 3, label: "Kenya - Busia", district: "Busia", iso: 'KE-40')
# District.create(country_id: 3, label: "Kenya - Siaya", district: "Siaya", iso: 'KE-41')
# District.create(country_id: 3, label: "Kenya - Kisumu", district: "Kisumu", iso: 'KE-42')
# District.create(country_id: 3, label: "Kenya - Homabay", district: "Homabay", iso: 'KE-43')
# District.create(country_id: 3, label: "Kenya - Migori", district: "Migori", iso: 'KE-44')
# District.create(country_id: 3, label: "Kenya - Kisii", district: "Kisii", iso: 'KE-45')
# District.create(country_id: 3, label: "Kenya - Nyamira", district: "Nyamira", iso: 'KE-46')
# District.create(country_id: 3, label: "Kenya - Nairobi city", district: "Nairobi city", iso: 'KE-47')
#
# District.create(country_id: 4, label: 'Uganda - Abim', district:	'Abim', iso:	'UG-317')
# District.create(country_id: 4, label: 'Uganda - Adjumani', district:	'Adjumani', iso:	'UG-301')
# District.create(country_id: 4, label: 'Uganda - Amolatar', district:	'Amolatar', iso:	'UG-314')
# District.create(country_id: 4, label: 'Uganda - Amuria', district:	'Amuria', iso:	'UG-216')
# District.create(country_id: 4, label: 'Uganda - Amuru', district:	'Amuru', iso:	'UG-319')
# District.create(country_id: 4, label: 'Uganda - Apac', district:	'Apac', iso:	'UG-302')
# District.create(country_id: 4, label: 'Uganda - Arua', district:	'Arua', iso:	'UG-303')
# District.create(country_id: 4, label: 'Uganda - Budaka', district:	'Budaka', iso:	'UG-217')
# District.create(country_id: 4, label: 'Uganda - Bududa', district:	'Bududa', iso:	'UG-223')
# District.create(country_id: 4, label: 'Uganda - Bugiri', district:	'Bugiri', iso:	'UG-201')
# District.create(country_id: 4, label: 'Uganda - Bukedea', district:	'Bukedea', iso:	'UG-224')
# District.create(country_id: 4, label: 'Uganda - Bukwa', district:	'Bukwa', iso:	'UG-218')
# District.create(country_id: 4, label: 'Uganda - Buliisa', district:	'Buliisa', iso:	'UG-419')
# District.create(country_id: 4, label: 'Uganda - Bundibugyo', district:	'Bundibugyo', iso:	'UG-401')
# District.create(country_id: 4, label: 'Uganda - Bushenyi', district:	'Bushenyi', iso:	'UG-402')
# District.create(country_id: 4, label: 'Uganda - Busia', district:	'Busia', iso:	'UG-202')
# District.create(country_id: 4, label: 'Uganda - Butaleja', district:	'Butaleja', iso:	'UG-219')
# District.create(country_id: 4, label: 'Uganda - Dokolo', district:	'Dokolo', iso:	'UG-318')
# District.create(country_id: 4, label: 'Uganda - Gulu', district:	'Gulu', iso:	'UG-304')
# District.create(country_id: 4, label: 'Uganda - Hoima', district:	'Hoima', iso:	'UG-403')
# District.create(country_id: 4, label: 'Uganda - Ibanda', district:	'Ibanda', iso:	'UG-416')
# District.create(country_id: 4, label: 'Uganda - Iganga', district:	'Iganga', iso:	'UG-203')
# District.create(country_id: 4, label: 'Uganda - Isingiro', district:	'Isingiro', iso:	'UG-417')
# District.create(country_id: 4, label: 'Uganda - Jinja', district:	'Jinja', iso:	'UG-204')
# District.create(country_id: 4, label: 'Uganda - Kaabong', district:	'Kaabong', iso:	'UG-315')
# District.create(country_id: 4, label: 'Uganda - Kabale', district:	'Kabale', iso:	'UG-404')
# District.create(country_id: 4, label: 'Uganda - Kabarole', district:	'Kabarole', iso:	'UG-405')
# District.create(country_id: 4, label: 'Uganda - Kaberamaido', district:	'Kaberamaido', iso:	'UG-213')
# District.create(country_id: 4, label: 'Uganda - Kalangala', district:	'Kalangala', iso:	'UG-101')
# District.create(country_id: 4, label: 'Uganda - Kaliro', district:	'Kaliro', iso:	'UG-220')
# District.create(country_id: 4, label: 'Uganda - Kampala', district:	'Kampala', iso:	'UG-102')
# District.create(country_id: 4, label: 'Uganda - Kamuli', district:	'Kamuli', iso:	'UG-205')
# District.create(country_id: 4, label: 'Uganda - Kamwenge', district:	'Kamwenge', iso:	'UG-413')
# District.create(country_id: 4, label: 'Uganda - Kanungu', district:	'Kanungu', iso:	'UG-414')
# District.create(country_id: 4, label: 'Uganda - Kapchorwa', district:	'Kapchorwa', iso:	'UG-206')
# District.create(country_id: 4, label: 'Uganda - Kasese', district:	'Kasese', iso:	'UG-406')
# District.create(country_id: 4, label: 'Uganda - Katakwi', district:	'Katakwi', iso:	'UG-207')
# District.create(country_id: 4, label: 'Uganda - Kayunga', district:	'Kayunga', iso:	'UG-112')
# District.create(country_id: 4, label: 'Uganda - Kibaale', district:	'Kibaale', iso:	'UG-407')
# District.create(country_id: 4, label: 'Uganda - Kiboga', district:	'Kiboga', iso:	'UG-103')
# District.create(country_id: 4, label: 'Uganda - Kiruhura', district:	'Kiruhura', iso:	'UG-418')
# District.create(country_id: 4, label: 'Uganda - Kisoro', district:	'Kisoro', iso:	'UG-408')
# District.create(country_id: 4, label: 'Uganda - Kitgum', district:	'Kitgum', iso:	'UG-305')
# District.create(country_id: 4, label: 'Uganda - Koboko', district:	'Koboko', iso:	'UG-316')
# District.create(country_id: 4, label: 'Uganda - Kotido', district:	'Kotido', iso:	'UG-306')
# District.create(country_id: 4, label: 'Uganda - Kumi', district:	'Kumi', iso:	'UG-208')
# District.create(country_id: 4, label: 'Uganda - Kyenjojo', district:	'Kyenjojo', iso:	'UG-415')
# District.create(country_id: 4, label: 'Uganda - Lira', district:	'Lira', iso:	'UG-307')
# District.create(country_id: 4, label: 'Uganda - Luwero', district:	'Luwero', iso:	'UG-104')
# District.create(country_id: 4, label: 'Uganda - Lyantonde', district:	'Lyantonde', iso:	'UG-116')
# District.create(country_id: 4, label: 'Uganda - Manafwa', district:	'Manafwa', iso:	'UG-221')
# District.create(country_id: 4, label: 'Uganda - Maracha', district:	'Maracha', iso:	'UG-320')
# District.create(country_id: 4, label: 'Uganda - Masaka', district:	'Masaka', iso:	'UG-105')
# District.create(country_id: 4, label: 'Uganda - Masindi', district:	'Masindi', iso:	'UG-409')
# District.create(country_id: 4, label: 'Uganda - Mayuge', district:	'Mayuge', iso:	'UG-214')
# District.create(country_id: 4, label: 'Uganda - Mbale', district:	'Mbale', iso:	'UG-209')
# District.create(country_id: 4, label: 'Uganda - Mbarara', district:	'Mbarara', iso:	'UG-410')
# District.create(country_id: 4, label: 'Uganda - Mityana', district:	'Mityana', iso:	'UG-114')
# District.create(country_id: 4, label: 'Uganda - Moroto', district:	'Moroto', iso:	'UG-308')
# District.create(country_id: 4, label: 'Uganda - Moyo', district:	'Moyo', iso:	'UG-309')
# District.create(country_id: 4, label: 'Uganda - Mpigi', district:	'Mpigi', iso:	'UG-106')
# District.create(country_id: 4, label: 'Uganda - Mubende', district:	'Mubende', iso:	'UG-107')
# District.create(country_id: 4, label: 'Uganda - Mukono', district:	'Mukono', iso:	'UG-108')
# District.create(country_id: 4, label: 'Uganda - Nakapiripirit', district:	'Nakapiripirit', iso:	'UG-311')
# District.create(country_id: 4, label: 'Uganda - Nakaseke', district:	'Nakaseke', iso:	'UG-115')
# District.create(country_id: 4, label: 'Uganda - Nakasongola', district:	'Nakasongola', iso:	'UG-109')
# District.create(country_id: 4, label: 'Uganda - Namutumba', district:	'Namutumba', iso:	'UG-222')
# District.create(country_id: 4, label: 'Uganda - Nebbi', district:	'Nebbi', iso:	'UG-310')
# District.create(country_id: 4, label: 'Uganda - Ntungamo', district:	'Ntungamo', iso:	'UG-411')
# District.create(country_id: 4, label: 'Uganda - Oyam', district:	'Oyam', iso:	'UG-321')
# District.create(country_id: 4, label: 'Uganda - Pader', district:	'Pader', iso:	'UG-312')
# District.create(country_id: 4, label: 'Uganda - Pallisa', district:	'Pallisa', iso:	'UG-210')
# District.create(country_id: 4, label: 'Uganda - Rakai', district:	'Rakai', iso:	'UG-110')
# District.create(country_id: 4, label: 'Uganda - Rukungiri', district:	'Rukungiri', iso:	'UG-412')
# District.create(country_id: 4, label: 'Uganda - Sembabule', district:	'Sembabule', iso:	'UG-111')
# District.create(country_id: 4, label: 'Uganda - Sironko', district:	'Sironko', iso:	'UG-215')
# District.create(country_id: 4, label: 'Uganda - Soroti', district:	'Soroti', iso:	'UG-211')
# District.create(country_id: 4, label: 'Uganda - Tororo', district:	'Tororo', iso:	'UG-212')
# District.create(country_id: 4, label: 'Uganda - Wakiso', district:	'Wakiso', iso:	'UG-113')
# District.create(country_id: 4, label: 'Uganda - Yumbe', district:	'Yumbe', iso:	'UG-313')
