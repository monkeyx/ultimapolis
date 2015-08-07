# Initial Admin
admin = User.create!(email: 'admin@ultimapolis.com', password: 'password', password_confirmation: 'password', role: 'admin')

# Global

Global.create!(
	infrastructure: 50,
	grid: 50,
	power: 0,
	stability: 100,
	climate: 50,
	liberty: 100,
	security: 100,
	borders: 50,
	turn: 1,
	inflation: 2,
	citizens: 0,
	gdp: 0
)

# Professions

judge = Profession.create_new!("Judge","Agent", "Police officers, judges and executioners helping to maintain order")
spook = Profession.create_new!("Spook","Agent", "Monitoring the citizenry for potential rogue behaviour")
freelancer = Profession.create_new!("Freelancer","Agent", "Freelancing for the MegaCorporation performing the jobs they don't want to do inhouse")

home_guard = Profession.create_new!("Guard", "Military", "Infantry protecting the borders of the city")
engineer = Profession.create_new!("Engineer", "Military", "Engineer helping to keep the automated systems of the city functioning")
pilot = Profession.create_new!("Pilot", "Military", "Piloting the unmanned drones that protect the city and monitor the Wastelands beyond")

management = Profession.create_new!("Management", "Corporate", "Line and senior management within the MegaCorporation")
labourer = Profession.create_new!("Labourer", "Corporate", "Manual workers under the employ of the MegaCorporation")
suit = Profession.create_new!("Suit", "Corporate", "Human interface specialists within the MegaCorporation")

creative = Profession.create_new!("Creative", "Entertainer", "Writers, sculptors, holographers and other creative types")
blogger = Profession.create_new!("Blogger", "Entertainer", "Opinion makers and news reporters")
celeb = Profession.create_new!("Celeb", "Entertainer", "Dancers, musicians, actors and other attention seekers")

retailer = Profession.create_new!("Retailer", "Merchant", "Shop keepers in meatspace and cyberspace")
fixer = Profession.create_new!("Fixer", "Merchant", "Facilitators of the many special needs of the wealthy")

civic = Profession.create_new!("Civic", "Government", "Planners and administrators of the Ultimapolis government")
politico = Profession.create_new!("Politico", "Government", "The power hungry and populists who shape government policy")

hacker = Profession.create_new!("Hacker", "Rogue", "Crackers of security systems in cyberspace")
gangster = Profession.create_new!("Gangster", "Rogue", "The legion that belong to the underground gangs")

professor = Profession.create_new!("Professor", "Scientist", "Boffins who work in the Universal Foundation teaching and publishing thesis")
doctor = Profession.create_new!("Doctor", "Scientist", "Scientist that specialises in medicine")


# Skills

admin = Skill.create_new!("Admin", "Business", "Managing bureaucracies, planning, tracking inventories, manifests and other records", management, retailer, civic)
advocacy = Skill.create_new!("Advocacy", "Legal", "Knowledge of the legal code and practises, oratory, debate and public speaking", judge, management, politico)
veterinary = Skill.create_new!("Veterinary", "Animal", "Veterinary medicine and animal care", doctor, labourer, nil)
farming = Skill.create_new!("Farming", "Animal", "Grow and harvest crops and raise animals", labourer, nil, nil)
athletics = Skill.create_new!("Athletics", "Physique", "Physical fitness and sports", home_guard, celeb, gangster)
acting = Skill.create_new!("Acting", "Art", "Performance on stage and holovids", creative, celeb, nil)
dance = Skill.create_new!("Dance", "Art", "Performance specialising in movement to music", creative, celeb, nil)
holography = Skill.create_new!("Holography", "Art", "Recording and producing holovids", creative, blogger, nil)
instrument = Skill.create_new!("Music", "Art", "Singing and playing musical instruments", creative, celeb, nil)
sculpting = Skill.create_new!("Sculpting", "Art", "Artistic and abstract sculpture in different media", creative, nil, nil)
writing = Skill.create_new!("Writing", "Art", "Composing inspired or interesting prose", creative, blogger, nil)
broker = Skill.create_new!("Broker", "Business", "Negotiating trade deals", management, fixer, retailer)
carouse = Skill.create_new!("Carouse", "Social", "Socialising and having fun", celeb, politico, suit)
comms = Skill.create_new!("Comms", "Tech", "Telecommunications and signals processing", spook, blogger, nil)
computers = Skill.create_new!("Computers", "Tech", "Using and controlling computer systems", freelancer, hacker, suit)
deception = Skill.create_new!("Deception", "Social", "Lieing fluently, disguise and sleight of hand", spook, freelancer, politico)
diplomacy = Skill.create_new!("Diplomacy", "Social", "Establishing social contact and knowing how to behave in social situations", management, civic, politico)
driving = Skill.create_new!("Driving", "Tech", "Controlling ground vehicles of all kinds", labourer, suit, nil)
engineering = Skill.create_new!("Engineering", "Tech", "Operating machinery and specialised equipment", labourer, engineer, hacker)
demolitions = Skill.create_new!("Demolitions", "Tech", "Use of demolition charges and explosives", gangster, labourer, nil)
flying = Skill.create_new!("Flying", "Tech", "Controlling flyers of all kinds", pilot, nil, nil)
gambling = Skill.create_new!("Gambling", "Social", "Familiarity with a variety of gambling games", politico, gangster, suit)
gunnery = Skill.create_new!("Gunnery", "Military", "Operation of turrets and artillery", pilot, home_guard, nil)
combat = Skill.create_new!("Combat", "Military", "Use of personal firearms and melee weapons", judge, gangster, home_guard)
investigation = Skill.create_new!("Investigation", "Intelligence", "Observation, forensics and analysis", judge, spook, freelancer)
languages = Skill.create_new!("Languages", "Intelligence", "Linguistics and translation", blogger, professor, suit)
leadership = Skill.create_new!("Leadership", "Social", "Directing, inspiring and rallying other citizens", management, civic, politico)
mechanics = Skill.create_new!("Mechanics", "Tech", "Maintaining and repairing equipment", engineer, labourer, retailer)
medic = Skill.create_new!("Medic", "Science", "First aid, medical diagnosis, treatment and surgery", doctor, fixer, nil)
persuasion = Skill.create_new!("Persuasion", "Social", "Fast talking, bargaining and bluffing", spook, fixer, judge)
physics = Skill.create_new!("Physics", "Science", "Study of fundamental forces", professor, engineer, nil)
chemistry = Skill.create_new!("Chemistry", "Science", "Study of matter", professor, engineer, nil)
electronics = Skill.create_new!("Electronics", "Science", "Study of circuits and computer hardware", engineer, hacker, nil)
biology = Skill.create_new!("Biology", "Science", "Study of living organisms", professor, doctor, nil)
economics = Skill.create_new!("Economics", "Science", "Study of trade and markets", professor, management, nil)
psychology = Skill.create_new!("Psychology", "Science", "Study of thought and society", doctor, civic, nil)
steward = Skill.create_new!("Steward", "Business", "Caring and service for other citizens", retailer, fixer, nil)
tactics = Skill.create_new!("Tactics", "Military", "Planning and decision making", home_guard, pilot, nil)
craft = Skill.create_new!("Craft", "Business", "Producing useful goods or services", labourer, engineer, nil)

# Districts

district1 = District.create_new!("District 1", "The administration centre and home to the technoracy that governs Ultimapolis", leadership, {total_land: 1000, free_land: 1000, health: 100, policing: 100, environment: 90, education: 75, community: 10, creativity: 90, aesthetics: 100, crime: 0, corruption: 50})
district2 = District.create_new!("District 2", "The financial district and home to the MegaCorporation HQ", admin, {total_land: 1000, free_land: 1000, health: 100, policing: 100, environment: 80, education: 75, community: 10, creativity: 75, aesthetics: 50, crime: 5, corruption: 50})
district3 = District.create_new!("District 3", "The campus of the Universal Foundation of Higher Learning", advocacy, {total_land: 3000, free_land: 3000, health: 100, environment: 75, education: 100, creativity: 100, aesthetics: 75})
district4 = District.create_new!("District 4", "The great exurbs where the vast majority of the population live", steward, {transport_capacity: 1000, civilians: 1000, housing: 1000, creativity: 10, aesthetics: 25})
district5 = District.create_new!("District 5", "The light industrial district where finished consumer goods are produced", craft, {automatons: 500, social: 5, education: 25, community: 10, creativity: 25})
district6 = District.create_new!("District 6", "The heavy manufacturing district where raw goods are made into useful components", engineering, {automatons: 2500, social: 5, environment: 30, education: 25, community: 10, creativity: 5})
district7 = District.create_new!("District 7", "The outskirt district which is home to power generation and dirty polluting industries", mechanics, {total_land: 15000, free_land: 15000, automatons: 5000, health: 10, social: 0, environment: 10, education: 10, community: 10, aesthetics: 0})
district8 = District.create_new!("District 8", "The far district which is home to the automated farmlands that feeds Ultimapolis", farming, {total_land: 10000, free_land: 10000, automatons: 5000, health: 75, social: 5, environment: 60, education: 10, aesthetics: 5})
district9 = District.create_new!("District 9", "The remote district which is home to the mining and excavation industries", demolitions, {total_land: 10000, free_land: 10000, automatons: 5000, health: 25, social: 0, environment: 30, education: 10, community: 10, aesthetics: 5, crime: 25})
wastelands = District.create_new!("Wastelands", "Beyond the borders of Ultimapolis", combat, {total_land: 0, free_land: 0, automatons: 0, health: 0, social: 0, environment: 0, education: 0, community: 0, aesthetics: 0, crime: 100})

# Facility Types

# Trade Goods

## Wastelands

outpost = FacilityType.create_new!("Outpost", "Remote extraction facility", wastelands, {build_cost: 10000, maintenance_cost: 1000})

exotic_bio = TradeGood.create_new!("Exotic Biochemicals", "Dangerous chemicals, extracts from endangered species", outpost, [])
exotic_drugs = TradeGood.create_new!("Exotic Drugs", "Addictive drugs, combat drugs", outpost, [])
exotic_luxuries = TradeGood.create_new!("Exotic Luxuries", "Debauched or addictive luxuries", outpost, [])

## District 9 (mining)

mine = FacilityType.create_new!("Mine", "Standard automated mine", district9, {pollution: 1})
advanced_mine = FacilityType.create_new!("Advanced Mine", "Advanced mine for extracting rare resources", district9, {pollution: 2, build_cost: 10000, maintenance_cost: 1000})

basic_ores = TradeGood.create_new!("Basic Ore", "Ore bearing common metals", mine, [])
crystals = TradeGood.create_new!("Crystals and Gems", "Diamonds, synthetic or natural gemstones", mine, [])
uncommon_ore = TradeGood.create_new!("Uncommon Ore", "Ore containing precious or valuable metals", advanced_mine, [])
uncommon_materials = TradeGood.create_new!("Uncommon Materials", "Valuable metals like titanium, rare elements", advanced_mine, [])
radioactives = TradeGood.create_new!("Radioactives", "Uranium, plutonium, unobtanium, rare elements", advanced_mine, [])

## District 8 (farming)

farm = FacilityType.create_new!("Farm", "Standard agricultural facility", district8, {})
harvester = FacilityType.create_new!("Harvester", "Standard harvesting of natural resources", district8, {})

organics = TradeGood.create_new!("Organics", "Grains and fruits", farm, [])
live_animals = TradeGood.create_new!("Live Animals", "Riding animals, beasts of burden, exotic pets", farm, [])
spices = TradeGood.create_new!("Spices", "Preservatives, luxury food additives, natural drugs", harvester, [])
wood = TradeGood.create_new!("Wood", "Hard or beautiful woods and plant extracts", harvester, [])

## District 7 (dirty industry)

chemical_plant = FacilityType.create_new!("Chemical Plant", "Chemical processing plant", district7, {pollution: 2})
smelter = FacilityType.create_new!("Smelter", "Smelter of metal ore", district7, {pollution: 2})
small_power = FacilityType.create_new!("Small Power Plant", "Power generation with minimal pollution", district7, {power_consumption: 0, power_generation: 10, pollution: 2})
large_power = FacilityType.create_new!("Large Power Plant", "Power generation with maximal output", district7, {power_consumption: 0, power_generation: 50, pollution: 10, build_cost: 10000, maintenance_cost: 1000})

bio_chems = TradeGood.create_new!("Biochemicals", "Biofuels, organic chemicals, extracts", chemical_plant, [[organics, 1]])
petro_chems = TradeGood.create_new!("Petrochemicals", "Oil, liquid fuels", chemical_plant, [[organics, 1]])
polymers = TradeGood.create_new!("Polymers", "Plastics and other synthetics", chemical_plant, [[organics, 1]])
alloys = TradeGood.create_new!("Processed Metals", "Alloys and durable metals", smelter, [[basic_ores, 1]])
precious_metals = TradeGood.create_new!("Precious Metals", "Gold, silver, platinum, rare elements", smelter, [[uncommon_ore, 1]])

## District 6 (heavy industry)

basic_factory = FacilityType.create_new!("Basic Factory", "Basic heavy industrial factory", district6, {pollution: 1})
robot_factory = FacilityType.create_new!("Robot Factory", "Factory for producing robots", district6, {pollution: 1})
vehicle_assembly = FacilityType.create_new!("Vehicle Assembly Factory", "Factory for assembling vehicles", district6, {pollution: 1})
advanced_factory = FacilityType.create_new!("Advanced Factory", "Advanced heavy industrial factory", district6, {pollution: 2, build_cost: 10000, maintenance_cost: 1000})
state_of_art_factory = FacilityType.create_new!("State of the Art Factory", "State of the art heavy industrial factory", district6, {pollution: 2, build_cost: 50000, maintenance_cost: 1000})

basic_electronics = TradeGood.create_new!("Basic Electronics", "Simple electronics including basic computers", basic_factory, [[alloys, 1], [precious_metals, 2]])
basic_machine_parts = TradeGood.create_new!("Basic Machine Parts", "Machine components and spare parts for common machinery", basic_factory, [[alloys, 2], [polymers, 1]])
basic_materials = TradeGood.create_new!("Basic Materials", "Processed metal, plastics, chemicals and other basic materials.", basic_factory, [[alloys, 1], [polymers, 2]])
basic_manufactered = TradeGood.create_new!("Basic Manufactured Goods", "Household appliances, clothing", basic_factory, [[alloys, 1],[polymers, 2]])
robots = TradeGood.create_new!("Robots", "Industrial and personal robots and drones", robot_factory, [[basic_electronics, 1],[basic_machine_parts, 1]])
vehicles = TradeGood.create_new!("Vehicles", "Wheeled, tracked and other vehicles", vehicle_assembly, [[basic_electronics, 1], [basic_machine_parts, 2], [petro_chems, 1]])
advanced_electronics = TradeGood.create_new!("Advanced Electronics", "Advanced sensors, computers and other electronics", advanced_factory, [[basic_electronics, 1],[precious_metals, 1],[crystals, 1]])
advanced_machine_parts = TradeGood.create_new!("Advanced Machine Parts", "Machine components and spare parts", advanced_factory, [[basic_machine_parts, 1],[basic_electronics, 1], [uncommon_materials, 1]])
advanced_manufactured = TradeGood.create_new!("Advanced Manufactured Goods", "Devices and clothing incorporating advanced technologies", advanced_factory, [[advanced_electronics, 1], [advanced_machine_parts, 1]])
advanced_weapons = TradeGood.create_new!("Advanced Weapons", "Firearms, explosives, ammunition, artillery and other military-grade weaponry", state_of_art_factory, [[advanced_electronics, 1], [advanced_machine_parts, 1], [radioactives, 1]])
advanced_vehicles = TradeGood.create_new!("Advanced Vehicles", "Aircraft and grav lifters", state_of_art_factory, [[advanced_electronics, 1], [advanced_machine_parts, 1], [radioactives, 1]])
power_relay = TradeGood.create_new!("Power Relay", "Enhances power grid reach and reliability", basic_factory, [[basic_electronics, 1],[alloys, 2], [polymers, 2]])
scrubbers = TradeGood.create_new!("Scrubbers", "Removes pollutants from atmosphere", state_of_art_factory, [[advanced_electronics, 1],[robots, 1],[advanced_vehicles, 1]])

## District 5 (light industry)

biolab = FacilityType.create_new!("Biolab", "Biochemical laboratory", district5, {build_cost: 10000, maintenance_cost: 1000})
textile_factory = FacilityType.create_new!("Textile Factory", "Textile goods factory", district5, {})
light_factory = FacilityType.create_new!("Light Factory", "Producer of consumer goods", district5, {})
techlab = FacilityType.create_new!("Techlab", "Technology and electronics goods laboratory", district5, {build_cost: 10000, maintenance_cost: 1000})

pharma = TradeGood.create_new!("Pharmaceuticals", "Drugs, medical supplies", biolab, [[bio_chems, 1]])
textiles = TradeGood.create_new!("Textiles", "Clothing and fabrics", textile_factory, [[polymers, 1]])
basic_consumables = TradeGood.create_new!("Basic Consumables", "Food, drink and other agricultural products", light_factory, [[live_animals, 1], [organics, 1],[bio_chems, 1]])
cybernetics = TradeGood.create_new!("Cybernetics", "Cybernetic components, replacement limbs", techlab, [[advanced_electronics, 1], [bio_chems, 1]])
luxury_consumables = TradeGood.create_new!("Luxury Consumables", "Rare foods, fine liquors", light_factory, [[basic_consumables, 1],[spices, 1]])
luxury_goods = TradeGood.create_new!("Luxury Goods", "Rare or extremely high-quality manufactured goods", light_factory, [[advanced_manufactured, 1]])

## District 4 (housing/community)

basic_housing = FacilityType.create_new!("Basic Housing", "Basic Housing", district4, {housing_mod: 100})
dense_housing = FacilityType.create_new!("Dense Housing", "High Density Housing", district4, {build_cost: 10000, maintenance_cost: 500, housing_mod: 1000})
community_centre = FacilityType.create_new!("Community Centre", "Community centre for producing communal goods", district4, {})

communal_goods = TradeGood.create_new!("Communal Goods", "Working to tie communities together", community_centre, [[basic_consumables, 1],[pharma, 1]])

## District 3 (knowledge)

school = FacilityType.create_new!("School", "Basic school", district3, {})
college = FacilityType.create_new!("College", "Education college", district3, {})
hospital = FacilityType.create_new!("Hospital", "Emergency health care facility", district3, {})
nursing_home = FacilityType.create_new!("Nursing Home", "Long-term care facility", district3, {})

health_kit = TradeGood.create_new!("Health Kit", "Improves public health", hospital, [[pharma, 1]])
nurse_bot = TradeGood.create_new!("Nurse Bot", "Increases social care in districts", nursing_home, [[robots, 1],[health_kit, 1]])
basic_education = TradeGood.create_new!("Basic Education", "Standard education for children", school, [[basic_electronics, 1]])
advanced_education = TradeGood.create_new!("Advanced Education", "Education for the bright and determined", college, [[advanced_electronics, 1], [basic_education, 1]])

## District 2 (finance / business)

small_bank = FacilityType.create_new!("Small Bank", "Small commercial bank", district2, {})
large_bank = FacilityType.create_new!("Large Bank", "Major investment bank", district2, {})

basic_infrastructure = TradeGood.create_new!("Basic Infrastructure", "Wiring, piping and structural infastructure", small_bank, [[robots, 10],[vehicles, 5],[alloys, 100],[polymers, 100],[bio_chems, 100], [wood, 100]])
advanced_infrastructure = TradeGood.create_new!("Advanced Infrastructure", "High density infrastructure", large_bank, [[robots, 50],[vehicles, 25],[alloys, 500],[polymers, 500],[bio_chems, 500], [wood, 500], [radioactives, 10]])

## District 1 (political)

security = FacilityType.create_new!("Security", "Security services station", district1, {})
gallery = FacilityType.create_new!("Gallery", "Art exhibition", district1, {})
broadcast_station = FacilityType.create_new!("Broadcast Station", "Holovid broadcasting station", district1, {})
forum = FacilityType.create_new!("Forum", "Public forum", district1, {})

holovids = TradeGood.create_new!("Holovids", "Entertainment for the masses", broadcast_station, [[basic_electronics, 1]])

art_objects = TradeGood.create_new!("Art Objects", "Refined entertainement for the wealthy", gallery, [[polymers, 1],[wood, 1],[textiles, 1]])
public_art = TradeGood.create_new!("Public Art", "Improving the aesthetics of districts", gallery, [[crystals, 1],[precious_metals,1],[wood, 1]])

surveillance_network = TradeGood.create_new!("Surveillance Network", "Keeps the streets secure", security, [[basic_electronics, 1],[robots, 1]])
border_post = TradeGood.create_new!("Border Post", "Secures the border from invasion and immigrants", security, [[basic_electronics, 1],[robots, 1],[advanced_weapons, 1]])
security_bot = TradeGood.create_new!("Security Bot", "Imcreases policing in districts", security, [[advanced_electronics, 1],[robots, 1]])

public_discourse = TradeGood.create_new!("Public Discourse", "Helps liberty prosper", forum, [])

# Equipment Types

EquipmentType.create_new!("Personal Computer", "Portable general purpose computer with fast data processing and always-on network connection", techlab, admin, 2, [[basic_electronics, 1]])
EquipmentType.create_new!("Neural Assistant", "Cybernetic implant than increases fluency and mental agility", techlab, advocacy, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Animal Biotics", "Medicine, steroids and hormones for treating animals", biolab, veterinary, 2, [[pharma, 1]])
EquipmentType.create_new!("Auto-Tractor", "Autonomous farming vehicle", vehicle_assembly, farming, 2, [[vehicles, 1]])
EquipmentType.create_new!("Performance Drugs", "Designer steroids for enhanced athletic performance", biolab, athletics, 2, [[pharma, 1]])
EquipmentType.create_new!("Empathy Glands", "Extracted glands from wasteland empaths", biolab, acting, 2, [[exotic_bio, 1]])
EquipmentType.create_new!("Muscle Mesh", "Cybernetic control system and bone fibre weave", hospital, dance, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Holocam Drone", "Small autonomous drone with audiovisual sensors and short range broadcasting", light_factory, holography, 2, [[basic_electronics, 1]])
EquipmentType.create_new!("Crystal Synth", "Gem-weaved electronic synthesiser", light_factory, instrument, 2, [[basic_electronics, 1],[crystals, 1]])
EquipmentType.create_new!("Precision Chisel", "Fine tools for the budding sculptor", techlab, sculpting, 2, [[advanced_manufactured, 1]])
EquipmentType.create_new!("Wikiliner", "Smart software for data organisation and textual analysis", college, writing, 2, [[basic_electronics, 1]])
EquipmentType.create_new!("Trading Bot", "Autonomous trading robot", robot_factory, broker, 2, [[robots, 1]])
EquipmentType.create_new!("Pleasure Android", "Android designed for fun", robot_factory, carouse, 2, [[robots, 1]])
EquipmentType.create_new!("Jammer", "Signal blocker and quantum data encryption", techlab, comms, 2, [[advanced_electronics, 1]])
EquipmentType.create_new!("Artificial Intelligence", "Discretely intelligent software", techlab, computers, 2, [[advanced_electronics, 1]])
EquipmentType.create_new!("Stimulant", "Increases confidence and masks body language", biolab, deception, 2, [[pharma, 1]])
EquipmentType.create_new!("Profiler", "Analyses overt and subliminal communication and cross-references against cultural database", college, diplomacy, 2, [[advanced_electronics, 1]])
EquipmentType.create_new!("Reactive Implant", "Cybernetic implant that improves reaction and hand-eye coordination", hospital, driving, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Neural Interface", "Cybernetic implant for operating machinery directly with the brain", techlab, engineering, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Nano-Charges", "Nanoscale explosive charges", state_of_art_factory, demolitions, 2, [[advanced_manufactured, 1]])
EquipmentType.create_new!("Motion Implant", "Cybernetic implant that gives innate feel for aviation", hospital, flying, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Luck Serum", "Uncertain providence", biolab, gambling, 2, [[exotic_drugs, 1]])
EquipmentType.create_new!("Exo-Skeletal Suit", "Titanium alloy body suit with full weapons platform", state_of_art_factory, gunnery, 2, [[advanced_weapons, 1]])
EquipmentType.create_new!("Combat Armour", "Advanced body armour offering protection from firearms and blades", advanced_factory, combat, 2, [[advanced_weapons, 1]])
EquipmentType.create_new!("Forensic Kit", "Standard issue forensic field lab", college, investigation, 2, [[basic_electronics, 1]])
EquipmentType.create_new!("Babel Fish", "Cybernetic implant with linguistic analysis capabilities", techlab, languages, 2, [[cybernetics, 1]])
EquipmentType.create_new!("Presence Hormones", "Milked from the genetilia of male Wasteland Dragons", biolab, leadership, 2, [[exotic_drugs, 1]])
EquipmentType.create_new!("Nanite Repair Kit", "Nano scale repair bots", state_of_art_factory, mechanics, 2, [[advanced_manufactured, 1]])
EquipmentType.create_new!("Field Medic Kit", "Standard issue medical kit", hospital, medic, 2, [[pharma, 1]])
EquipmentType.create_new!("Charisma Glands", "Implanted artificial glands that enhance social functions in the brain", biolab, persuasion, 2, [[exotic_bio, 1]])
EquipmentType.create_new!("Personality Suppressant", "Self-worth depressants", biolab, steward, 2, [[pharma, 1]])
EquipmentType.create_new!("Reality Simulator", "Holo simulator with n-dimensional probability matrix", techlab, tactics, 2, [[advanced_electronics, 1]])
EquipmentType.create_new!("Specialised Tools", "Multi-purpose crafting tools", advanced_factory, craft, 2, [[advanced_manufactured, 1]])