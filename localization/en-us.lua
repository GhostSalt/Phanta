return {
	descriptions = {
		Back = {
			
		},
		Blind = {
			
		},
		["Content Set"] = {
			set_phanta_jokers = {
				name = "Jokers",
				text = {
					"{C:attention}Jokers{} from Phanta",
				},
			},
			set_phanta_spectral = {
				name = "Spectral Cards",
				text = {
					"{C:spectral}Spectral{} cards from Phanta",
				},
			},
			set_phanta_tarot = {
				name = "Tarot Cards",
				text = {
					"{C:tarot}Tarot{} cards from Phanta",
				},
			}
		},
		Joker = {
			j_phanta_bootleg = {
                name = 'Bootleg',
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "{C:mult}+#2#{} Mult"
				}
			},
			j_phanta_trainstation = {
                name = 'Train Station',
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "played {C:attention}#2#{}, rank increases",
                    "each round",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
                }
			},
			j_phanta_yellow = {
                name = 'Yellow',
                text = {
                    "Earn {C:money}$#1#{} on",
                    "{C:attention}odd{} rounds,",
                    "earn {C:money}$#2#{} on",
                    "{C:attention}even{} rounds"
                }
			},
			j_phanta_onemanstrash = {
                name = "One Man's Trash",
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "card {C:attention}discarded{} this round",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_anothermanstreasure = {
                name = "Another Man's Treasure",
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult for each",
                    "card {C:attention}discarded{} this round",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_oracle = {
                name = 'Oracle',
                text = {
                    "{C:attention}+1{} consumable slot"
                }
			},
			j_phanta_thief = {
                name = 'Thief',
                text = {
                    "{C:blue}+1{} hand",
                    "each round"
                }
			},
			j_phanta_nonuniformday = {
                name = "Non-Uniform Day",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "played {C:attention}Wild{} card to create",
                    "a {C:tarot}Tarot{} card when scored",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_teastainedjoker = {
                name = "Tea-Stained Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:mult}+#3#{} Mult for each {C:attention}Lucky{}",
                    "card held in hand",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)"
                }
			},
			j_phanta_ghost = {
                name = 'Ghost',
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult for",
                    "each {C:tarot}Tarot{} card in",
                    "your {C:attention}consumable{} area",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
			},
			j_phanta_layton = {
                name = 'Layton',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "give {C:mult}+#3#{} Mult,",
                    "held {C:tarot}Tarot{} cards",
                    "increase the odds",
                    "{C:inactive,s:0.75}(Guaranteed if with Luke){}"
                }
			},
			j_phanta_luke = {
                name = 'Luke',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "give {X:mult,C:white}X#3#{} Mult,",
                    "held {C:planet}Planet{} cards",
                    "increase the odds",
                    "{C:inactive,s:0.75}(Guaranteed if with Layton){}"
                }
			},
			j_phanta_candle = {
                name = 'Candle',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroys 1 {C:tarot}Tarot{} card",
                    "and gains {C:white,X:mult}X#1#{} Mult",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_identity = {
                name = 'Identity',
                text = {
                    "Creates #1# {C:dark_edition}Negative{}",
                    "{C:spectral}Spectral{} cards at",
                    "the end of the {C:attention}shop",
                    "{C:red,E:2}self destructs{}"
                }
			},
			j_phanta_p5joker = {
                name = 'Looking Cool, Joker!',
                text = {
                    "Gains {C:mult}+#1#{} Mult per hand",
                    "played that is not your",
                    "most played {C:attention}poker hand{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
			},
			j_phanta_crescent = {
                name = 'Crescent',
                text = {
                    "Creates a {C:tarot}Tarot{} card when",
                    "a {C:planet}Planet{} card is sold",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_purplejoker = {
                name = 'Purple Joker',
                text = {
                    "Gains {C:mult}+#1#{} Mult if hand",
                    "is played while",
                    "holding any {C:tarot}Tarot{} cards",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
			},
			j_phanta_monetjoker = {
                name = 'Monet Joker',
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "if {C:attention}discard{} has",
                    "only {C:attention}1{} card",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_goldenfiddle = {
                name = 'Golden Fiddle',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Devil{} or {C:tarot}The Chariot{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_reverie = {
                name = 'Reverie',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Heirophant{} or {C:tarot}Temperance{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_sees = {
                name = 'S.E.E.S.',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Moon{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_scissorsaresharp = {
                name = 'Scissors are Sharp',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}Judgement{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_caesarcipher = {
                name = 'Caesar Cipher',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a {C:planet}Planet{} card or",
                    "a copy of {C:tarot}Strength{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_timepiece = {
                name = 'Timepiece',
                text = {
                    "On {C:attention}final hand{} of",
                    "round, creates a",
                    "copy of {C:tarot}Death{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_introspection = {
                name = 'Introspection',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a {V:1}#1#{} card and",
                    "changes type to {V:2}#2#{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_blindjoker = {
                name = 'Blind Joker',
                text = {
                    "Creates the {C:planet}Planet{} card",
                    "for hands that contain",
                    "exactly #1# {C:attention}Aces{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_witchsmark = {
                name = "Witch's Mark",
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "if all played cards",
                    "are {C:attention}face cards{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_modernart = {
                name = 'Modern Art',
                text = {
                    "Gains {C:money}$#1#{} of",
                    "{C:attention}sell value{} per",
                    "{C:attention}High Card{} played"
                }
			},
			j_phanta_conspiracist = {
                name = 'Conspiracist',
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a copy of {C:blue}Earth{} if",
                    "played hand is a {C:attention}Full House{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_eyeofprovidence = {
                name = 'Eye of Providence',
                text = {
                    "Each played",
                    "{C:attention}Ace of Spades{} gives",
                    "{C:white,X:mult}X#1#{} Mult when scored{}"
                }
			},
			j_phanta_emotionaldamage = {
                name = 'Emotional Damage',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult per",
                    "discarded {C:attention}Flush{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult)"
                }
			},
			j_phanta_inception = {
                name = 'Inception',
                text = {
                    "{C:mult}+#1#{} Mult per hand",
                    "played this {C:attention}Blind{}",
                    "{C:inactive}(Will give {C:mult}+#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_thespear = {
                name = 'The Spear',
                text = {
                    "If played hand contains any",
                    "{C:spades}Spade{} cards, destroy one",
                    "and upgrade {C:attention}Straight{}"
                }
			},
			j_phanta_thefuse = {
                name = 'The Fuse',
                text = {
                    "If played hand contains any",
                    "{C:hearts}Heart{} cards, destroy one",
                    "and gain {C:white,X:mult}X#1#{} Mult",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_themace = {
                name = 'The Mace',
                text = {
                    "If played hand contains any",
                    "{C:clubs}Club{} cards, destroy one",
                    "and gain {C:money}$#1#{}"
                }
			},
			j_phanta_thedagger = {
                name = 'The Dagger',
                text = {
                    "If played hand contains any",
                    "{C:diamonds}Diamond{} cards, destroy one",
                    "and gain {C:mult}+#1#{} Mult",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_selfportrait = {
                name = 'Self-portrait',
                text = {
                    "After #2# rounds, {C:attention}duplicates{}",
                    "the next Joker you {C:attention}buy{}",
                    "{C:red,E:2}self destructs{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#){}",
                    "{C:inactive}(Removes {C:dark_edition}Negative{C:inactive} from copy){}"
                }
			},
			j_phanta_caniossoul = {
                name = 'Canio\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses",
                    "{C:white,X:mult}X#1#{} Mult if played",
                    "hand contains any",
                    "{C:attention}face cards{}"
                }
			},
			j_phanta_tribouletssoul = {
                name = 'Triboulet\'s Soul',
                text = {
                    "{C:white,X:mult}X#1#{} Mult for {C:attention}#2#{} round#3#,",
                    "gains {C:attention}+#4#{} rounds if played",
                    "hand contains a scoring",
                    "{C:attention}King{} and {C:attention}Queen{}"
                }
			},
			j_phanta_perkeossoul = {
                name = 'Perkeo\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{} Mult",
                    "at the end of the round",
                    "if any {C:attention}consumable{} slots",
                    "are {C:attention}empty{}"
                }
			},
			j_phanta_possession = {
                name = 'Possession',
                text = {
                    "When a Joker is",
                    "{C:attention}purchased, {C:odds}#1# in #2#{}",
                    "chance to make",
                    "it {C:dark_edition}Negative{}"
                }
			},
			j_phanta_ignaize = {
                name = 'Ignaize',
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when a",
                    "{C:attention}consumable{} card is {C:attention}sold{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
			},
			j_phanta_dimere = {
                name = 'Dimere',
                text = {
                    "When {C:attention}Boss Blind{} is defeated,",
                    "#1# random {C:attention}Joker{} becomes",
                    "{C:negative}Negative{} {C:inactive}(except Dimeres{}",
                    "{C:inactive}or Jokers with editions){}"
                }
			},
			j_phanta_goldor = {
                name = 'Goldor',
                text = {
                    "Played {C:attention}Gold{} cards",
                    "each give {C:money}$#2#{} and",
                    "{C:white,X:mult}X#1#{} Mult when scored"
                }
			},
			j_phanta_famalia = {
                name = 'Famalia',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "add a {C:attention}King{} with a",
                    "{C:purple}Purple{} seal and edition",
                    "to your hand"
                }
			},
			j_phanta_godoor = {
                name = 'Godoor',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult at the",
                    "end of the {C:attention}shop{} if you",
                    "used exactly {C:attention}1{} {C:green}Reroll{}",
                    "{C:inactive}(Current {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_fainfol = {
                name = 'Fainfol',
                text = {
                    "Each {V:1}#1#{} card held",
                    "in hand gives {C:white,X:mult}X#2#{} Mult,",
                    "suit changes every round"
                }
			},
			j_phanta_granwyrm = {
                
			},
			j_phanta_ = {
                
			}
		},
		Tarot = {
			c_phanta_grave = {
				name = "The Grave",
				text = {
                    "Enhances {C:attention}#1#{}",
                    "selected card into a",
                    "{C:attention}Ghost Card{}"
				},
			},
		},
        Spectral = {
			c_phanta_jinn = {
				name = "Jinn",
				text = {
					"Add a {C:attention}Ghost Seal{}",
                    "to {C:attention}1{} selected",
                    "card held in hand"
				},
			},
		}
	},
	misc = {
		dictionary = {
			
		},
		labels = {
			phanta_ghost_card = "Ghost Card",
			phanta_ghost_seal = "Ghost Seal"
		}
	}
}
