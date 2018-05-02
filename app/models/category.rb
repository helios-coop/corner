# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :categories_listings
  has_many :listings, through: :categories_listings

  def self.update_all_categories
    CATEGORY_NAMES.each do |category_name|
      Category.find_or_create_by(name: category_name)
    end
  end

  CATEGORY_NAMES = [
    "Active Life",
    "ATV Rentals",
    "Airsoft",
    "Amateur Sports Teams",
    "Amusement Parks",
    "Aquariums",
    "Archery",
    "Axe Throwing",
    "Badminton",
    "Baseball Fields",
    "Basketball Courts",
    "Batting Cages",
    "Beach Equipment Rentals",
    "Beaches",
    "Bike Parking",
    "Bike Rentals",
    "Boating",
    "Bobsledding",
    "Bocce Ball",
    "Bowling",
    "Bubble Soccer",
    "Bungee Jumping",
    "Carousels",
    "Challenge Courses",
    "Climbing",
    "Cycling Classes",
    "Day Camps",
    "Disc Golf",
    "Diving",
    "Free Diving",
    "Scuba Diving",
    "Escape Games",
    "Fencing Clubs",
    "Fishing",
    "Fitness & Instruction",
    "Aerial Fitness",
    "Barre Classes",
    "Boot Camps",
    "Boxing",
    "Cardio Classes",
    "Dance Studios",
    "Golf Lessons",
    "Gyms",
    "Circuit Training Gyms",
    "Interval Training Gyms",
    "Martial Arts",
    "Brazilian Jiu-jitsu",
    "Chinese Martial Arts",
    "Karate",
    "Kickboxing",
    "Muay Thai",
    "Taekwondo",
    "Meditation Centers",
    "Pilates",
    "Qi Gong",
    "Self-defense Classes",
    "Swimming Lessons/Schools",
    "Tai Chi",
    "Trainers",
    "Yoga",
    "Flyboarding",
    "Go Karts",
    "Golf",
    "Gun/Rifle Ranges",
    "Gymnastics",
    "Hang Gliding",
    "Hiking",
    "Horse Racing",
    "Horseback Riding",
    "Hot Air Balloons",
    "Indoor Playcentre",
    "Jet Skis",
    "Kids Activities",
    "Kiteboarding",
    "Lakes",
    "Laser Tag",
    "Mini Golf",
    "Mountain Biking",
    "Nudist",
    "Paddleboarding",
    "Paintball",
    "Parasailing",
    "Parks",
    "Dog Parks",
    "Skate Parks",
    "Playgrounds",
    "Races & Competitions",
    "Racing Experience",
    "Rafting & Kayaking",
    "Recreation Centers",
    "Rock Climbing",
    "Sailing",
    "Scavenger Hunts",
    "Scooter Rentals",
    "Senior Centers",
    "Skating Rinks",
    "Skydiving",
    "Sledding",
    "Snorkeling",
    "Soccer",
    "Sports Clubs",
    "Squash",
    "Summer Camps",
    "Surfing",
    "Swimming Pools",
    "Tennis",
    "Trampoline Parks",
    "Tubing",
    "Water Parks",
    "Wildlife Hunting Ranges",
    "Ziplining",
    "Zoos",
    "Petting Zoos",
    "Zorbing",
    "Arts & Entertainment",
    "Arcades",
    "Art Galleries",
    "Bingo Halls",
    "Botanical Gardens",
    "Cabaret",
    "Casinos",
    "Cinema",
    "Drive-In Theater",
    "Outdoor Movies",
    "Country Clubs",
    "Cultural Center",
    "Eatertainment",
    "Farms",
    "Attraction Farms",
    "Pick Your Own Farms",
    "Ranches",
    "Festivals",
    "Haunted Houses",
    "Jazz & Blues",
    "LAN Centers",
    "Makerspaces",
    "Museums",
    "Art Museums",
    "Children's Museums",
    "Music Venues",
    "Observatories",
    "Opera & Ballet",
    "Paint & Sip",
    "Performing Arts",
    "Planetarium",
    "Professional Sports Teams",
    "Race Tracks",
    "Rodeo",
    "Social Clubs",
    "Veterans Organizations",
    "Stadiums & Arenas",
    "Studio Taping",
    "Supernatural Readings",
    "Astrologers",
    "Mystics",
    "Psychic Mediums",
    "Psychics",
    "Ticket Sales",
    "Virtual Reality Centers",
    "Wineries",
    "Wine Tasting Room",
    "Automotive",
    "Aircraft Dealers",
    "Aircraft Repairs",
    "Auto Customization",
    "Auto Detailing",
    "Auto Glass Services",
    "Car Window Tinting",
    "Auto Loan Providers",
    "Auto Parts & Supplies",
    "Auto Repair",
    "DIY Auto Shop",
    "Auto Security",
    "Auto Upholstery",
    "Aviation Services",
    "Boat Dealers",
    "Boat Parts & Supplies",
    "Body Shops",
    "Car Auctions",
    "Car Brokers",
    "Car Buyers",
    "Car Dealers",
    "Car Inspectors",
    "Car Share Services",
    "Car Stereo Installation",
    "Car Wash",
    "Commercial Truck Dealers",
    "Commercial Truck Repair",
    "EV Charging Stations",
    "Fuel Docks",
    "Gas Stations",
    "Golf Cart Dealers",
    "Hybrid Car Repair",
    "Interlock Systems",
    "Marinas",
    "Mobile Dent Repair",
    "Mobility Equipment Sales & Services",
    "Motorcycle Dealers",
    "Motorcycle Repair",
    "Motorsport Vehicle Dealers",
    "Motorsport Vehicle Repairs",
    "Oil Change Stations",
    "Parking",
    "RV Dealers",
    "RV Repair",
    "Registration Services",
    "Roadside Assistance",
    "Service Stations",
    "Smog Check Stations",
    "Tires",
    "Towing",
    "Trailer Dealers",
    "Trailer Rental",
    "Trailer Repair",
    "Transmission Repair",
    "Truck Rental",
    "Used Car Dealers",
    "Vehicle Shipping",
    "Vehicle Wraps",
    "Wheel & Rim Repair",
    "Windshield Installation & Repair",
    "Beauty & Spas",
    "Acne Treatment",
    "Barbers",
    "Cosmetics & Beauty Supply",
    "Day Spas",
    "Eyebrow Services",
    "Eyelash Service",
    "Hair Extensions",
    "Hair Loss Centers",
    "Hair Removal",
    "Laser Hair Removal",
    "Sugaring",
    "Threading Services",
    "Waxing",
    "Hair Salons",
    "Blow Dry/Out Services",
    "Hair Extensions",
    "Hair Stylists",
    "Kids Hair Salons",
    "Men's Hair Salons",
    "Hot Springs",
    "Makeup Artists",
    "Massage",
    "Medical Spas",
    "Aestheticians",
    "Nail Salons",
    "Nail Technicians",
    "Perfume",
    "Permanent Makeup",
    "Piercing",
    "Skin Care",
    "Estheticians",
    "Tanning",
    "Spray Tanning",
    "Tanning Beds",
    "Tattoo",
    "Teeth Whitening",
    "Education",
    "Adult Education",
    "Art Classes",
    "Glass Blowing",
    "College Counseling",
    "Colleges & Universities",
    "Educational Services",
    "Elementary Schools",
    "Middle Schools & High Schools",
    "Montessori Schools",
    "Preschools",
    "Private Schools",
    "Private Tutors",
    "Religious Schools",
    "Special Education",
    "Specialty Schools",
    "Art Schools",
    "Bartending Schools",
    "CPR Classes",
    "Cheerleading",
    "Childbirth Education",
    "Cooking Schools",
    "Cosmetology Schools",
    "DUI Schools",
    "Dance Schools",
    "Drama Schools",
    "Driving Schools",
    "Firearm Training",
    "First Aid Classes",
    "Flight Instruction",
    "Food Safety Training",
    "Language Schools",
    "Massage Schools",
    "Nursing Schools",
    "Parenting Classes",
    "Photography Classes",
    "Pole Dancing Classes",
    "Ski Schools",
    "Speech Training",
    "Surf Schools",
    "Swimming Lessons/Schools",
    "Traffic Schools",
    "Vocational & Technical School",
    "Tasting Classes",
    "Cheese Tasting Classes",
    "Wine Tasting Classes",
    "Test Preparation",
    "Tutoring Centers",
    "Waldorf Schools",
    "Event Planning & Services",
    "Balloon Services",
    "Bartenders",
    "Boat Charters",
    "Cards & Stationery",
    "Caricatures",
    "Caterers",
    "Clowns",
    "DJs",
    "Face Painting",
    "Floral Designers",
    "Game Truck Rental",
    "Golf Cart Rentals",
    "Henna Artists",
    "Hotels",
    "Mountain Huts",
    "Rest Stops",
    "Magicians",
    "Mohels",
    "Musicians",
    "Officiants",
    "Party & Event Planning",
    "Party Bike Rentals",
    "Party Bus Rentals",
    "Party Characters",
    "Party Equipment Rentals",
    "Audio/Visual Equipment Rental",
    "Bounce House Rentals",
    "Karaoke Rental",
    "Party Supplies",
    "Personal Chefs",
    "Photo Booth Rentals",
    "Photographers",
    "Boudoir Photography",
    "Event Photography",
    "Session Photography",
    "Silent Disco",
    "Sommelier Services",
    "Team Building Activities",
    "Trivia Hosts",
    "Valet Services",
    "Venues & Event Spaces",
    "Videographers",
    "Wedding Chapels",
    "Wedding Planning",
    "Financial Services",
    "Banks & Credit Unions",
    "Business Financing",
    "Check Cashing/Pay-day Loans",
    "Currency Exchange",
    "Debt Relief Services",
    "Financial Advising",
    "Installment Loans",
    "Insurance",
    "Auto Insurance",
    "Home & Rental Insurance",
    "Life Insurance",
    "Investing",
    "Mortgage Lenders",
    "Tax Services",
    "Title Loans",
    "Food",
    "Acai Bowls",
    "Bagels",
    "Bakeries",
    "Beer, Wine & Spirits",
    "Beverage Store",
    "Breweries",
    "Brewpubs",
    "Bubble Tea",
    "Butcher",
    "CSA",
    "Chimney Cakes",
    "Cideries",
    "Coffee & Tea",
    "Coffee Roasteries",
    "Convenience Stores",
    "Cupcakes",
    "Custom Cakes",
    "Desserts",
    "Distilleries",
    "Do-It-Yourself Food",
    "Donuts",
    "Empanadas",
    "Farmers Market",
    "Food Delivery Services",
    "Food Trucks",
    "Gelato",
    "Grocery",
    "Honey",
    "Ice Cream & Frozen Yogurt",
    "Imported Food",
    "International Grocery",
    "Internet Cafes",
    "Juice Bars & Smoothies",
    "Kombucha",
    "Organic Stores",
    "Patisserie/Cake Shop",
    "Piadina",
    "Poke",
    "Pretzels",
    "Shaved Ice",
    "Shaved Snow",
    "Smokehouse",
    "Specialty Food",
    "Candy Stores",
    "Cheese Shops",
    "Chocolatiers & Shops",
    "Fruits & Veggies",
    "Health Markets",
    "Herbs & Spices",
    "Macarons",
    "Meat Shops",
    "Olive Oil",
    "Pasta Shops",
    "Popcorn Shops",
    "Seafood Markets",
    "Street Vendors",
    "Tea Rooms",
    "Water Stores",
    "Wineries",
    "Wine Tasting Room",
    "Health & Medical",
    "Acupuncture",
    "Alternative Medicine",
    "Animal Assisted Therapy",
    "Assisted Living Facilities",
    "Ayurveda",
    "Behavior Analysts",
    "Blood & Plasma Donation Centers",
    "Body Contouring",
    "Cannabis Clinics",
    "Cannabis Tours",
    "Cannabis Collective",
    "Chiropractors",
    "Colonics",
    "Concierge Medicine",
    "Counseling & Mental Health",
    "Psychologists",
    "Sex Therapists",
    "Sports Psychologists",
    "Cryotherapy",
    "Dental Hygienists",
    "Dentists",
    "Cosmetic Dentists",
    "Endodontists",
    "General Dentistry",
    "Oral Surgeons",
    "Orthodontists",
    "Pediatric Dentists",
    "Periodontists",
    "Diagnostic Services",
    "Diagnostic Imaging",
    "Laboratory Testing",
    "Dialysis Clinics",
    "Dietitians",
    "Doctors",
    "Addiction Medicine",
    "Allergists",
    "Anesthesiologists",
    "Audiologist",
    "Cardiologists",
    "Cosmetic Surgeons",
    "Dermatologists",
    "Ear Nose & Throat",
    "Emergency Medicine",
    "Endocrinologists",
    "Family Practice",
    "Fertility",
    "Gastroenterologist",
    "Geneticists",
    "Gerontologists",
    "Hepatologists",
    "Hospitalists",
    "Immunodermatologists",
    "Infectious Disease Specialists",
    "Internal Medicine",
    "Naturopathic/Holistic",
    "Nephrologists",
    "Neurologist",
    "Neuropathologists",
    "Neurotologists",
    "Obstetricians & Gynecologists",
    "Oncologist",
    "Ophthalmologists",
    "Retina Specialists",
    "Orthopedists",
    "Osteopathic Physicians",
    "Otologists",
    "Pain Management",
    "Pathologists",
    "Pediatricians",
    "Phlebologists",
    "Plastic Surgeons",
    "Podiatrists",
    "Preventive Medicine",
    "Proctologists",
    "Psychiatrists",
    "Pulmonologist",
    "Radiologists",
    "Rheumatologists",
    "Spine Surgeons",
    "Sports Medicine",
    "Surgeons",
    "Tattoo Removal",
    "Toxicologists",
    "Undersea/Hyperbaric Medicine",
    "Urologists",
    "Vascular Medicine",
    "Doulas",
    "Emergency Rooms",
    "Float Spa",
    "Habilitative Services",
    "Halfway Houses",
    "Halotherapy",
    "Health Coach",
    "Health Insurance Offices",
    "Hearing Aid Providers",
    "Herbal Shops",
    "Home Health Care",
    "Hospice",
    "Hospitals",
    "Hydrotherapy",
    "Hypnosis/Hypnotherapy",
    "IV Hydration",
    "Lactation Services",
    "Laser Eye Surgery/Lasik",
    "Lice Services",
    "Massage Therapy",
    "Medical Cannabis Referrals",
    "Medical Centers",
    "Walk-in Clinics",
    "Medical Spas",
    "Aestheticians",
    "Medical Transportation",
    "Memory Care",
    "Midwives",
    "Nurse Practitioner",
    "Nutritionists",
    "Occupational Therapy",
    "Optometrists",
    "Organ & Tissue Donor Services",
    "Orthotics",
    "Oxygen Bars",
    "Personal Care Services",
    "Pharmacy",
    "Physical Therapy",
    "Placenta Encapsulations",
    "Prenatal/Perinatal Care",
    "Prosthetics",
    "Prosthodontists",
    "Reflexology",
    "Rehabilitation Center",
    "Reiki",
    "Retirement Homes",
    "Saunas",
    "Skilled Nursing",
    "Sleep Specialists",
    "Speech Therapists",
    "Sperm Clinic",
    "Traditional Chinese Medicine",
    "Tui Na",
    "Ultrasound Imaging Centers",
    "Urgent Care",
    "Weight Loss Centers",
    "Home Services",
    "Artificial Turf",
    "Building Supplies",
    "Cabinetry",
    "Carpenters",
    "Carpet Installation",
    "Carpeting",
    "Childproofing",
    "Chimney Sweeps",
    "Contractors",
    "Countertop Installation",
    "Damage Restoration",
    "Decks & Railing",
    "Demolition Services",
    "Door Sales/Installation",
    "Drywall Installation & Repair",
    "Electricians",
    "Excavation Services",
    "Fences & Gates",
    "Fire Protection Services",
    "Fireplace Services",
    "Firewood",
    "Flooring",
    "Foundation Repair",
    "Furniture Assembly",
    "Garage Door Services",
    "Gardeners",
    "Glass & Mirrors",
    "Grout Services",
    "Gutter Services",
    "Handyman",
    "Heating & Air Conditioning/HVAC",
    "Holiday Decorating Services",
    "Home Automation",
    "Home Cleaning",
    "Home Energy Auditors",
    "Home Inspectors",
    "Home Network Installation",
    "Home Organization",
    "Home Theatre Installation",
    "Home Window Tinting",
    "House Sitters",
    "Insulation Installation",
    "Interior Design",
    "Internet Service Providers",
    "Irrigation",
    "Keys & Locksmiths",
    "Landscape Architects",
    "Landscaping",
    "Lawn Services",
    "Lighting Fixtures & Equipment",
    "Masonry/Concrete",
    "Mobile Home Repair",
    "Movers",
    "Packing Services",
    "Painters",
    "Patio Coverings",
    "Plumbing",
    "Backflow Services",
    "Pool & Hot Tub Service",
    "Pool Cleaners",
    "Pressure Washers",
    "Real Estate",
    "Apartments",
    "Art Space Rentals",
    "Commercial Real Estate",
    "Condominiums",
    "Estate Liquidation",
    "Home Developers",
    "Home Staging",
    "Homeowner Association",
    "Housing Cooperatives",
    "Kitchen Incubators",
    "Mobile Home Dealers",
    "Mobile Home Parks",
    "Mortgage Brokers",
    "Property Management",
    "Real Estate Agents",
    "Apartment Agents",
    "Real Estate Services",
    "Land Surveying",
    "Real Estate Photography",
    "Shared Office Spaces",
    "University Housing",
    "Refinishing Services",
    "Roof Inspectors",
    "Roofing",
    "Security Systems",
    "Shades & Blinds",
    "Shutters",
    "Siding",
    "Solar Installation",
    "Solar Panel Cleaning",
    "Structural Engineers",
    "Stucco Services",
    "Television Service Providers",
    "Tiling",
    "Tree Services",
    "Utilities",
    "Electricity Suppliers",
    "Natural Gas Suppliers",
    "Water Suppliers",
    "Wallpapering",
    "Water Heater Installation/Repair",
    "Water Purification Services",
    "Waterproofing",
    "Window Washing",
    "Windows Installation",
    "Hotels & Travel",
    "Airports",
    "Airport Terminals",
    "Bed & Breakfast",
    "Campgrounds",
    "Car Rental",
    "Guest Houses",
    "Health Retreats",
    "Hostels",
    "Hotels",
    "Mountain Huts",
    "Rest Stops",
    "Motorcycle Rental",
    "RV Parks",
    "RV Rental",
    "Resorts",
    "Ski Resorts",
    "Tours",
    "Aerial Tours",
    "Architectural Tours",
    "Art Tours",
    "Beer Tours",
    "Bike tours",
    "Boat Tours",
    "Bus Tours",
    "Food Tours",
    "Historical Tours",
    "Scooter Tours",
    "Walking Tours",
    "Whale Watching Tours",
    "Wine Tours",
    "Train Stations",
    "Transportation",
    "Airlines",
    "Airport Shuttles",
    "Bike Sharing",
    "Bus Stations",
    "Buses",
    "Cable Cars",
    "Ferries",
    "Limos",
    "Metro Stations",
    "Pedicabs",
    "Private Jet Charter",
    "Public Transportation",
    "Taxis",
    "Town Car Service",
    "Trains",
    "Travel Services",
    "Luggage Storage",
    "Passport & Visa Services",
    "Travel Agents",
    "Visitor Centers",
    "Vacation Rental Agents",
    "Vacation Rentals",
    "Local Flavor",
    "Parklets",
    "Public Art",
    "Unofficial Yelp Events",
    "Yelp Events",
    "Local Services",
    "3D Printing",
    "Adoption Services",
    "Air Duct Cleaning",
    "Appliances & Repair",
    "Appraisal Services",
    "Art Restoration",
    "Awnings",
    "Bail Bondsmen",
    "Bike Repair/Maintenance",
    "Bookbinding",
    "Bus Rental",
    "Calligraphy",
    "Carpet Cleaning",
    "Carpet Dyeing",
    "Child Care & Day Care",
    "Clock Repair",
    "Community Book Box",
    "Community Gardens",
    "Community Service/Non-Profit",
    "Food Banks",
    "Homeless Shelters",
    "Couriers & Delivery Services",
    "Crane Services",
    "Donation Center",
    "Elder Care Planning",
    "Electronics Repair",
    "Engraving",
    "Environmental Abatement",
    "Environmental Testing",
    "Farm Equipment Repair",
    "Fingerprinting",
    "Funeral Services & Cemeteries",
    "Cremation Services",
    "Mortuary Services",
    "Furniture Rental",
    "Furniture Repair",
    "Furniture Reupholstery",
    "Generator Installation/Repair",
    "Gunsmith",
    "Hazardous Waste Disposal",
    "Hydro-jetting",
    "IT Services & Computer Repair",
    "Data Recovery",
    "Mobile Phone Repair",
    "Telecommunications",
    "Ice Delivery",
    "Jewelry Repair",
    "Junk Removal & Hauling",
    "Dumpster Rental",
    "Junkyards",
    "Knife Sharpening",
    "Laundry Services",
    "Dry Cleaning",
    "Laundromat",
    "Machine & Tool Rental",
    "Machine Shops",
    "Mailbox Centers",
    "Metal Detector Services",
    "Metal Fabricators",
    "Misting System Services",
    "Musical Instrument Services",
    "Guitar Stores",
    "Piano Services",
    "Piano Stores",
    "Vocal Coach",
    "Nanny Services",
    "Notaries",
    "Pest Control",
    "Powder Coating",
    "Printing Services",
    "Propane",
    "Recording & Rehearsal Studios",
    "Recycling Center",
    "Sandblasting",
    "Screen Printing",
    "Screen Printing/T-Shirt Printing",
    "Self Storage",
    "Septic Services",
    "Sewing & Alterations",
    "Shipping Centers",
    "Shoe Repair",
    "Shoe Shine",
    "Snow Removal",
    "Snuggle Services",
    "TV Mounting",
    "Watch Repair",
    "Water Delivery",
    "Well Drilling",
    "Wildlife Control",
    "Mass Media",
    "Print Media",
    "Radio Stations",
    "Television Stations",
    "Nightlife",
    "Adult Entertainment",
    "Strip Clubs",
    "Striptease Dancers",
    "Bar Crawl",
    "Bars",
    "Airport Lounges",
    "Beer Bar",
    "Champagne Bars",
    "Cigar Bars",
    "Cocktail Bars",
    "Dive Bars",
    "Drive-Thru Bars",
    "Gay Bars",
    "Hookah Bars",
    "Irish Pub",
    "Lounges",
    "Pubs",
    "Speakeasies",
    "Sports Bars",
    "Tiki Bars",
    "Vermouth Bars",
    "Whiskey Bars",
    "Wine Bars",
    "Beer Gardens",
    "Club Crawl",
    "Comedy Clubs",
    "Country Dance Halls",
    "Dance Clubs",
    "Jazz & Blues",
    "Karaoke",
    "Music Venues",
    "Piano Bars",
    "Pool Halls",
    "Pets",
    "Animal Shelters",
    "Horse Boarding",
    "Pet Adoption",
    "Pet Services",
    "Animal Physical Therapy",
    "Aquarium Services",
    "Dog Walkers",
    "Emergency Pet Hospital",
    "Farriers",
    "Holistic Animal Care",
    "Pet Breeders",
    "Pet Cremation Services",
    "Pet Groomers",
    "Pet Hospice",
    "Pet Insurance",
    "Pet Photography",
    "Pet Sitting",
    "Pet Boarding",
    "Pet Training",
    "Pet Transportation",
    "Pet Waste Removal",
    "Pet Stores",
    "Bird Shops",
    "Local Fish Stores",
    "Reptile Shops",
    "Veterinarians",
    "Professional Services",
    "Accountants",
    "Advertising",
    "Architects",
    "Billing Services",
    "Boat Repair",
    "Bookkeepers",
    "Business Consulting",
    "Career Counseling",
    "Commissioned Artists",
    "Customs Brokers",
    "Digitizing Services",
    "Duplication Services",
    "Editorial Services",
    "Employment Agencies",
    "Feng Shui",
    "Graphic Design",
    "Indoor Landscaping",
    "Internet Service Providers",
    "Lawyers",
    "Bankruptcy Law",
    "Business Law",
    "Contract Law",
    "Criminal Defense Law",
    "DUI Law",
    "Disability Law",
    "Divorce & Family Law",
    "Employment Law",
    "Entertainment Law",
    "Estate Planning Law",
    "Wills, Trusts, & Probates",
    "General Litigation",
    "IP & Internet Law",
    "Immigration Law",
    "Medical Law",
    "Personal Injury Law",
    "Real Estate Law",
    "Social Security Law",
    "Tax Law",
    "Traffic Ticketing Law",
    "Workers Compensation Law",
    "Legal Services",
    "Court Reporters",
    "Process Servers",
    "Life Coach",
    "Marketing",
    "Matchmakers",
    "Mediators",
    "Music Production Services",
    "Office Cleaning",
    "Patent Law",
    "Payroll Services",
    "Personal Assistants",
    "Private Investigation",
    "Product Design",
    "Public Adjusters",
    "Public Relations",
    "Security Services",
    "Shredding Services",
    "Signmaking",
    "Software Development",
    "Talent Agencies",
    "Taxidermy",
    "Tenant and Eviction Law",
    "Translation Services",
    "Video/Film Production",
    "Web Design",
    "Wholesalers",
    "Restaurant Supplies",
    "Public Services & Government",
    "Civic Center",
    "Community Centers",
    "Courthouses",
    "Departments of Motor Vehicles",
    "Embassy",
    "Fire Departments",
    "Jails & Prisons",
    "Landmarks & Historical Buildings",
    "Libraries",
    "Municipality",
    "Police Departments",
    "Post Offices",
    "Town Hall",
    "Real Estate",
    "Apartments",
    "Art Space Rentals",
    "Commercial Real Estate",
    "Condominiums",
    "Estate Liquidation",
    "Home Developers",
    "Home Staging",
    "Homeowner Association",
    "Housing Cooperatives",
    "Kitchen Incubators",
    "Mobile Home Dealers",
    "Mobile Home Parks",
    "Mortgage Brokers",
    "Property Management",
    "Real Estate Agents",
    "Apartment Agents",
    "Real Estate Services",
    "Land Surveying",
    "Real Estate Photography",
    "Shared Office Spaces",
    "University Housing",
    "Religious Organizations",
    "Buddhist Temples",
    "Churches",
    "Hindu Temples",
    "Mosques",
    "Sikh Temples",
    "Synagogues",
    "Restaurants",
    "Afghan",
    "African",
    "Senegalese",
    "South African",
    "American (New)",
    "American (Traditional)",
    "Arabian",
    "Argentine",
    "Armenian",
    "Asian Fusion",
    "Australian",
    "Austrian",
    "Bangladeshi",
    "Barbeque",
    "Basque",
    "Belgian",
    "Brasseries",
    "Brazilian",
    "Breakfast & Brunch",
    "British",
    "Buffets",
    "Bulgarian",
    "Burgers",
    "Burmese",
    "Cafes",
    "Themed Cafes",
    "Cafeteria",
    "Cajun/Creole",
    "Cambodian",
    "Caribbean",
    "Dominican",
    "Haitian",
    "Puerto Rican",
    "Trinidadian",
    "Catalan",
    "Cheesesteaks",
    "Chicken Shop",
    "Chicken Wings",
    "Chinese",
    "Cantonese",
    "Dim Sum",
    "Hainan",
    "Shanghainese",
    "Szechuan",
    "Comfort Food",
    "Creperies",
    "Cuban",
    "Czech",
    "Delis",
    "Diners",
    "Dinner Theater",
    "Ethiopian",
    "Fast Food",
    "Filipino",
    "Fish & Chips",
    "Fondue",
    "Food Court",
    "Food Stands",
    "French",
    "Mauritius",
    "Reunion",
    "Game Meat",
    "Gastropubs",
    "Georgian",
    "German",
    "Gluten-Free",
    "Greek",
    "Guamanian",
    "Halal",
    "Hawaiian",
    "Himalayan/Nepalese",
    "Honduran",
    "Hong Kong Style Cafe",
    "Hot Dogs",
    "Hot Pot",
    "Hungarian",
    "Iberian",
    "Indian",
    "Indonesian",
    "Irish",
    "Italian",
    "Calabrian",
    "Sardinian",
    "Sicilian",
    "Tuscan",
    "Japanese",
    "Conveyor Belt Sushi",
    "Izakaya",
    "Japanese Curry",
    "Ramen",
    "Teppanyaki",
    "Kebab",
    "Korean",
    "Kosher",
    "Laotian",
    "Latin American",
    "Colombian",
    "Salvadoran",
    "Venezuelan",
    "Live/Raw Food",
    "Malaysian",
    "Mediterranean",
    "Falafel",
    "Mexican",
    "Tacos",
    "Middle Eastern",
    "Egyptian",
    "Lebanese",
    "Modern European",
    "Mongolian",
    "Moroccan",
    "New Mexican Cuisine",
    "Nicaraguan",
    "Noodles",
    "Pakistani",
    "Pan Asian",
    "Persian/Iranian",
    "Peruvian",
    "Pizza",
    "Polish",
    "Polynesian",
    "Pop-Up Restaurants",
    "Portuguese",
    "Poutineries",
    "Russian",
    "Salad",
    "Sandwiches",
    "Scandinavian",
    "Scottish",
    "Seafood",
    "Singaporean",
    "Slovakian",
    "Soul Food",
    "Soup",
    "Southern",
    "Spanish",
    "Sri Lankan",
    "Steakhouses",
    "Supper Clubs",
    "Sushi Bars",
    "Syrian",
    "Taiwanese",
    "Tapas Bars",
    "Tapas/Small Plates",
    "Tex-Mex (te",
    "Thai",
    "Turkish",
    "Ukrainian",
    "Uzbek",
    "Vegan",
    "Vegetarian",
    "Vietnamese",
    "Waffles",
    "Wraps",
    "Shopping",
    "Adult",
    "Antiques",
    "Art Galleries",
    "Arts & Crafts",
    "Art Supplies",
    "Cards & Stationery",
    "Cooking Classes",
    "Costumes",
    "Embroidery & Crochet",
    "Fabric Stores",
    "Framing",
    "Paint-Your-Own Pottery",
    "Auction Houses",
    "Baby Gear & Furniture",
    "Battery Stores",
    "Bespoke Clothing",
    "Books, Mags, Music & Video",
    "Bookstores",
    "Comic Books",
    "Music & DVDs",
    "Newspapers & Magazines",
    "Video Game Stores",
    "Videos & Video Game Rental",
    "Vinyl Records",
    "Brewing Supplies",
    "Bridal",
    "Cannabis Dispensaries",
    "Computers",
    "Cosmetics & Beauty Supply",
    "Customized Merchandise",
    "Department Stores",
    "Discount Store",
    "Drones",
    "Drugstores",
    "Duty-Free Shops",
    "Electronics",
    "Eyewear & Opticians",
    "Sunglasses",
    "Farming Equipment",
    "Fashion",
    "Accessories",
    "Ceremonial Clothing",
    "Children's Clothing",
    "Clothing Rental",
    "Department Stores",
    "Formal Wear",
    "Fur Clothing",
    "Hats",
    "Leather Goods",
    "Lingerie",
    "Maternity Wear",
    "Men's Clothing",
    "Plus Size Fashion",
    "Shoe Stores",
    "Sports Wear",
    "Dance Wear",
    "Surf Shop",
    "Swimwear",
    "Traditional Clothing",
    "Used, Vintage & Consignment",
    "Women's Clothing",
    "Fireworks",
    "Fitness/Exercise Equipment",
    "Flea Markets",
    "Flowers & Gifts",
    "Cards & Stationery",
    "Florists",
    "Gift Shops",
    "Gemstones & Minerals",
    "Gold Buyers",
    "Guns & Ammo",
    "Head Shops",
    "High Fidelity Audio Equipment",
    "Hobby Shops",
    "Home & Garden",
    "Appliances",
    "Candle Stores",
    "Christmas Trees",
    "Furniture Stores",
    "Grilling Equipment",
    "Hardware Stores",
    "Holiday Decorations",
    "Home Decor",
    "Hot Tub & Pool",
    "Kitchen & Bath",
    "Kitchen Supplies",
    "Lighting Stores",
    "Mattresses",
    "Nurseries & Gardening",
    "Hydroponics",
    "Outdoor Furniture Stores",
    "Paint Stores",
    "Playsets",
    "Pumpkin Patches",
    "Rugs",
    "Tableware",
    "Horse Equipment Shops",
    "Jewelry",
    "Knitting Supplies",
    "Livestock Feed & Supply",
    "Luggage",
    "Medical Supplies",
    "Military Surplus",
    "Mobile Phone Accessories",
    "Mobile Phones",
    "Motorcycle Gear",
    "Musical Instruments & Teachers",
    "Office Equipment",
    "Outlet Stores",
    "Packing Supplies",
    "Pawn Shops",
    "Perfume",
    "Personal Shopping",
    "Photography Stores & Services",
    "Pool & Billiards",
    "Pop-up Shops",
    "Props",
    "Public Markets",
    "Religious Items",
    "Safe Stores",
    "Safety Equipment",
    "Shopping Centers",
    "Souvenir Shops",
    "Spiritual Shop",
    "Sporting Goods",
    "Bikes",
    "Dive Shops",
    "Golf Equipment",
    "Hockey Equipment",
    "Hunting & Fishing Supplies",
    "Outdoor Gear",
    "Skate Shops",
    "Ski & Snowboard Shops",
    "Sports Wear",
    "Dance Wear",
    "Tabletop Games",
    "Teacher Supplies",
    "Thrift Stores",
    "Tobacco Shops",
    "Toy Stores",
    "Trophy Shops",
    "Uniforms",
    "Used Bookstore",
    "Vape Shops",
    "Vitamins & Supplements",
    "Watches",
    "Wholesale Stores",
    "Wigs",
  ].freeze
end
