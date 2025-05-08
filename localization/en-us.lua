return {
	descriptions = {
		Back = {
            b_phanta_stormcaught = {
                name = 'Stormcaught Deck',
                text = {
                    "Gain an {C:attention}Uncommon Tag{} at",
                    "the start of the {C:attention}run{},",
                    "and after defeating",
                    "each {C:attention}Boss Blind{}"
                }
		    },
            b_phanta_blurple = {
                name = 'Blurple Deck',
                text = {
                    "When {C:attention}Blind{} is",
                    "selected, gain a",
                    "random {C:tarot}Tarot{} or",
                    "{C:planet}Planet{} card",
                    "{C:inactive}(Must have room){}"
                }
		    },
            b_phanta_azran = {
                name = 'Azran Deck',
                text = {
                    "Very powerful {C:spectral}Spectral{}",
                    "cards may appear"
                }
		    },
            b_phanta_badd = {
                name = 'Badd Deck',
                text = {
                    "{C:red}Destroys{} all played",
                    "cards in {C:attention}final{}",
                    "{C:attention}hand{} of round"
                }
		    },
            b_phanta_silver = {
                name = 'Silver Deck',
                text = {
                    "Played and {C:attention}unscored{}",
                    "cards give {C:money}$#1#{}",
                    "{C:red}-#2#{} hand size"
                }
		    },
            b_phanta_tally = {
                name = 'Tally Deck',
                text = {
                    "The first time you",
                    "select the {C:attention}Small Blind{} of",
                    "{C:attention}Ante 5{}, destroys {C:red}1{} Joker",
                    "and gain {C:attention}+#1#{} Joker slot"
                }
		    },
            b_phanta_trickster = {
                name = 'Trickster Deck',
                text = {
                    "Creates a copy of",
                    "{C:tarot}The Hanged Man{} when a",
                    "{C:attention}playing card{} is added",
                    "to your deck",
                    "{C:inactive}(Must have room){}"
                }
		    },
            b_phanta_barrier = {
                name = 'Barrier Deck',
                text = {
                    "When skipping a",
                    "{C:attention}Booster Pack{}, gain",
                    "{C:attention}+1{} hand size",
                    "next round"
                }
		    },
            b_phanta_poltergeist = {
                name = 'Poltergeist Deck',
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Cards are drawn {C:attention}face down{}",
                    "if the number of face down",
                    "cards is less than {C:attention}#1#{}"
                }
		    },
            b_phanta_hivis = {
                name = 'Hi-Vis Deck',
                text = {
                    "Start run with the",
                    "{C:red}#1#{} Voucher"
                }
		    }
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
        Edition = {
            e_phanta_waxed = {
                name="Waxed",
                text={
                    "{X:mult,C:white} X#1# {} Mult",
                },
            }
        },
        Enhanced = {
            m_phanta_ghostcard = {
                name = 'Ghost Card',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if held in",
                    "hand, gains {C:white,X:mult}X#2#{} Mult",
                    "if played and not scored"
                }
            },
            m_phanta_coppergratefresh = {
                name = 'Copper Grate Card',
                text = {
                    "{C:white,X:mult}X#1#{} Mult",
                    "Becomes {C:attention}Exposed{} if",
                    "played and not {C:dark_edition}Waxed{}"
                }
            },
            m_phanta_coppergrateexposed = {
                name = 'Copper Grate Card',
                text = {
                    "{C:white,X:mult}X#1#{} Mult, {C:chips}+#2#{} Chips",
                    "Becomes {C:attention}Weathered{} if",
                    "played and not {C:dark_edition}Waxed{}"
                }
            },
            m_phanta_coppergrateweathered = {
                name = 'Copper Grate Card',
                text = {
                    "{C:white,X:mult}X#1#{} Mult, {C:chips}+#2#{} Chips",
                    "Becomes {C:attention}Oxidised{} if",
                    "played and not {C:dark_edition}Waxed{}"
                }
            },
            m_phanta_coppergrateoxidised = {
                name = 'Copper Grate Card',
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Self destructs if",
                    "played and not {C:dark_edition}Waxed{}"
                }
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
                    "played and scored {C:attention}#2#{}, rank",
                    "increases each round",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
                }
			},
			j_phanta_hintcoin = {
                name = 'Hint Coin',
                text = {
                    "Earn {C:money}$#1#{} when",
                    "you play your",
                    "{C:attention}second{} hand"
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
			j_phanta_holeinthejoker = {
                name = 'Hole in the Joker',
                text = {
                    "Earn {C:money}$#1#{} at end of",
                    "round for each",
                    "empty {C:attention}Joker{} slot",
                    "{C:inactive}(Will give {C:money}$#2#{C:inactive}){}"
                }
			},
			j_phanta_shootingstar = {
                name = 'Shooting Star',
                text = {
                    "Gives {C:money}$#1#{} when a card",
                    "with {C:diamonds}Diamonds{} suit is",
                    "{C:red}destroyed{}, and increases",
                    "reward by {C:money}$#2#{}"
                }
			},
			j_phanta_binman = {
                name = 'Binman',
                text = {
                    "Gives {C:money}$#1#{} for",
                    "each {C:red}discarded{} {C:attention}Junk{}"
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
			j_phanta_detective = {
                name = 'Detective',
                text = {
                    "{C:attention}+1{} card slot",
                    "in the shop"
                }
			},
			j_phanta_new2dsxl = {
                name = 'New 2DS XL',
                text = {
                    "{C:attention}-#2#{} hand size",
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:white,X:blue}X#1#{} Hands"
                }
			},
			j_phanta_playerpin = {
                name = 'Player Pin',
                text = {
                    "The next {C:attention}3{} cards",
                    "in the deck are:",
                    "{V:1}#1#{}#2#{V:2}#3#{}",
                    "{V:3}#4#{}#5#{V:4}#6#{}",
                    "{V:5}#7#{}#8#{V:6}#9#{}"
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
			j_phanta_badhairday = {
                name = "Bad Hair Day",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "{C:attention}Wild{} card held in hand",
                    "to be destroyed"
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
			j_phanta_exitsign = {
                name = 'Exit Sign',
                text = {
                    "Earn {C:money}$#1#{} when hand",
                    "is played if {C:blue}0{} hands",
                    "and {C:red}0{} discards remain"
                }
			},
			j_phanta_saltcircle = {
                name = 'Salt Circle',
                text = {
                    "Sets Chips",
					"to {C:chips}#1#{}"
                }
			},
			j_phanta_shackles = {
                name = 'Shackles',
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "forces {C:attention}1{} card to",
                    "always be selected"
                }
			},
			j_phanta_html = {
                name = 'HTML',
                text = {
                    "On {C:attention}first hand{}",
                    "of round, sets",
                    "Mult to {C:mult}#1#{}"
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
			j_phanta_knowledgeofthecollege = {
                name = 'Knowledge of the College',
                text = {
                    "Played and {C:attention}unscored{}",
                    "{C:attention}Aces{} give {C:white,X:mult}X#1#{} Mult"
                }
			},
			j_phanta_theapparition = {
                name = 'The Apparition',
                text = {
                    "Retriggers all played",
                    "and {C:attention}unscored{} cards"
                }
			},
			j_phanta_grimreaper = {
                name = 'The Grim Reaper',
                text = {
                    "If hand is played while",
                    "holding a copy of",
                    "{C:purple}Death{}, {C:red}destroys{} it,",
                    "and all played cards"
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
			j_phanta_descole = {
                name = 'Descole',
                text = {
                    "Upon discarding a {C:attention}Stone{}",
                    "card, {C:red}destroys{} it and creates",
                    "a copy of {C:tarot}The Devil{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_engineer = {
                name = 'Engineer',
                text = {
                    "If played hand is",
                    "a {C:attention}Junk{}, creates a",
                    "copy of {C:tarot}The Chariot{}",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_apollosbracelet = {
                name = 'Apollo\'s Bracelet',
                text = {
                    --"Swaps {C:chips}Chips{} and {C:mult}Mult{}"
                    "Swaps {C:chips}Chips{} and {C:mult}Mult{}",
                    "before and during scoring"
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
			j_phanta_web = {
                name = 'Web',
                text = {
                    "{C:mult}+#1#{} Mult if {C:attention}#2#{}",
                    "or more cards",
                    "held in hand",
                    "have {C:spades}Spades{} suit"
                }
			},
			j_phanta_cutcorners = {
                name = 'Cut Corners',
                text = {
                    "Gains {C:mult}+#1#{} Mult if",
                    "played hand contains",
                    "{C:attention}#2#{} or fewer cards",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
			},
			j_phanta_blottedjoker = {
                name = 'Blotted Joker',
                text = {
                    "Gains {C:chips}+#1#{} Chips for each",
                    "played and scored {C:attention}Bonus{}",
                    "card, {C:attention}unenhances{} them",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
			},
			j_phanta_bloodpact = {
                name = 'Blood Pact',
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "played and scored {C:attention}Mult{}",
                    "card, {C:attention}unenhances{} them",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
			},
			j_phanta_tnetennba = {
                name = 'TNETENNBA',
                text = {
                    "Gains {C:mult}+#1#{} Mult if hand is",
                    "played while the cards held",
                    "in hand contain a {C:attention}Straight{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                    "{C:inactive,s:0.75}(Doesn't currently support{}",
                    "{C:inactive,s:0.75}Four Fingers or Shortcut){}"
                }
			},
			j_phanta_technicolourjoker = {
                name = 'Technicolour Joker',
                text = {
                    "Played {C:attention}Wild{} cards",
                    "give {C:mult}+#1#{} Mult",
                    "when scored"
                }
			},
			j_phanta_goo = {
                name = 'Goo',
                text = {
                    ""
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
			j_phanta_ransomnote = {
                name = 'Ransom Note',
                text = {
                    "Gives {C:money}$#1#{} every",
					"{C:attention}#2#{} {C:inactive}[#3#]{} Jokers {C:attention}sold{}"
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
			j_phanta_charcoaljoker = {
                name = 'Charcoal Joker',
                text = {
                    "Gains {C:mult}+#1#{} Mult if",
                    "all {C:red}discarded{} cards",
                    "are {C:spades}Spades{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
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
			j_phanta_sketch = {
                name = 'Sketch',
                text = {
                    "Gives {C:white,X:mult}X#1#{} Mult for",
                    "each played card",
                    "that {C:attention}doesn't score{}"
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
			j_phanta_sudoku = {
                name = 'Sudoku',
                text = {
                    "Once {C:attention}A-9{} {C:inactive}[#1#]{} have",
                    "each been played and scored,",
                    "upgrades {C:attention}Straight{} by {C:attention}#2#{} level"
                }
			},
			j_phanta_ceaseanddesist = {
                name = 'Cease and Desist',
                text = {
                    "Upgrades {C:attention}Straight{} by",
                    "{C:attention}#1#{} level when any",
                    "{C:attention}Booster Pack{} is skipped"
                }
			},
			j_phanta_nojoke = {
                name = 'No Joke',
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "level in {C:attention}Straight{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_diningtable = {
                name = 'Dining Table',
                text = {
                    "If played hand is",
					"a {C:attention}Full House{},",
					"the {C:attention}pair{} of cards",
					"become {C:attention}Glass{}"
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
                    "If scored hand contains any",
                    "{C:spades}Spade{} cards, destroys one",
                    "and upgrade {C:attention}Straight{}"
                }
			},
			j_phanta_thefuse = {
                name = 'The Fuse',
                text = {
                    "If scored hand contains any",
                    "{C:hearts}Heart{} cards, destroys one",
                    "and gains {C:white,X:mult}X#1#{} Mult",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
			},
			j_phanta_themace = {
                name = 'The Mace',
                text = {
                    "If scored hand contains any",
                    "{C:clubs}Club{} cards, destroys one",
                    "and gives {C:money}$#1#{}"
                }
			},
			j_phanta_thedagger = {
                name = 'The Dagger',
                text = {
                    "If scored hand contains any",
                    "{C:diamonds}Diamond{} cards, destroys one",
                    "and gains {C:mult}+#1#{} Mult",
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
			j_phanta_chicotssoul = {
                name = 'Chicot\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{}",
                    "Mult at the end of",
                    "the round if more",
                    "than {C:attention}#3#{} {C:blue}hand{} was used"
                }
			},
			j_phanta_yorickssoul = {
                name = 'Yorick\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{}",
                    "Mult at the end of",
                    "the round if any",
                    "{C:red}discards{} weren't used"
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
			j_phanta_spectretile = {
                name = 'Spectre Tile',
                text = {
                    "When a Joker is",
                    "{C:attention}purchased{}, {C:green}#1# in #2#{} chance",
                    "to create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room){}"
                }
			},
			j_phanta_possession = {
                name = 'Possession',
                text = {
                    "When a Joker is",
                    "{C:attention}purchased, {C:green}#1# in #2#{}",
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
                name = 'Granwyrm',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult every",
                    "{C:attention}#2#{} {C:inactive}[#3#]{} cards played",
                    "and {C:attention}unscored{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#4#{C:inactive} Mult){}"
                }
			},
			j_phanta_ = {
                
			}
		},
        Planet = {
            c_phanta_rubbish = {
                name = 'Rubbish',
                text = {
                  "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                  "{C:attention}Junk{}",
                  "{C:mult}+#3#{} Mult and",
                  "{C:chips}+#4#{} chips",
                }
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
            c_phanta_beekeeper = {
				name = "The Beekeeper",
				text = {
                    "Adds {C:dark_edition}Waxed{} to",
                    "{C:attention}#3#{} selected cards"
				},
			}
		},
        Spectral = {
			c_phanta_jinn = {
				name = "Jinn",
				text = {
					"Add a {C:attention}Ghost Seal{}",
                    "to {C:attention}1{} selected",
                    "card held in hand"
				},
			}
		}
	},
	misc = {
		dictionary = {
			chips_equals = "Chips=",
            mult_equals = "Mult=",
			swapped = "Swapped",
			become_glass = "Glass",
            copper_grate_fresh = "Fresh",
            copper_grate_exposed = "Exposed",
            copper_grate_weathered = "Weathered",
            copper_grate_oxidised = "Oxidised",
            one_extra_hand_size = "+1 Hand Size"
		},
		labels = {
			phanta_ghost_card = "Ghost Card",
			phanta_ghost_seal = "Ghost Seal",
            phanta_waxed = "Waxed"
		},
		poker_hands = {
			["phanta_junk"] = "Junk",
		},
		poker_hand_descriptions = {
			["phanta_junk"] = {
                "Any High Card where 5 cards are played.",
                "The lowest card scores instead"
			}
		},
	}
}
