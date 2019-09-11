local L = LibStub("AceLocale-3.0"):NewLocale("RecipeRadarClassic", "enUS", true)

   -- the name of the addon!
L["Recipe Radar Classic"] = true

L["Left-click to open RecipeRadar."] = true
L["Right-click and drag to move this button."] = true

   -- these show up in the game's Key Bindings screen
L["Recipe Radar Bindings"] = true
L["Toggle Recipe Radar"] = true

   -- options button and corresponding options frame
L["Options"] = true
L["Auto-map Contributive Vendors"] = true
L["Auto-select Current Region"] = true
L["Check Availability for Alts"] = true
L["Minimap Button Position"] = true
L["Show Minimap Button"] = true

   -- format strings used in the map tooltips
L["1 recipe"] = true
L["%d learnable"] = true
L["%d recipes"] = true

   -- this appears when the recipe is not in your local database
L["Uncached Recipe"] = true

   -- uncached recipe tooltip - see RecipeRadar_Availability_CreateTooltip()
L["You may mouse over the"] = true
L["icon to lookup this recipe."] = true
L["Warning: if your server has"] = true
L["not yet seen this item, you"] = true
L["will be disconnected!"] = true

   -- some regions don't have any recipes for sale
L["No recipes for sale in this region."] = true

   -- radio button (and tooltip) that indicates a mapped vendor
L["Locate Vendor on Map"] = true
L["Shift-click a vendor to add or remove her location on the world map."] = true

   -- strings in the faction filtering dropdown; we don't need 'Horde' or 'Alliance' because Blizzard provides them for us
L["Factions"] = true
L["Neutral"] = true

   -- profession filtering dropdown - these strings must match those returned by GetTradeSkillLine() and GetCraftDisplaySkillLine()
L["Professions"] = true
L["Alchemy"] = true
L["Blacksmithing"] = true
L["Cooking"] = true
L["Enchanting"] = true
L["Engineering"] = true
L["First Aid"] = true
L["Fishing"] = true
L["Herbalism"] = true
L["Inscription"] = true
L["Jewelcrafting"] = true
L["Leatherworking"] = true
L["Mining"] = true
L["Skinning"] = true
L["Tailoring"] = true

   -- strings in the availability filtering dropdown
L["Availability"] = true
L["Already Known (Alts)"] = true
L["Already Known (Player)"] = true
L["Available Now (Alts)"] = true
L["Available Now (Player)"] = true
L["Future Prospect (Alts)"] = true
L["Future Prospect (Player)"] = true
L["Inapplicable"] = true

   -- headings for the availability tooltip
L["Available For:"] = true
L["Already Known By:"] = true
L["Future Prospect For:"] = true

   -- format string for rank indicator for future prospects; that is, it tells you how soon you can learn the recipe - eg. "163 of 175"
L["%d of %d"] = true

   -- special notes for vendor requirements follow vendor names (eg. "Seasonal Vendor")
L["%s Vendor"] = true
L["Intermittent"] = true
L["Quest"] = true
L["Roving"] = true
L["Seasonal"] = true

   -- other recipe requirements
L["Rogue Only"] = true
L["%s Only"] = true
L["Rogue"] = true
L["Special"] = true

   -- menu item in the right-click context menu for mapped vendor buttons
L["Unmap Vendor"] = true
L["Collapse"] = true
L["Collapse All"] = true
L["Expand"] = true
L["Expand All"] = true
L["Map Vendor"] = true

   -- trade skill specialties
L["Gnomish Engineer"] = true
L["Armorsmith"] = true
L["Dragonscale Leatherworking"] = true
L["Elemental Leatherworking"] = true
L["Goblin Engineer"] = true
L["Master Axesmith"] = true
L["Master Hammersmith"] = true
L["Master Swordsmith"] = true
L["Mooncloth Tailoring"] = true
L["Shadoweave Tailoring"] = true
L["Spellfire Tailoring"] = true
L["Tribal Leatherworking"] = true
L["Weaponsmith"] = true

   -- continent names for alternate region selection
L["Kalimdor"] = true
L["Eastern Kingdoms"] = true
L["Instances"] = true

   -- instance names for selection
L["Gnomeregan"] = true
L["Wailing Caverns"] = true
L["Blackrock Depths"] = true
L["Dire Maul"] = true
L["Naxxramas"] = true

   -- some vendor names may need translating
L["\"Chef\" Overheat"] = true
L["\"Cookie\" McWeaksauce"] = true
L["Aaron Hollman"] = true
L["Abigail Shiel"] = true
L["Aendel Windspear"] = true
L["Agatian Fallanos"] = true
L["Aged Dalaran Wizard"] = true
L["Ainderu Summerleaf"] = true
L["Alchemist Finklestein"] = true
L["Alchemist Gribble"] = true
L["Alchemist Pestlezugg"] = true
L["Aldraan"] = true
L["Alexandra Bolero"] = true
L["Algernon"] = true
L["Almaador"] = true
L["Altaa"] = true
L["Alurmi"] = true
L["Alys Vol'tyr"] = true
L["Amy Davenport"] = true
L["Andormu"] = true
L["Andrew Hilbert"] = true
L["Andrion Darkspinner"] = true
L["Androd Fadran"] = true
L["Anuur"] = true
L["Apothecary Antonivich"] = true
L["Apprentice Darius"] = true
L["Apprentice of Estulan"] = true
L["Archmage Alvareaux"] = true
L["Aresella"] = true
L["Argent Quartermaster Hasana"] = true
L["Argent Quartermaster Lightspark"] = true
L["Arille Azuregaze"] = true
L["Aristaleon Sunweaver"] = true
L["Arras"] = true
L["Arred"] = true
L["Arrond"] = true
L["Asarnan"] = true
L["Ayla Shadowstorm"] = true
L["Balai Lok'Wein"] = true
L["Bale"] = true
L["Banalash"] = true
L["Bario Matalli"] = true
L["Blackwing"] = true
L["Blimo Gadgetspring"] = true
L["Blixrez Goodstitch"] = true
L["Blizrik Buckshot"] = true
L["Bliztik"] = true
L["Bombus Finespindle"] = true
L["Borto"] = true
L["Borya"] = true
L["Bountiful Barrel"] = true
L["Bradley Towns"] = true
L["Braeg Stoutbeard"] = true
L["Brienna Starglow"] = true
L["Bro'kin"] = true
L["Bronk"] = true
L["Brundall Chiselgut"] = true
L["Bryan Landers"] = true
L["Buckslappy"] = true
L["Burbik Gearspanner"] = true
L["Burko"] = true
L["Captain Samir"] = true
L["Captured Gnome"] = true
L["Casandra Downs"] = true
L["Catherine Leland"] = true
L["Chapman"] = true
L["Christoph Jeffcoat"] = true
L["Cielstrasza"] = true
L["Clyde Ranthal"] = true
L["Constance Brisboise"] = true
L["Cookie One-Eye"] = true
L["Coreiel"] = true
L["Corporal Bluth"] = true
L["Cowardly Crosby"] = true
L["Crazk Sparks"] = true
L["Cro Threadstrong"] = true
L["Daga Ramba"] = true
L["Daggle Ironshaper"] = true
L["Dalni Tallgrass"] = true
L["Dalria"] = true
L["Damek Bloombeard"] = true
L["Daniel Bartlett"] = true
L["Danielle Zipstitch"] = true
L["Darian Singh"] = true
L["Darnall"] = true
L["Dealer Malij"] = true
L["Defias Profiteer"] = true
L["Deneb Walker"] = true
L["Derak Nightfall"] = true
L["Derek Odds"] = true
L["Desaan"] = true
L["Deynna"] = true
L["Dirge Quikcleave"] = true
L["Doba"] = true
L["Doris Volanthius"] = true
L["Drac Roughcut"] = true
L["Draelan"] = true
L["Drake Lindgren"] = true
L["Drovnar Strongbrew"] = true
L["Duchess Mynx"] = true
L["Edna Mullby"] = true
L["Eebee Jinglepocket"] = true
L["Egomis"] = true
L["Eiin"] = true
L["Eldara Dawnrunner"] = true
L["Elizabeth Barker Winslow"] = true
L["Elynna"] = true
L["Emrul Riknussun"] = true
L["Enchantress Andiala"] = true
L["Eriden"] = true
L["Erika Tate"] = true
L["Erilia"] = true
L["Evie Whirlbrew"] = true
L["Fariel Starsong"] = true
L["Fazu"] = true
L["Fedryen Swiftspear"] = true
L["Feera"] = true
L["Felannia"] = true
L["Felicia Doan"] = true
L["Felika"] = true
L["Fizzix Blastbolt"] = true
L["Fradd Swiftgear"] = true
L["Frozo the Renowned"] = true
L["Fyldan"] = true
L["Gagsprocket"] = true
L["Galley Chief Alunwea"] = true
L["Galley Chief Gathers"] = true
L["Galley Chief Grace"] = true
L["Galley Chief Halumvorea"] = true
L["Galley Chief Mariss"] = true
L["Galley Chief Steelbelly"] = true
L["Gambarinka"] = true
L["Gara Skullcrush"] = true
L["Gearcutter Cogspinner"] = true
L["Geen"] = true
L["Gelanthis"] = true
L["George Candarte"] = true
L["Gharash"] = true
L["Ghok'kah"] = true
L["Gidge Spellweaver"] = true
L["Gigget Zipcoil"] = true
L["Gikkix"] = true
L["Gina MacGregor"] = true
L["Gloria Femmel"] = true
L["Glyx Brewright"] = true
L["Gnaz Blunderflame"] = true
L["Goram"] = true
L["Gretta Ganter"] = true
L["Grimtak"] = true
L["Grub"] = true
L["Haalrun"] = true
L["Haferet"] = true
L["Hagrus"] = true
L["Hammon Karwn"] = true
L["Harggan"] = true
L["Harklan Moongrove"] = true
L["Harlon Thornguard"] = true
L["Harlown Darkweave"] = true
L["Harn Longcast"] = true
L["Haughty Modiste"] = true
L["Heldan Galesong"] = true
L["Helenia Olden"] = true
L["High Admiral \"Shelly\" Jorrik"] = true
L["Himmik"] = true
L["Hotoppik Copperpinch"] = true
L["Hula'mahi"] = true
L["Ikaneba Summerset"] = true
L["Ildine Sorrowspear"] = true
L["Indormi"] = true
L["Inessera"] = true
L["Innkeeper Biribi"] = true
L["Innkeeper Fizzgrimble"] = true
L["Innkeeper Grilka"] = true
L["Isabel Jones"] = true
L["Jabbey"] = true
L["Jandia"] = true
L["Janet Hommers"] = true
L["Jangdor Swiftstrider"] = true
L["Jannos Ironwill"] = true
L["Jaquilina Dramet"] = true
L["Jase Farlane"] = true
L["Jazzrik"] = true
L["Jeeda"] = true
L["Jennabink Powerseam"] = true
L["Jessara Cordell"] = true
L["Jezebel Bican"] = true
L["Jillian Tanner"] = true
L["Jim Saltit"] = true
L["Jinky Twizzlefixxit"] = true
L["Johan Barnes"] = true
L["John Rigsdale"] = true
L["Joseph Moore"] = true
L["Jubie Gadgetspring"] = true
L["Jungle Serpent"] = true
L["Jun'ha"] = true
L["Juno Dufrain"] = true
L["Jutak"] = true
L["Kaita Deepforge"] = true
L["Kalldan Felmoon"] = true
L["Kania"] = true
L["Karaaz"] = true
L["Karizi Porkpatty"] = true
L["Kaye Toogie"] = true
L["Keena"] = true
L["Kelsey Yance"] = true
L["Kendor Kabonka"] = true
L["Khara Deepwater"] = true
L["Khole Jinglepocket"] = true
L["Kiknikle"] = true
L["Killian Sanatha"] = true
L["Kilxx"] = true
L["Kim Horn"] = true
L["Kireena"] = true
L["Kirembri Silvermane"] = true
L["Kithas"] = true
L["Knaz Blunderflame"] = true
L["Knight Dameron"] = true
L["Koren"] = true
L["Kor'geld"] = true
L["Krek Cragcrush"] = true
L["Kriggon Talsone"] = true
L["Krinkle Goodsteel"] = true
L["KTC Train-a-Tron Deluxe"] = true
L["Kul Inkspiller"] = true
L["Kuldar Steeltooth"] = true
L["Kulwia"] = true
L["Kzixx"] = true
L["Lady Palanseer"] = true
L["Laha Farplain"] = true
L["Laida Gembold"] = true
L["Laird"] = true
L["Lalla Brightweave"] = true
L["Landraelanis"] = true
L["Larana Drome"] = true
L["Lardan"] = true
L["Larissia"] = true
L["Layna Karner"] = true
L["Lebowski"] = true
L["Leeli Longhaggle"] = true
L["Leo Sarn"] = true
L["Leonard Porter"] = true
L["Librarian Erickson"] = true
L["Lieutenant General Andorov"] = true
L["Lillehoff"] = true
L["Lilly"] = true
L["Lindea Rabonne"] = true
L["Linna Bruder"] = true
L["Lizbeth Cromwell"] = true
L["Lizna Goldweaver"] = true
L["Logannas"] = true
L["Logistics Officer Brighton"] = true
L["Logistics Officer Silverstone"] = true
L["Logistics Officer Ulrike"] = true
L["Lokhtos Darkbargainer"] = true
L["Loolruna"] = true
L["Lorelae Wintersong"] = true
L["Lyna"] = true
L["Madame Ruby"] = true
L["Magnus Frostwake"] = true
L["Mahu"] = true
L["Mak"] = true
L["Mallen Swain"] = true
L["Malygen"] = true
L["Mari Stonehand"] = true
L["Maria Lumere"] = true
L["Marith Lazuria"] = true
L["Martine Tramblay"] = true
L["Masat T'andr"] = true
L["Master Chef Mouldier"] = true
L["Master Craftsman Omarion"] = true
L["Mathar G'ochar"] = true
L["Mavralyn"] = true
L["Mazk Snipeshot"] = true
L["Meilosh"] = true
L["Melaris"] = true
L["Mera Mistrunner"] = true
L["Micha Yance"] = true
L["Millie Gregorian"] = true
L["Mirla Silverblaze"] = true
L["Misensi"] = true
L["Mishta"] = true
L["Misty Merriweather"] = true
L["Mixie Farshot"] = true
L["Modoru"] = true
L["Montarr"] = true
L["Morgan Day"] = true
L["Moro Sungrain"] = true
L["Muheru the Weaver"] = true
L["Muuran"] = true
L["Mycah"] = true
L["Mythrin'dir"] = true
L["Naal Mistrunner"] = true
L["Nakodu"] = true
L["Namdo Bizzfizzle"] = true
L["Nandar Branson"] = true
L["Nardstrum Copperpinch"] = true
L["Narj Deepslice"] = true
L["Narkk"] = true
L["Nasmara Moonsong"] = true
L["Nata Dawnstrider"] = true
L["Neal Allen"] = true
L["Neii"] = true
L["Nemiha"] = true
L["Nergal"] = true
L["Nerrist"] = true
L["Nessa Shadowsong"] = true
L["Nina Lightbrew"] = true
L["Nioma"] = true
L["Nula the Butcher"] = true
L["Nuri"] = true
L["Nyoma"] = true
L["Ogg'marr"] = true
L["Okuno"] = true
L["Old Man Heming"] = true
L["Ontuvo"] = true
L["Otho Moji'ko"] = true
L["Outfitter Eric"] = true
L["Paku Cloudchaser"] = true
L["Palehoof's Big Bag of Parts"] = true
L["Paulsta'ats"] = true
L["Penney Copperpinch"] = true
L["Phea"] = true
L["Plugger Spazzring"] = true
L["Poranna Snowbraid"] = true
L["Pratt McGrubben"] = true
L["Prospector Khazgorm"] = true
L["Provisioner Lorkran"] = true
L["Provisioner Nasela"] = true
L["Punra"] = true
L["Qia"] = true
L["Quartermaster Davian Vaclav"] = true
L["Quartermaster Endarin"] = true
L["Quartermaster Enuril"] = true
L["Quartermaster Jaffrey Noreliqe"] = true
L["Quartermaster Miranda Breechlock"] = true
L["Quartermaster Urgronn"] = true
L["Quelis"] = true
L["Randah Songhorn"] = true
L["Ranik"] = true
L["Ranisa Whitebough"] = true
L["Rann Flamespinner"] = true
L["Rartar"] = true
L["Rathis Tomber"] = true
L["Riha"] = true
L["Rikqiz"] = true
L["Rin'wosho the Trader"] = true
L["Rizz Loosebolt"] = true
L["Rohok"] = true
L["Ronald Burch"] = true
L["Rose Standish"] = true
L["Rungor"] = true
L["Ruppo Zipcoil"] = true
L["Saenorion"] = true
L["Sairuk"] = true
L["Sal Ferraga"] = true
L["Samuel Van Brunt"] = true
L["Sara Lanner"] = true
L["Sarah Lightbrew"] = true
L["Sassa Weldwell"] = true
L["Sebastian Crane"] = true
L["Seer Janidi"] = true
L["Seersa Copperpinch"] = true
L["Senthii"] = true
L["Sewa Mistrunner"] = true
L["Shaani"] = true
L["Shadi Mistrunner"] = true
L["Shandrina"] = true
L["Shankys"] = true
L["Shay Pressler"] = true
L["Shazdar"] = true
L["Sheendra Tallgrass"] = true
L["Shen'dralar Provisioner"] = true
L["Sheri Zipstitch"] = true
L["Sid Limbardi"] = true
L["Skreah"] = true
L["Smudge Thunderwood"] = true
L["Soolie Berryfizz"] = true
L["Sovik"] = true
L["Steeg Haskell"] = true
L["Stone Guard Mukar"] = true
L["Stuart Fleming"] = true
L["Suja"] = true
L["Sumi"] = true
L["Super-Seller 680"] = true
L["Supply Officer Mills"] = true
L["Tamar"] = true
L["Tanaika"] = true
L["Tanak"] = true
L["Tansy Puddlefizz"] = true
L["Tarban Hearthgrain"] = true
L["Tarien Silverdew"] = true
L["Tari'qa"] = true
L["Taur Stonehoof"] = true
L["Terrance Denman"] = true
L["Thaddeus Webb"] = true
L["Tharynn Bouden"] = true
L["Thomas Yance"] = true
L["Threm Blackscalp"] = true
L["Thurgrum Deepforge"] = true
L["Tiffany Cartier"] = true
L["Tilli Thistlefuzz"] = true
L["Timothy Jones"] = true
L["Trader Narasu"] = true
L["Truk Wildbeard"] = true
L["Tunkk"] = true
L["Ulthaan"] = true
L["Ulthir"] = true
L["Una Kobuna"] = true
L["Uriku"] = true
L["Uthok"] = true
L["Vaean"] = true
L["Valdaron"] = true
L["Vanessa Sellers"] = true
L["Vargus"] = true
L["Veenix"] = true
L["Velia Moonbow"] = true
L["Vendor-Tron 1000"] = true
L["Veteran Crusader Aliocha Segard"] = true
L["Vharr"] = true
L["Viggz Shinesparked"] = true
L["Vivianna"] = true
L["Vix Chromeblaster"] = true
L["Vizna Bangwrench"] = true
L["Vizzklick"] = true
L["Vodesiin"] = true
L["Wenna Silkbeard"] = true
L["Werg Thickblade"] = true
L["Wik'Tar"] = true
L["Wilmina Holbeck"] = true
L["Wind Trader Lathrai"] = true
L["Wolgren Jinglepocket"] = true
L["Worb Strongstitch"] = true
L["Wrahk"] = true
L["Wulan"] = true
L["Wulmort Jinglepocket"] = true
L["Wunna Darkmane"] = true
L["Xandar Goodbeard"] = true
L["Xen'to"] = true
L["Xerintha Ravenoak"] = true
L["Xizk Goodstitch"] = true
L["Xizzer Fizzbolt"] = true
L["Yatheon"] = true
L["Yonada"] = true
L["Ythyar"] = true
L["Yuka Screwspigot"] = true
L["Yurial Soulwater"] = true
L["Zan Shivsproket"] = true
L["Zannok Hidepiercer"] = true
L["Zansoa"] = true
L["Zaralda"] = true
L["Zarena Cromwind"] = true
L["Zargh"] = true
L["Zido Helmbreaker"] = true
L["Zixil"] = true
L["Zoey Wizzlespark"] = true
L["Zorbin Fandazzle"] = true
L["Zurai"] = true
L["Zurii"] = true
