local wbjName, WBJ = ...;
local L = WBJ.L;

local fishing_buff = 131474;
local fishing_spellid = 131490;
local HiddenFishGoggles= 167698;
local UnderlightAngler = 133755;
local HyperCompressedOcean = { id = 168016, spell = 295044 };


local fishingText = {"Angler", "Bobber", "Fisherman", "Fishing", "Fishmonger", "Kalu'ak", "Nat Pagle"}
WBJ.FishyText = fishingText;

local wearableFishing = {
    ["10 Pound Mud Snapper"] = true,
    ["12 Pound Mud Snapper"] = true,
    ["15 Pound Mud Snapper"] = true,
    ["15 Pound Salmon"] = true,
    ["17 Pound Catfish"] = true,
    ["18 Pound Salmon"] = true,
    ["19 Pound Catfish"] = true,
    ["22 Pound Catfish"] = true,
    ["22 Pound Salmon"] = true,
    ["25 Pound Salmon"] = true,
    ["26 Pound Catfish"] = true,
    ["29 Pound Salmon"] = true,
    ["32 Pound Catfish"] = true,
    ["32 Pound Salmon"] = true,
    ["34 Pound Redgill"] = true,
    ["37 Pound Redgill"] = true,
    ["42 Pound Redgill"] = true,
    ["45 Pound Redgill"] = true,
    ["49 Pound Redgill"] = true,
    ["52 Pound Redgill"] = true,
    ["70 Pound Mightfish"] = true,
    ["85 Pound Mightfish"] = true,
    ["92 Pound Mightfish"] = true,
    ["103 Pound Mightfish"] = true,
    ["Admiral Taylor's Loyalty Ring"] = true,
    ["Anglin' Art's Sandals"] = true,
    ["Antique Silver Cufflinks"] = true,
    ["Bloodied Prison Shank"] = true,
    ["Boots of the Bay"] = true,
    ["Broken Wine Bottle"] = true,
    ["Captain Sander's Returned Band"] = true,
    ["Crafty's Pole"] = true,
    ["Dark Herring"] = true,
    ["Diamond-Tipped Cane"] = true,
    ["Dread Pirate Ring"] = true,
    ["Dustbringer"] = true,
    ["Enormous Barbed Gill Trout"] = true,
    ["Feralas Ahi"] = true,
    ["Fish Gutter"] = true,
    ["Fish-Eye Poker"] = true,
    ["Fishy Cinch"] = true,
    ["Fishmonger's Blade"] = true,
    ["Forgotten Necklace"] = true,
    ["Gold Wedding Band"] = true,
    ["Hightfish Cap"] = true,
    ["Huge Spotted Feltail"] = true,
    ["Lost Ring"] = true,
    ["Nat's Drinking Hat"] = true,
    ["Nat's Hat"] = true,
    ["Noble's Monocle"] = true,
    ["Old Crafty"] = true,
    ["Old Ironjaw"] = true,
    ["Ornate Drinking Stein"] = true,
    ["Razor Sharp Fillet Knife"] = true,
    ["Rockhide Strongfish"] = true,
    ["Sharpened Tuskarr Spear"] = true,
    ["Signet of the Third Fleet"] = true,
    ["Steelscale Crushfish"] = true,
    ["Stendel's Bane"] = true,
    ["Stendel's Wedding Band"] = true,
    ["Tentacled Hat"] = true,
    ["The 1 Ring"] = true,
    ["The 2 Ring"] = true,
    ["The 5 Ring"] = true
}
WBJ.Wearables = wearableFishing;

local fishables = {
    ["10 Pound Mud Snapper"] = true,
    ["12 Pound Mud Snapper"] = true,
    ["15 Pound Mud Snapper"] = true,
    ["15 Pound Salmon"] = true,
    ["17 Pound Catfish"] = true,
    ["18 Pound Salmon"] = true,
    ["19 Pound Catfish"] = true,
    ["22 Pound Catfish"] = true,
    ["22 Pound Salmon"] = true,
    ["25 Pound Salmon"] = true,
    ["26 Pound Catfish"] = true,
    ["29 Pound Salmon"] = true,
    ["32 Pound Catfish"] = true,
    ["32 Pound Salmon"] = true,
    ["34 Pound Redgill"] = true,
    ["37 Pound Redgill"] = true,
    ["42 Pound Redgill"] = true,
    ["45 Pound Redgill"] = true,
    ["49 Pound Redgill"] = true,
    ["52 Pound Redgill"] = true,
    ["70 Pound Mightfish"] = true,
    ["85 Pound Mightfish"] = true,
    ["92 Pound Mightfish"] = true,
    ["103 Pound Mightfish"] = true,
    ["Admiral Taylor's Loyalty Ring"] = true,
    ["Anglin' Art's Sandals"] = true,
    ["Antique Silver Cufflinks"] = true,
    ["Bloodied Prison Shank"] = true,
    ["Boots of the Bay"] = true,
    ["Broken Wine Bottle"] = true,
    ["Captain Sander's Returned Band"] = true,
    ["Crafty's Pole"] = true,
    ["Dark Herring"] = true,
    ["Dread Pirate Ring"] = true,
    ["Dustbringer"] = true,
    ["Enormous Barbed Gill Trout"] = true,
    ["Feralas Ahi"] = true,
    ["Fish Gutter"] = true,
    ["Fish-Eye Poker"] = true,
    ["Fishy Cinch"] = true,
    ["Fishmonger's Blade"] = true,
    ["Forgotten Necklace"] = true,
    ["Gold Wedding Band"] = true,
    ["Hightfish Cap"] = true,
    ["Huge Spotted Feltail"] = true,
    ["Lost Ring"] = true,
    ["Nat's Drinking Hat"] = true,
    ["Nat's Hat"] = true,
    ["Noble's Monocle"] = true,
    ["Old Crafty"] = true,
    ["Old Ironjaw"] = true,
    ["Ornate Drinking Stein"] = true,
    ["Razor Sharp Fillet Knife"] = true,
    ["Rockhide Strongfish"] = true,
    ["Sharpened Tuskarr Spear"] = true,
    ["Signet of the Third Fleet"] = true,
    ["Steelscale Crushfish"] = true,
    ["Stendel's Bane"] = true,
    ["Stendel's Wedding Band"] = true,
    ["Tentacled Hat"] = true,
    ["The 1 Ring"] = true,
    ["The 2 Ring"] = true,
    ["The 5 Ring"] = true,
    ["7 Pound Lobster"] = true,
    ["9 Pound Lobster"] = true,
    ["12 Pound Lobster"] = true,
    ["15 Pound Lobster"] = true,
    ["19 Pound Lobster"] = true,
    ["21 Pound Lobster"] = true,
    ["22 Pound Lobster"] = true,
    ["40 Pound Grouper"] = true,
    ["47 Pound Grouper"] = true,
    ["53 Pound Grouper"] = true,
    ["59 Pound Grouper"] = true,
    ["68 Pound Grouper"] = true,
    ["Abyssal Gulper Eel Bait"] = true,
    ["Abyssal Gulper Eel Egg"] = true,
    ["Abyssal Gulper Lunker"] = true,
    ["Alchemical Bonding Agent"] = true,
    ["Alliance Decoy Kit"] = true,
    ["Amorous Mud Snapper"] = true,
    ["Ancient Black Barracuda"] = true,
    ["Ancient Highmountain Salmon"] = true,
    ["Ancient Mossgill"] = true,
    ["Ancient Shark Jaws"] = true,
    ["Ancient Totem Fragment"] = true,
    ["Ancient Vrykul Ring"] = true,
    ["Anduin Wrynn's Gold Coin"] = true,
    ["Anglin' Art's Bag o' Fish"] = true,
    ["Anglin' Art's Mudfish Bait"] = true,
    ["Anuniaq's Net"] = true,
    ["Aqua Jewel"] = true,
    ["Aquadynamic Fish Attractor"] = true,
    ["Aquadynamic Fish Lens"] = true,
    ["Arcane Lure"] = true,
    ["Arcane Trout"] = true,
    ["Archimonde's Gold Coin"] = true,
    ["Arctic Char"] = true,
    ["Armored Carp"] = true,
    ["Aromatic Murloc Slime"] = true,
    ["Arthas' Gold Coin"] = true,
    ["Arugal's Gold Coin"] = true,
    ["Auripagic Sardine"] = true,
    ["Awesomefish"] = true,
    ["Axefish"] = true,
    ["Axefish Lure"] = true,
    ["Azshara Snakehead"] = true,
    ["Baby Crocolisk"] = true,
    ["Baby Octopus"] = true,
    ["Bag of Clams"] = true,
    ["Bag of Shiny Things"] = true,
    ["Bait-o-Matic Blueprints"] = true,
    ["Barrel of Fish"] = true,
    ["Barrel of Fish Oil"] = true,
    ["Battered Chest"] = true,
    ["Battered Jungle Hat"] = true,
    ["Beloved Ring"] = true,
    ["Bipsi's Bobbing Berg"] = true,
    ["Blackfin Darter"] = true,
    ["Blackwater Whiptail Bait"] = true,
    ["Blackwater Whiptail Egg"] = true,
    ["Blackwater Whiptail Lunker"] = true,
    ["Blacktip Shark"] = true,
    ["Bladebone Hook"] = true,
    ["Blank Slate"] = true,
    ["Blind Cavefish"] = true,
    ["Blind Lake Sturgeon Bait"] = true,
    ["Blind Lake Sturgeon Egg"] = true,
    ["Blind Lake Sturgeon Lunker"] = true,
    ["Blind Minnow"] = true,
    ["Bloated Albacore"] = true,
    ["Bloated Barbed Gill Trout"] = true,
    ["Bloated Catfish"] = true,
    ["Bloated Frog"] = true,
    ["Bloated Giant Sunfish"] = true,
    ["Bloated Mackerel"] = true,
    ["Bloated Mud Snapper"] = true,
    ["Bloated Slippery Eel"] = true,
    ["Bloated Smallfish"] = true,
    ["Bloated Redgill"] = true,
    ["Bloated Rockscale Cod"] = true,
    ["Bloated Salmon"] = true,
    ["Bloated Thresher"] = true,
    ["Bloated Trout"] = true,
    ["Bloodtooth Frenzy"] = true,
    ["Blorp's Bubble"] = true,
    ["Bold Stormjewel"] = true,
    ["Brann Bronzebeard's Gold Coin"] = true,
    ["Bright Baubles"] = true,
    ["Brilliant Stormjewel"] = true,
    ["Brinedeep Bottom-Feeder"] = true,
    ["Broken Whale Statue"] = true,
    ["Brownell's Blue Striped Racer"] = true,
    ["Captain Rumsey's Lager"] = true,
    ["Carved Wooden Helm"] = true,
    ["Chipped Hair Brush"] = true,
    ["Chromie's Gold Coin"] = true,
    ["Chuck's Bucket"] = true,
    ["Coldriver Carp"] = true,
    ["Corpse Worm"] = true,
    ["Corpse-Fed Pike"] = true,
    ["Corroded Jewelry"] = true,
    ["Corrupted Globule"] = true,
    ["Crafted Star"] = true,
    ["Crispy Dojani Eel"] = true,
    ["Crystal Bass"] = true,
    ["Curious Crate"] = true,
    ["Cuttlefish Scale Breastplate"] = true,
    ["Cuttlefish Tooth Ringmail"] = true,
    ["Damp Diary Page (Day 4)"] = true,
    ["Damp Diary Page (Day 87)"] = true,
    ["Damp Diary Page (Day 512)"] = true,
    ["Darkmoon Firewater"] = true,
    ["Darkmoon Healing Tonic"] = true,
    ["Darkwater Potion"] = true,
    ["Day-Old Darkmoon Doughnut"] = true,
    ["Dazzling Sapphire Pendant"] = true,
    ["Decayed Treasure Map"] = true,
    ["Decayed Whale Blubber"] = true,
    ["Defender's Shadow Crystal"] = true,
    ["Delicate Stormjewel"] = true,
    ["Demon Noggin"] = true,
    ["Demonic Detritus"] = true,
    ["Dented Crate"] = true,
    ["Desecrated Seaweed"] = true,
    ["Design: Defender's Shadow Crystal"] = true,
    ["Design: Purified Shadow Crystal"] = true,
    ["Dezian Queenfish"] = true,
    ["Diamond-Tipped Cane"] = true,
    ["Digsong's Fish and Tips"] = true,
    ["Disgusting Ooze"] = true,
    ["Dog's Whistle"] = true,
    ["Dojani Eel"] = true,
    ["Draenic Water Walking Elixir"] = true,
    ["Drowned Mana"] = true,
    ["Drowned Thistleleaf"] = true,
    ["Drowned Thunder Lizard Tail"] = true,
    ["Elixir of Water Walking"] = true,
    ["Emblem of Margoss"] = true,
    ["Empty Snail Shell"] = true,
    ["Enchanted Lure"] = true,
    ["Eye of the Sea"] = true,
    ["Face of the Forest"] = true,
    ["Faded Treasure Map"] = true,
    ["Faintly Pulsing Felstone"] = true,
    ["Fat Sleeper Bait"] = true,
    ["Fat Sleeper Egg"] = true,
    ["Fat Sleeper Lunker"] = true,
    ["Feathered Lure"] = true,
    ["Felmouth Frenzy Bait"] = true,
    ["Fishliver Oil"] = true,
    ["Fire Ammonite Bait"] = true,
    ["Fire Ammonite Lunker"] = true,
    ["Fish Bladder"] = true,
    ["Fish Cleaver"] = true,
    ["Fish Hat"] = true,
    ["Fish Tales"] = true,
    ["Fishy"] = true,
    ["Flesh Eating Worm"] = true,
    ["Floating Totem"] = true,
    ["Flying Tiger Gourami"] = true,
    ["Fragmented Enchantment"] = true,
    ["\"Fragrant\" Pheromone Fish"] = true,
    ["Freshly-Speared Emperor Salmon"] = true,
    ["Frogsticker Spearhead"] = true,
    ["Frost Worm"] = true,
    ["Frostdeep Minnow"] = true,
    ["Funky Rotten Fish"] = true,
    ["Funky Sea Snail"] = true,
    ["Ghostly Queenfish"] = true,
    ["Giant Catfish"] = true,
    ["Giant Darkwater Clam"] = true,
    ["Giant Flesh-Eating Tadpole"] = true,
    ["Giant Freshwater Shrimp"] = true,
    ["Giant Furious Pike"] = true,
    ["Giant Sewer Rat"] = true,
    ["Gigantic Catfish"] = true,
    ["Globe of Really Sticky Glue"] = true,
    ["Glow Worm"] = true,
    ["Glowing Fish Scale"] = true,
    ["Gnomish Bait-o-Matic"] = true,
    ["Golden Minnow"] = true,
    ["Golden Stonefish"] = true,
    ["Graybelly Lobster"] = true,
    ["Great Sea Herring"] = true,
    ["Grieferfish"] = true,
    ["Grimnur's Bait"] = true,
    ["Gub's Catch"] = true,
    ["Hangman's Noose"] = true,
    ["Hardened Walleye"] = true,
    ["Hatecoil Spearhead"] = true,
    ["Heavy Crate"] = true,
    ["Heavy Supply Crate"] = true,
    ["Heat-Treated Spinning Lure"] = true,
    ["Hook Disgorger"] = true,
    ["Hypermagnetic Lure"] = true,
    ["Icespine Stinger"] = true,
    ["Icespine Stinger Bait"] = true,
    ["Iron Bound Trunk"] = true,
    ["Ironbound Locked Chest"] = true,
    ["Ivory-Reinforced Chestguard"] = true,
    ["Jagged Abalone Meat"] = true,
    ["Jawless Skulker Bait"] = true,
    ["Jawless Skulker Egg"] = true,
    ["Jawless Skulker Lunker"] = true,
    ["Kaldorei Herring"] = true,
    ["Kaskala Supplies"] = true,
    ["Keefer's Angelfish"] = true,
    ["Kel'Thuzad's Gold Coin"] = true,
    ["Krasarang Fritters"] = true,
    ["Lady Jaina Proudmoore's Gold Coin"] = true,
    ["Lady Katrana Prestor's Gold Coin"] = true,
    ["Land Shark"] = true,
    ["Leyshimmer Blenny"] = true,
    ["Luminous Bluetail"] = true,
    ["Luminous Pearl"] = true,
    ["Lunarfall Carp"] = true,
    ["Lure Master Tackle Box"] = true,
    ["Magic-Eater Frog"] = true,
    ["Magical Crawdad Box"] = true,
    ["Mark of Aquaos"] = true,
    ["Message in a Beer Bottle"] = true,
    ["Message in a Bottle"] = true,
    ["Micro-Vortex Generator"] = true,
    ["Midnight Salmon"] = true,
    ["Mimic Octopus"] = true,
    ["Mist-Hopper Emergency Buoy"] = true,
    ["Misty Reed Mahi Mahi"] = true,
    ["Mithril Bound Trunk"] = true,
    ["Moat Monster Feeding Kit"] = true,
    ["Molten Catfish"] = true,
    ["Monstrous Clam Meat"] = true,
    ["Monstrous Felblood Snapper"] = true,
    ["Moonshell Claw"] = true,
    ["Moonshell Claw Bait"] = true,
    ["Moosebone Fish-Hook"] = true,
    ["Mountain Puffer"] = true,
    ["Mr. Pinchy"] = true,
    ["Mr. Pinchy's Gift"] = true,
    ["Muckbreath's Bucket"] = true,
    ["Mudskunk Lure"] = true,
    ["Nar'thalas Hermit"] = true,
    ["Nat's Hookshot"] = true,
    ["Nat's Lucky Coin"] = true,
    ["Nat's Measuring Tape"] = true,
    ["New Age Painting"] = true,
    ["Nightcrawlers"] = true,
    ["Nightmare Nightcrawler"] = true,
    ["Nurtured Penguin Egg"] = true,
    ["Oil Covered Fish"] = true,
    ["Old \"Pirate\" Map"] = true,
    ["Old Teamster's Skull"] = true,
    ["Oodelfjisk"] = true,
    ["Overgrown Earthworm"] = true,
    ["Pagle's Fish Paste, Extra Strength"] = true,
    ["Pale Ghoulfish"] = true,
    ["Parasitic Starfish"] = true,
    ["Partially Eaten Fish"] = true,
    ["Pattern: Emerald Bag"] = true,
    ["Pattern: Trapper's Traveling Pack"] = true,
    ["Pearlescent Conch"] = true,
    ["Phantom Ghostfish"] = true,
    ["Pigment-Stained Robes"] = true,
    ["Plated Armorfish"] = true,
    ["Polished Skull"] = true,
    ["Porcelain Bell"] = true,
    ["Poshken's Ring"] = true,
    ["Precious Locket"] = true,
    ["Prickly Puffer Spine"] = true,
    ["Prince Kael'thas Sunstrider's Gold Coin"] = true,
    ["Pristine Crane Egg"] = true,
    ["Pristine Moosebone Fish-Hook"] = true,
    ["Pristine Shimmerscale Eel"] = true,
    ["Purified Shadow Crystal"] = true,
    ["Randy Smallfish"] = true,
    ["Rat Trap"] = true,
    ["Ravenous Fly"] = true,
    ["Razgar's Fillet Knife"] = true,
    ["Recipe: Broiled Bloodfin"] = true,
    ["Recipe: Captain Rumsey's Lager"] = true,
    ["Recipe: Fancy Darkmoon Feast"] = true,
    ["Recipe: Krasarang Fritters"] = true,
    ["Recipe: Lemon Herb Fillet"] = true,
    ["Recipe: Skullfish Soup"] = true,
    ["Recipe: Sugar-Crusted Fish Feast"] = true,
    ["Recipe: Viseclaw Soup"] = true,
    ["Red Snapper"] = true,
    ["Reinforced Crate"] = true,
    ["Reinforced Locked Chest"] = true,
    ["Reins of the Azure Water Strider"] = true,
    ["Reins of the Crimson Water Strider"] = true,
    ["Replica Gondola"] = true,
    ["Reptile Egg"] = true,
    ["Riding Turtle"] = true,
    ["Rigid Stormjewel"] = true,
    ["Rock Lobster"] = true,
    ["Rook's Lucky Fishin' Line"] = true,
    ["Rotten Fishbone"] = true,
    ["Royal Monkfish"] = true,
    ["Ruined Pattern"] = true,
    ["Rusty Prison Key"] = true,
    ["Rusty Queenfish Brooch"] = true,
    ["Rusty Shipwreck Debris"] = true,
    ["Sack of Starfish"] = true,
    ["Salmon Lure"] = true,
    ["Sandy Carp"] = true,
    ["Sar'theris Striker"] = true,
    ["Savage Coast Blue Sailfin"] = true,
    ["Sea Calf"] = true,
    ["Sea Scorpion Bait"] = true,
    ["Sea Pony"] = true,
    ["Sea Turtle"] = true,
    ["Seabottom Squid"] = true,
    ["Seafarer's Slidewhistle"] = true,
    ["Sealed Charter Tube"] = true,
    ["Sealed Crate"] = true,
    ["Sealed Darkmoon Crate"] = true,
    ["Sealed Vial of Poison"] = true,
    ["Seerspine Puffer"] = true,
    ["Severed Abomination Head"] = true,
    ["Severed Arm"] = true,
    ["Shadow Sturgeon"] = true,
    ["Sharpened Fish Hook"] = true,
    ["Shiny Bauble"] = true,
    ["Shiny Stone"] = true,
    ["Silas' Secret Stash"] = true,
    ["Silver Goby"] = true,
    ["Skrog Toenail"] = true,
    ["Sleeping Murloc"] = true,
    ["Slippery Eel"] = true,
    ["Small Chest"] = true,
    ["Small Locked Chest"] = true,
    ["Snapclaw's Claw"] = true,
    ["Snarly's Bucket"] = true,
    ["Snowfall Glade Pup"] = true,
    ["Solid Gold Coin"] = true,
    ["Solid Stormjewel"] = true,
    ["Sparkling Stormjewel"] = true,
    ["Speckled Tastyfish"] = true,
    ["Spinefish Alpha"] = true,
    ["Squirming Slime Mold"] = true,
    ["Stag Eye"] = true,
    ["Starfish on a String"] = true,
    ["Sting Ray Pup"] = true,
    ["Stinger"] = true,
    ["Stinky Fish Head"] = true,
    ["Stocking Up"] = true,
    ["Stolen Fish"] = true,
    ["Stonebull Crayfish"] = true,
    ["Strand Crawler"] = true,
    ["Strange Engine Part"] = true,
    ["String of Alligator Teeth"] = true,
    ["Stripped Drilling Gears"] = true,
    ["Stuffed Shark Head"] = true,
    ["Stunned, Angry Shark"] = true,
    ["Sturdy Locked Chest"] = true,
    ["Suncrawler"] = true,
    ["Swatch of Netting"] = true,
    ["Swollen Murloc Egg"] = true,
    ["Sylvanas Windrunner's Gold Coin"] = true,
    ["Tainted Runescale Koi"] = true,
    ["Tangled Bronze Hooks"] = true,
    ["Tasty Reef Fish"] = true,
    ["Teldrassil Clam"] = true,
    ["Teron's Gold Coin"] = true,
    ["Terrorfin"] = true,
    ["Terrorfish"] = true,
    ["The Sister's Pendant"] = true,
    ["Thorned Flounder"] = true,
    ["Thundering Stormray"] = true,
    ["Thrall's Gold Coin"] = true,
    ["Thresher Teeth"] = true,
    ["Throwing Starfish"] = true,
    ["Tightly Sealed Trunk"] = true,
    ["Tiny Blue Carp"] = true,
    ["Tiny Goldfish"] = true,
    ["Tiny Green Carp"] = true,
    ["Tiny Little Grabbing Apparatus"] = true,
    ["Tiny Red Carp"] = true,
    ["Tiny Titanium Lockbox"] = true,
    ["Tiny White Carp"] = true,
    ["Tirion Fordring's Gold Coin"] = true,
    ["Toothy's Bucket"] = true,
    ["Totemic Purification Rod"] = true,
    ["Tower Key"] = true,
    ["Toxic Puddlefish"] = true,
    ["Traditional Flensing Knife"] = true,
    ["Translucent Shell"] = true,
    ["Trapper's Traveling Pack"] = true,
    ["Trashy"] = true,
    ["Turtle-Minders Robe"] = true,
    ["Tyfish"] = true,
    ["Undelivered Love Letter"] = true,
    ["Unusual Compass"] = true,
    ["Uther Lightbringer's Gold Coin"] = true,
    ["Velociraptor Skull"] = true,
    ["Very Unlucky Rock"] = true,
    ["Vicious Ancient Fish"] = true,
    ["Violet Perch"] = true,
    ["Viseclaw Fisher Eye"] = true,
    ["Viseclaw Soup"] = true,
    ["Water Stone"] = true,
    ["Water Totem Figurine"] = true,
    ["Waterlogged Crate"] = true,
    ["Waterlogged Recipe"] = true,
    ["Watertight Trunk"] = true,
    ["Weather-Beaten Journal"] = true,
    ["Whale Statue"] = true,
    ["Whale-Skin Breastplate"] = true,
    ["Whale-Skin Vest"] = true,
    ["Whale-Stick Harpoon"] = true,
    ["Whalebone Carapace"] = true,
    ["White Sparkly Bauble"] = true,
    ["Wish Crystal"] = true,
    ["Wolf Piranha	"] = true,
    ["World's Largest Mudfish"] = true,
    ["Worm Supreme"] = true,
    ["Young Ironjaw"] = true,
    ["Zangar Eel"] = true,
    ["Zulian Mudskunk"] = true
}
WBJ.Fishables = fishables;

local fishingNPCs = {
    ["Adam"] = true,
    ["Akule Riverhorn"] = true,
    ["Ancient Vrykul Spirit"] = true,
    ["Art Hughie"] = true,
    ["Attracted Reef Bull"] = true,
    ["Austin Windmill"] = true,
    ["Azure Water Strider"] = true,
    ["Bart Tidewater"] = true,
    ["Benevolent Mr. Pinchy"] = true,
    ["Billy"] = true,
    ["Blorp"] = true,
    ["Blythe"] = true,
    ["Brandon"] = true,
    ["Bry Lang"] = true,
    ["Canal Crab"] = true,
    ["Christopher Sloan"] = true,
    ["Chuck"] = true,
    ["Colton Smith"] = true,
    ["Conjuror Margoss"] = true,
    ["Corbyn"] = true,
    ["Costumed Entertainer"] = true,
    ["Coxswain Hook"] = true,
    ["Crawler"] = true,
    ["Crayfish Catch Credit"] = true,
    ["Crimson Water Strider"] = true,
    ["Dankin Farsnipe"] = true,
    ["Dead Fish"] = true,
    ["Drogan Ironshaper"] = true,
    ["Elder Clearwater"] = true,
    ["Elder Kesmet"] = true,
    ["Emerald Bag"] = true,
    ["Enormous Globule"] = true,
    ["Eventide Villager"] = true,
    ["Fenwick Thatros"] = true,
    ["Fish Felreed"] = true,
    ["Fishbot 5000"] = true,
    ["Fishy"] = true,
    ["Frenzied Reef Shark"] = true,
    ["Frostdeep Cavedweller"] = true,
    ["Furious Mr. Pinchy"] = true,
    ["Ghostshell Crab"] = true,
    ["Giant Sewer Rat"] = true,
    ["Gogo"] = true,
    ["Golden Stonefish"] = true,
    ["Gorkas"] = true,
    ["Grant"] = true,
    ["Gubb"] = true,
    ["Hal McAllister"] = true,
    ["Half-Eaten Fish"] = true,
    ["Harklane"] = true,
    ["High Admiral \"Shelly\" Jorrik"] = true,
    ["Harold"] = true,
    ["Hatecoil Spirit"] = true,
    ["Hungry Tuskarr"] = true,
    ["Ilyssia of the Waters"] = true,
    ["Impus"] = true,
    ["Islen Waterseer"] = true,
    ["Ivan Walkers"] = true,
    ["Jacob Anders"] = true,
    ["Jamin"] = true,
    ["Jang"] = true,
    ["Jeigh Southie"] = true,
    ["Jeorge Swiftbrook"] = true,
    ["Jinar'Zillen"] = true,
    ["Jock Lindsey"] = true,
    ["Jorgen"] = true,
    ["Justin"] = true,
    ["Kalo"] = true,
    ["Keeper Raynae"] = true,
    ["Kill Credit: Fishery"] = true,
    ["Killian Sanatha"] = true,
    ["Klixx"] = true,
    ["Kriggon Talsone"] = true,
    ["Kubb"] = true,
    ["Laird"] = true,
    ["Land Shark"] = true,
    ["Landlocked Shark"] = true,
    ["Leviathan Weak Point A"] = true,
    ["Leviathan Weak Point B"] = true,
    ["Leviathan Weak Point C"] = true,
    ["Leviathan Weak Point D"] = true,
    ["Lunarfall Cavedweller"] = true,
    ["Madari"] = true,
    ["Magical Crawdad"] = true,
    ["Magicus"] = true,
    ["Mahren Skyseer"] = true,
    ["Maiden's Virtue crewman"] = true,
    ["Marri"] = true,
    ["Master Gunner Line"] = true,
    ["Master Lo"] = true,
    ["Matheis"] = true,
    ["Matt"] = true,
    ["Mglrrp"] = true,
    ["Moat Monster"] = true,
    ["Mokugg Lagerpounder"] = true,
    ["Muckbreath"] = true,
    ["Nandaez"] = true,
    ["Narjon the Gulper"] = true,
    ["Nida"] = true,
    ["Pengu"] = true,
    ["Pierre Fishflay"] = true,
    ["Potion of Mazu's Breath"] = true,
    ["Prickly Puffer"] = true,
    ["Rai"] = true,
    ["Razgar"] = true,
    ["Red Jack Flint"] = true,
    ["Reef Bull"] = true,
    ["Reef Cow"] = true,
    ["Riggle Bassbait"] = true,
    ["Roger"] = true,
    ["Rok'kal"] = true,
    ["Roman"] = true,
    ["Rotten Fishbone"] = true,
    ["School of Fish"] = true,
    ["Sea Calf"] = true,
    ["Sea Pony"] = true,
    ["Sea Turtle"] = true,
    ["Sebastian Bower"] = true,
    ["Seehmo"] = true,
    ["Seth"] = true,
    ["Sha'leth"] = true,
    ["Shadowy Fish"] = true,
    ["Shawn"] = true,
    ["\"Sinker\""] = true,
    ["Snarly"] = true,
    ["Snowfall Glade Pup"] = true,
    ["Stephanie Sindree"] = true,
    ["Sting Ray"] = true,
    ["Strand Crawler"] = true,
    ["Summon Tuskarr Spear"] = true,
    ["Surly Fishflayer"] = true,
    ["Swift"] = true,
    ["Talaelar"] = true,
    ["Tanji the Fisher"] = true,
    ["Tarn Riverhorn"] = true,
    ["Teleportologist Fozlebub"] = true,
    ["Tharis Strongcast"] = true,
    ["The Talking Fish"] = true,
    ["Thelia Garron"] = true,
    ["Thorina"] = true,
    ["Thresher Deckhand"] = true,
    ["Tiny Blue Carp"] = true,
    ["Tiny Goldfish"] = true,
    ["Tiny Green Carp"] = true,
    ["Tiny Red Carp"] = true,
    ["Tiny White Carp"] = true,
    ["Toothy"] = true,
    ["Torgo the Younger"] = true,
    ["Trashy"] = true,
    ["Treasure Hunter"] = true,
    ["Unlucky Fish"] = true,
    ["Wavesinger Zara"] = true,
    ["Wigcik"] = true,
    ["Witherbark Fisher"] = true,
    ["Young Ironjaw Credit"] = true,
    ["Zem Leeward"] = true
}
WBJ.KnownNpcs = fishingNPCs;

local fishingSpells = {
    ["8087"] = true, -- Shiny Bauble
    ["8088"] = true, -- Nightcrawlers
    ["8089"] = true, -- Aquadynamic Fish Attractor
    ["8090"] = true, -- Bright Baubles
    ["8532"] = true, -- Aquadynamic Fish Lens
    ["9092"] = true, -- Flesh Eating Worm
    ["11319"] = true, -- Water Walking
    ["30174"] = true, -- Riding Turtle (Summon Mount)
    ["33050"] = true, -- Magical Crawdad (Summon Pet)
    ["33064"] = true, -- Mr. Pinchy's Gift
    ["43308"] = true, -- Find Fish
    ["43761"] = true, -- Broiled Bloodfin
    ["43697"] = true, -- Toothy (Summon Pet)
    ["43698"] = true, -- Muckbreath (Summon Pet)
    ["44454"] = true, -- Tasty Reef Fish
    ["45694"] = true, -- Captain Rumsey's Lager
    ["45695"] = true, -- Captain Rumsey's Lager
    ["45731"] = true, -- Sharpened Fish Hook
    ["46425"] = true, -- Snarly (Summon Pet)
    ["46426"] = true, -- Chuck (Summon Pet)
    ["48794"] = true, -- Cast Net
    ["50970"] = true, -- Trapper's Traveling Pack
    ["53869"] = true, -- Defender's Shadow Crystal
    ["53921"] = true, -- Purified Shadow Crystal
    ["59125"] = true, -- Lucky
    ["59250"] = true, -- Giant Sewer Rat
    ["59645"] = true, -- Underbelly Elixir
    ["60871"] = true, -- Fireblast
    ["61357"] = true, -- Pengu (Summon Pet)
    ["62410"] = true, -- Elixir of Water Walking
    ["62561"] = true, -- Strand Crawler (Summon Pet)
    ["63924"] = true, -- Emerald Bag
    ["64385"] = true, -- Spinning (Unusual Compass)
    ["64401"] = true, -- Glow Worm
    ["64731"] = true, -- Sea Turtle (Summon Mount)
    ["80610"] = true, -- Water Gliding
    ["80832"] = true, -- Viseclaw Fisher Eye
    ["80868"] = true, -- Stag Eye Bait
    ["87646"] = true, -- Feathered Lure
    ["93395"] = true, -- Water Walking
    ["95244"] = true, -- Heat-Treated Spinning Lure
    ["99315"] = true, -- Corpse Worm Bait
    ["99328"] = true, -- Time for Slime: Create Slime Mold
    ["99334"] = true, -- Fillet Giant Catfish
    ["99339"] = true, -- Pickup Baby Octopus
    ["99340"] = true, -- Pickup Baby Octopus
    ["99424"] = true, -- Crayfish Catch
    ["99429"] = true, -- Display Young Ironjaw
    ["99431"] = true, -- Feed Squirky
    ["99435"] = true, -- Grimnur's Bait
    ["99451"] = true, -- Cancel Crayfish Catch
    ["99473"] = true, -- Craving Crayfish: Create Stonebull Crayfish
    ["99474"] = true, -- Create Gnomish Bait-o-Matic
    ["99508"] = true, -- Throw Frog
    ["99511"] = true, -- Simulate Alliance Presence
    ["99524"] = true, -- [DND] Give Frog
    ["99525"] = true, -- [DND] Give Decoy Kit
    ["101498"] = true, -- Throwing Starfish
    ["101500"] = true, -- Create Throwing Starfish
    ["103588"] = true, -- Darkwater Potion
    ["105707"] = true, -- Darkwater Potion
    ["109244"] = true, -- Back to the Cannon!
    ["115369"] = true, -- Spear Fish
    ["118089"] = true, -- Azure Water Strider (Summon Mount)
    ["122748"] = true, -- Fishy (Summon Pet)
    ["123803"] = true, -- Fed
    ["124000"] = true, -- Tiny Goldfish (Summon Pet)
    ["124029"] = true, -- Viseclaw Soup
    ["124032"] = true, -- Krasarang Fritters
    ["124657"] = true, -- Potion of Mazu's Breath
    ["124927"] = true, -- Call Dog
    ["124960"] = true, -- Mist-Hopper Emergency Buoy
    ["127271"] = true, -- Crimson Water Strider (Summon Mount)
    ["127285"] = true, -- Shimmering Water
    ["128357"] = true, -- Sharpened Tuskarr Spear
    ["139361"] = true, -- Tiny Red Carp (Summon Pet)
    ["139362"] = true, -- Tiny Blue Carp (Summon Pet)
    ["139363"] = true, -- Tiny Green Carp (Summon Pet)
    ["139365"] = true, -- Tiny White Carp (Summon Pet)
    ["152421"] = true, -- Bipsi's Bobbing Berg
    ["158031"] = true, -- Jawless Skulker Bait
    ["158034"] = true, -- Fat Sleeper Bait
    ["158035"] = true, -- Blind Lake Sturgeon Bait
    ["158036"] = true, -- Fire Ammonite Bait
    ["158037"] = true, -- Sea Scorpion Bait
    ["158038"] = true, -- Abyssal Gulper Eel Bait
    ["158039"] = true, -- Blackwater Whiptail Bait
    ["158693"] = true, -- Fish Pheromones
    ["168448"] = true, -- Icespine Stinger Bait
    ["168868"] = true, -- Moonshell Claw Bait
    ["168977"] = true, -- Sea Calf (Summon Pet)
    ["171740"] = true, -- Nat's Hookshot Bait
    ["171741"] = true, -- Cancel Hookshot Bait Aura
    ["172694"] = true, -- Reading
    ["172695"] = true, -- Land Shark (Summon Pet)
    ["174471"] = true, -- Worm Supreme
    ["174524"] = true, -- Awesome!
    ["174528"] = true, -- Griefer
    ["174841"] = true, -- Thank you!
    ["175841"] = true, -- Draenic Water Walking
    ["182226"] = true, -- Bladebone Hook
    ["185490"] = true, -- Darkmoon Healing Tonic
    ["185587"] = true, -- Day-Old Darkmoon Doughnut
    ["185591"] = true, -- Ghostshell Crab (Summon Pet)
    ["185601"] = true, -- Blorp (Summon Pet)
    ["185712"] = true, -- Seafarer's Slidewhistle
    ["188512"] = true, -- Fel Lash
    ["188904"] = true, -- Felmouth Frenzy Bait
    ["201808"] = true, -- Rotten Fishbone
    ["201824"] = true, -- Stunned, Angry Shark
    ["202082"] = true, -- Rotten Fishbone
    ["221477"] = true, -- Underlight
    ["239673"] = true, -- Something's Fishy
    ["240801"] = true, -- Demon Noggin
    ["240802"] = true, -- Floating Totem
    ["240803"] = true, -- Carved Wooden Helm
    ["240804"] = true, -- Replica Gondola
    ["240806"] = true -- Face of the Forest
}
WBJ.FishingSpells = fishingSpells;

-- Information for the stylin' fisherman
local fishingPoles = {
    ["Fishing Pole"] = "6256:0:0:0",
    ["Strong Fishing Pole"] = "6365:0:0:0",
    ["Darkwood Fishing Pole"] = "6366:0:0:0",
    ["Big Iron Fishing Pole"] = "6367:0:0:0",
    ["Blump Family Fishing Pole"] = "12225:0:0:0",
    ["Nat Pagle's Extreme Angler FC-5000"] = "19022:0:0:0",
    ["Arcanite Fishing Pole"] = "19970:0:0:0",
    ["Seth's Graphite Fishing Pole"] = "25978:0:0:0",
    ["Nat's Lucky Fishing Pole"] = "45858:0:0:0",
    ["Mastercraft Kalu'ak Fishing Pole"] = "44050:0:0:0",
    ["Bone Fishing Pole"] = "45991:0:0:0",
    ["Jeweled Fishing Pole"] = "45992:0:0:0",
    ["Staats' Fishing Pole"] = "46337:0:0:0",
    ["Pandaren Fishing Pole"] = "84660:0:0:0",
    ["Dragon Fishing Pole"] = "84661:0:0:0",
    ["Ephemeral Fishing Pole"] = "118381:0:0:0",
    ["Savage Fishing Pole"] = "116825:0:0:0",
    ["Draenic Fishing Pole"] = "116826:0:0:0", --, isLure = true 
    ["Underlight Angler"] = "133755:0:0:0",
    ["Dwarven Fishing Pole"] = "3567:0:0:0",
    ["Goblin Fishing Pole"] = "4598:0:0:0",
    ["Nat Pagle's Fish Terminator"] = "19944:0:0:0",
    ["Thruk's Heavy Duty Fishing Pole"] = "120164:0:0:0",
    ["Crafty's Pole"] = "43651:0:0:0"
}
WBJ.Poles = fishingPoles

local poolsAndSchools = {
	13422,			-- Stonescale Eel Swarm
	74857,			-- Giant Mantis Shrimp Swarm
	74864,			-- Reef Octopus Swarm
	6359,			-- Firefin Snapper School
	6358,			-- Oily Blackmouth School
	21153,			-- Greater Sagefish School
	21071,			-- Sagefish School
    6522,			-- School of Deviate Fish
	41805,			-- Borean Man O' War School
	41800,			-- Deep Sea Monster Belly School
	41807,			-- Dragonfin Angelfish School
	41810,			-- Fangtooth Herring School
	41809,			-- Glacial Salmo School
	41814,			-- Glassfin Minnow School
	41802,			-- Imperial Manta Ray School
	41801,			-- Moonglow Cuttlefish School
	41806,			-- Musselback Sculpin School
	41813,			-- Nettlefish School
	53065,			-- Albino Cavefish School
	53066,			-- Blackbelly Mudfish School
	53072,			-- Deepsea Sagefish School
	53070,			-- Fathom Eel School
	53064,			-- Highland Guppy School
	53063,			-- Mountain Trout School
	52325,			-- Volatile Fire (this won't actually work)
	74856,			-- Jade Lungfish School
	74859,			-- Emperor Salmon School
	74860,			-- Redbelly Mandarin School
	74861,			-- Tiger Gourami School
	74863,			-- Jewel Danio School
	74865,			-- Krasarang Paddlefish School
	83064,			-- Spine Fish School
};
WBJ.PoolsAndSchools = poolsAndSchools;

local FishingItems = { 
    -- Hooks and Charms
    [85973]  = { ["enUS"] = "Ancient Pandaren Fishing Charm", skillId = 125167 },
    [122742] = { ["enUS"] = "Bladebone Hook", skillId = 182226, },
    [116755] = { ["enUS"] = "Nat's Hookshot", skillId = 171740, },
    [88535]  = { ["enUS"] = "Sharpened Tuskarr Spear", skillId = 128357},
    [165699] = { ["enUS"] = "Scarlet Herring Lure", skillId= 285895 },
    [152556] = { ["enUS"] = "Trawler Totem", skillId = 251211},
    
    -- Rafts
    [85500]  = { ["enUS"] = "Angler's Fishing Raft", skillId = 124036, isRaft = true },
    [107950] = { ["enUS"] = "Bipsi's Bobbing Berg", skillId = 152421, isRaft = true },
    [166461] = { ["enUS"] = "Gnarlwood Waveboard", skillId = 288758, isRaft = true},
  
    -- Dreanar hats
    [118393] = { ["enUS"] = "Tentacled Hat", skillId = 174479, isWearable = true, isLure = true }, 
    [118380] = { ["enUS"] = "HightFish Cap", skillId = 118380, isWearable = true, isLure = true },

    -- Nat's Hats
    [88710]  = { ["enUS"] = "Nat's Hat", skillId = 7823, isWearable = true, isLure = true	},
	[117405] = { ["enUS"] = "Nat's Drinking Hat", skillId = 124034, isWearable = true, isLure = true },
    [33820]  = { ["enUS"] = "Weather-Beaten Fishing Hat", skillId = 7823, isWearable = true, isLure = true },

    --a-Lure-ing poles
    [116826] = { ["enUS"] = "Draenic Fishing Pole", skillId = 175369, isWearable = true, isLure = true },
	[116825] = { ["enUS"] = "Savage Fishing Pole", skillId = 59731, isWearable = true, isLure = true },
 
    -- Dranks
    [45694] = { ["enUS"] = "Captain Rumsey's Lager",  skillId = 45694, isBooze = true, isLure = true },  

    -- Standard lures
    [67404]  = { ["enUS"] = "Glass Fishing Bobber", skillId = 98849, isLure = true },
    [6529]   = { ["enUS"] = "Shiny Bauble", skillId= 8087, isLure = true },
	[6811]   = { ["enUS"] = "Aquadynamic Fish Lens", skillId = 8532, isLure = true },
	[6530]   = { ["enUS"] = "Nightcrawlers", skillId = 8088, isLure = true },
	[7307]   = { ["enUS"] = "Flesh Eating Worm", skillId = 9092, isLure = true },
	[6532]   = { ["enUS"] = "Bright Baubles", skillId = 8090 , isLure = true},
	[34861]  = { ["enUS"] = "Sharpened Fish Hook", skillId = 45731, isLure = true },
	[6533]   = { ["enUS"] = "Aquadynamic Fish Attractor", skillId = 8089, isLure = true },
	[62673]  = { ["enUS"] = "Feathered Lure", skillId = 87646, isLure = true },
	[46006]  = { ["enUS"] = "Glow Worm", skillId = 64401, isLure = true },
	[68049]  = { ["enUS"] = "Heat-Treated Spinning Lure", skillId = 95244, isLure = true },
	[118391] = { ["enUS"] = "Worm Supreme", skillId = 174471, isLure = true },
    
    -- Dalaran coin lures
    [138956] = { ["enUS"] = "Hypermagnetic Lure", skillId = 217835,isCoinLure = true },
    [138959] = {["enUS"] = "Micro-Vortex Generator",skillId  = 217838,isCoinLure = true},
    [138961] = {["enUS"] = "Alchemical Bonding Agent",skillId  = 217840,isCoinLure = true}, 
    [138962] = {["enUS"] = "Starfish on a String", skillId  = 217842,        isCoinLure = true    },
    [138957] = {["enUS"] = "Auriphagic Sardine", skillId  = 217836,isCoinLure = true}, 
    [138960] = {["enUS"] = "Wish Crystal",skillId  = 217839,isCoinLure = true},
    [138963] = {["enUS"] = "Tiny Little Grabbing Apparatus",skillId  = 217844,isCoinLure = true},
    [138958] = {["enUS"] = "Glob of Really Sticky Glue",skillId  = 217837,isCoinLure = true},

    -- Quest lures
    [58788]  = { ["enUS"] = "Overgrown Earthworm", skillId = 80534 }, -- Diggin' for Worms 
    [58949]  = { ["enUS"] = "Stag Eye", skillId = 80868}, -- A Staggering Effort 
    [45902]  = { ["enUS"] = "Phantom Ghostfish", skillId = 45902 },
    [69907]  = { ["enUS"] = "Corpse Worm", skillId = 99315 },
    [114628] = { ["enUS"] = "Icespine Stinger Bait", skillId = 168448 },
    [114874] = { ["enUS"] = "Moonshell Claw Bait", skillId = 168868},

    -- Bobbers
    [136377] = { ["enUS"] = "Oversized Bobber",skillId = 207700, isToy = false, isBobber = true, isOversized = true },
    [142531] = { ["enUS"] = "Duck Bobber", skillId = 231341, isToy = true, isBobber = true, isOversized = false },
    [142532] = { ["enUS"] = "Murloc Bobber", skillId = 231349, isToy = true, isBobber = true, isOversized = false  },
    [143662] = { ["enUS"] = "Wooden Pepe Bobber", skillId = 232613, isToy = true, isBobber = true, isOversized = false },
    [142530] = { ["enUS"] = "Tugboat Bobber", skillId = 231338, isToy = true, isBobber = true, isOversized = false },
    [142529] = { ["enUS"] = "Toy Cat Head Bobber", skillId = 231319, isToy = true, isBobber = true, isOversized = false },
    [142528] = { ["enUS"] = "Can of Worms Bobber", skillId = 231291, isToy = true, isBobber = true, isOversized = false },
    [147309] = { ["enUS"] = "Face of the Forest", skillId = 240806, isToy = true, isBobber = true, isOversized = false },
    [147310] = { ["enUS"] = "Floating Totem", skillId = 240802, isToy = true, isBobber = true, isOversized = false },
    [147307] = { ["enUS"] = "Carved Wooden Helm", skillId = 240803, isToy = true, isBobber = true, isOversized = false },
    [147311] = { ["enUS"] = "Replica Gondola", skillId = 240804, isToy = true, isBobber = true, isOversized = false },
    [147312] = { ["enUS"] = "Demon Noggin", skillId = 240801, isToy = true, isBobber = true, isOversized = false },
    [147308] = { ["enUS"] = "Enchanted Bobber", skillId = 240800, isToy = true, isBobber = true, isOversized = false },
    [180993] = { ["enUS"] = "Bat Visage", skillId = 335484, isToy = true, isBobber = true, isOversized = false },

}

local daFish = {
    [139652] = { ["enUS"] = "Leyshimmer Blenny", skillId = 133725, },
    [139653] = { ["enUS"] = "Nar'thalas Hermit", skillId = 133726, },
    [139654] = { ["enUS"] = "Ghostly Queenfish", skillId = 133727 },
    [139655] = { ["enUS"] = "Terrorfin", skillId = 133728 },
    [139656] = { ["enUS"] = "Thorned Flounder*", skillId = 133729},
    [139657] = { ["enUS"] = "Ancient Mossgill", skillId = 133730},
    [139658] = { ["enUS"] = "Mountain Puffer", skillId = 133731},
    [139659] = { ["enUS"] = "Coldriver Carp", skillId = 133732},
    [139660] = { ["enUS"] = "Ancient Highmountain Salmon", skillId = 133733},
    [139661] = { ["enUS"] = "Oodelfjisk", skillId = 133734},
    [139662] = { ["enUS"] = "Graybelly Lobster", skillId = 133735},
    [139663] = { ["enUS"] = "Thundering Stormray", skillId = 133736},
    [139664] = { ["enUS"] = "Magic-Eater Frog", skillId = 133737},
    [139665] = { ["enUS"] = "Seerspine Puffer", skillId = 133738},
    [139666] = { ["enUS"] = "Tainted Runescale Koi", skillId = 133739},
    [139667] = { ["enUS"] = "Axefish", skillId = 133740},
    [139668] = { ["enUS"] = "Seabottom Squid", skillId = 133741},
    [139669] = { ["enUS"] = "Ancient Black Barracuda", skillId = 133742},

    --fishing extravaganza fish
    [19807] = {"Speckled Tastyfish", isExtravaganzaFish = true},
    [19806] = {"Dezian Queenfish", isExtravaganzaFish = true},
    [19805] = {"Keefer's Angelfish", isExtravaganzaFish = true},
    [19803] = {"Brownell's Blue Striped Racer", isExtravaganzaFish = true},

    --Pandaland Quest fish
    [86545] = { ["enUS"] = "Mimic Octopus", questId = 31446, givesNatRep=true},
    [86544] = { ["enUS"] = "Spinefish Alpha", questId = 31444, givesNatRep=true},
    [86542] = { ["enUS"] = "Flying Tiger Gourami", questId = 31443, givesNatRep=true},
    
    -- Legion Lunkers
    [116817] = { ["enUS"] = "Blackwater Whiptail Lunker", isLunker = true, givesNatRep=true},
    [116818] = { ["enUS"] = "Abyssal Gulper Lunker", isLunker = true, givesNatRep=true},
    [116819] = { ["enUS"] = "Fire Ammonite Lunker", isLunker = true, givesNatRep=true},
    [116820] = { ["enUS"] = "Blind Lake Lunker", isLunker = true, givesNatRep=true},
    [116821] = { ["enUS"] = "Fat Sleeper Lunker", isLunker = true, givesNatRep=true},
    [116822] = { ["enUS"] = "Jawless Skulker Lunker", isLunker = true, givesNatRep=true},
    [127994] = { ["enUS"] = "Felmouth Frenzy Lunker", isLunker = true, givesNatRep=true},
    [116158] = { ["enUS"] = "Lunarfall Carp", hasLimit = 5, givesNatRep=true},
    [112633] = { ["enUS"] = "Frostdeep Minnow", givesNatRep=true},
    [122696] = { ["enUS"] = "Sea Scorpion Minnow", givesNatRep=true},
    [110508] = { ["enUS"] = "Sea Scorpion Minnow", givesNatRep=true},

    -- Trash
    [45190] = { ["enUS"] = "Driftwood", isJunk = true },
    [45200] = { ["enUS"] = "Sickly Fish", isJunk = true },
    [45194] = { ["enUS"] = "Tangled Fishing Line", isJunk = true },
    [45196] = { ["enUS"] = "Tattered Cloth", isJunk = true },
    [45198] = { ["enUS"] = "Weeds", isJunk = true },
    [45195] = { ["enUS"] = "Empty Rum Bottle", isJunk = true },
    [45199] = { ["enUS"] = "Old Boot", isJunk = true },
    [45201] = { ["enUS"] = "Rock", isJunk = true },
    [45197] = { ["enUS"] = "Tree Branch", isJunk = true },
    [45202] = { ["enUS"] = "Water Snail", isJunk = true },
    [45188] = { ["enUS"] = "Withered Kelp", isJunk = true },
    [45189] = { ["enUS"] = "Torn Sail", isJunk = true },
    [45191] = { ["enUS"] = "Empty Clam", isJunk = true },
};



local poolTypes = {
    [SCHOOL_FISH] = 0;
    [SCHOOL_WRECKAGE] = 1;
    [SCHOOL_DEBRIS] = 2;
    [SCHOOL_WATER] = 3;
    [SCHOOL_TASTY] = 4;
    [SCHOOL_OIL] = 5;
    [SCHOOL_CHURNING] = 6;
    [SCHOOL_FLOTSAM] = 7;
    [SCHOOL_FIRE] = 8;
};


-- the creature ids for the fishing pets
local FISHINGPETS = {
    [18839] = -1, -- Magical Crawdad
    [26050] = -1, -- Snarly
    [26056] = -1, -- Chuck
    [24388] = -1, -- Toothy
    [24389] = -1, -- Muckbreath
    [31575] = -1, -- Giant Sewer Rat
    [33226] = -1, -- Strand Crawler
    [55386] = -1, -- Sea Pony
    [63559] = -1, -- Tiny Goldfish
    [70257] = -1, -- Tiny Red Carp
    [70258] = -1, -- Tiny Blue Carp
    [70259] = -1, -- Tiny Green Carp
    [70260] = -1, -- Tiny White Carp
    [84441] = -1, -- Sea Calf
    [86445] = -1, -- Land Shark
    [126579] = -1 -- Ghost Shark
}

--Water walking, or WWJD as FB Said
local wwjdBuffs = {
    [1] = 546, -- Shaman Water Walking
    [2] = 3714, -- DK Path of Frost
    [3] = 11319, -- Elixir of Water Walking
    [4] = 175841, -- Draenic Water Walking Elixir
}
 

-- Inferred from Draznar's Fishing FAQ
local fishingAccessories = {
	[19944] = { ["enUS"] = "Nat Pagle's Fish Terminator", score = 30, },
	[11152] = { ["enUS"] = "Formula: Enchant Gloves - Fishing", score = 2, },
	[19979] = { ["enUS"] = "Hook of the Master Angler", score = 5, },
	[19947] = { ["enUS"] = "Nat Pagle's Broken Reel", score = 4, },
	[19972] = { ["enUS"] = "Lucky Fishing Hat", score = 5, },
	[7996] =  { ["enUS"] = "Lucky Fishing Hat", score = 10, },
	[33820] = { ["enUS"] = "Weather-Beaten Fishing Hat", score = 15, },
	[8749] =  { ["enUS"] = "Crochet Hat", score = 3, },
	[19039] = { ["enUS"] = "Zorbin's Water Resistant Hat", score = 3, },
	[3889] =  { ["enUS"] = "Russet Hat", score = 3, },
	[14584] = { ["enUS"] = "Dokebi Hat", score = 2, },
	[4048] =  { ["enUS"] = "Emblazoned Hat", score = 1, },
	[10250] = { ["enUS"] = "Masters Hat of the Whale", score = 1, },
	[6263] =  { ["enUS"] = "Blue Overalls", score = 4, },
	[9508] =  { ["enUS"] = "Mechbuilder's Overalls", score = 3, },
	[3342] =  { ["enUS"] = "Captain Sander's Shirt", score = 4, },
	[5107] =  { ["enUS"] = "Deckhand's Shirt", score = 2, },
	[6795] =  { ["enUS"] = "White Swashbuckler's Shirt", score = 1, },
	[2576] =  { ["enUS"] = "White Linen Shirt", score = 1, },
	[15405] = { ["enUS"] = "Shucking Gloves", score = 3, },
	[6202] =  { ["enUS"] = "Fingerless Gloves", score = 5, },
	[19969] = { ["enUS"] = "Nat Pagle's Extreme Anglin' Boots", score = 5, },
	[792] =   { ["enUS"] = "Knitted Sandals", score = 4, },
	[1560] =  { ["enUS"] = "Bluegill Sandals", score = 4, },
	[15406] = { ["enUS"] = "Crustacean Boots", score = 3, },
	[13402] = { ["enUS"] = "Timmy's Galoshes", score = 2, },
	[10658] = { ["enUS"] = "Quagmire Galoshes", score = 2, },
	[1678] =  { ["enUS"] = "Black Ogre Kickers", score = 1, },
	[5310] =  { ["enUS"] = "Sea Dog Britches", score = 4, },
	[3287] =  { ["enUS"] = "Tribal Pants", score = 2, },
	[6179] =  { ["enUS"] = "Privateer's Cape", score = 1, },
	[3567] =  { ["enUS"] = "Dwarven Fishing Pole", score = 1, },
};


local DEFAULT_SKILL = { ["max"] = 300, ["skillid"] = 356, ["cat"] = 1100, ["rank"] = 0 }
WBJ.ContinentFishingSkills = {
	{ ["max"] = 300, ["skillid"] = 356, ["cat"] = 1100, ["rank"] = 0 },	-- 2592?
	{ ["max"] = 300, ["skillid"] = 356, ["cat"] = 1100, ["rank"] = 0 },
	{ ["max"] = 75, ["skillid"] = 2591, ["cat"] = 1102, ["rank"] = 0 },	-- Outland Fishing
	{ ["max"] = 75, ["skillid"] = 2590, ["cat"] = 1104, ["rank"] = 0 },	-- Northrend Fishing
	{ ["max"] = 75, ["skillid"] = 2589, ["cat"] = 1106, ["rank"] = 0 },	-- Cataclysm Fishing (Darkmoon Island?)
	{ ["max"] = 75, ["skillid"] = 2588, ["cat"] = 1108, ["rank"] = 0 },	-- Pandaria Fishing
	{ ["max"] = 100, ["skillid"] = 2587, ["cat"] = 1110, ["rank"] = 0 },	-- Draenor Fishing
	{ ["max"] = 100, ["skillid"] = 2586, ["cat"] = 1112, ["rank"] = 0 },	-- Legion Fishing
	{ ["max"] = 150, ["skillid"] = 2585, ["cat"] = 1114, ["rank"] = 0 },	-- Kul Tiras Fishing
}




 function WBJ:GetFishingSkillInfo()
	local _, _, _, fishing, _, _ = GetProfessions();
	if ( fishing ) then
		local name, _, _, _, _, _, _ = GetProfessionInfo(fishing);
		return true, name;
	end
	return false, PROFESSIONS_FISHING;
end



-- locate the find fish skill
local FINDFISHTEXTURE = "133888";
function FishLib:GetFindFishID()
	if ( not self.FindFishID ) then
		self.FindFishID = self:GetTrackingID(FINDFISHTEXTURE);
	end
	return self.FindFishID;
end



function GetAvailableBobbers()
    local baits = {};
    for _,id in ipairs(bobberkeys) do
        if (PlayerHasToy(id) and C_ToyBox.IsToyUsable(id)) then
            -- if not PLANS:ItemCooldownOn(id) then
                _, id = C_ToyBox.GetToyInfo(id);
                tinsert(baits, id);
            -- end
        end
    end
    return true;
end