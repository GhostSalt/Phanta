return {
    descriptions = {
        Back = {
            b_phanta_stormcaught = {
                name = 'Stormcaught Deck',
                text = {
                    "Gain an {C:attention,T:tag_uncommon}Uncommon Tag{} at",
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
                    "cards on {C:attention}final{}",
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
                    "{C:tarot,T:c_hanged_man}The Hanged Man{} when a",
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
            b_phanta_invisible = {
                name = 'Invisible Deck',
                text = {
                    "The {C:attention}Ace{} of {C:spades}Spades{}",
                    "starts with a {C:attention,T:phanta_ghostseal_seal}Ghost Seal{}"
                }
            },
            b_phanta_hivis = {
                name = 'Hi-Vis Deck',
                text = {
                    "Start run with the",
                    "{C:red,T:v_directors_cut}#1#{} Voucher"
                }
            },
            b_phanta_crate = {
                name = 'Crate Deck',
                text = {
                    "{C:attention}+#1#{} consumable slots"
                }
            },
            b_phanta_todayandtomorrow = {
                name = 'Today & Tomorrow Deck',
                text = {
                    --[["{C:phanta_zodiac}Zodiac{} cards may",
                    "appear in the shop,",]]                                      --
                    --[["Start with a copy of",
                    "{C:phanta_zodiac}Virgo{} and {C:phanta_zodiac}Capricorn{}"]] --
                    "{C:phanta_zodiac}Zodiac{} cards have",
                    "{C:attention}stronger{} abilities"
                }
            },
            b_phanta_hazel = {
                name = 'Hazel Deck',
                text = {
                    "All {C:attention}Boss Blinds{} are",
                    "the {C:attention,T:bl_final_acorn}Amber Acorn{}"
                }
            },
            b_phanta_spectrum = {
                name = 'Spectrum Deck',
                text = {
                    "Applies the effects of",
                    "{C:red,T:b_red}Red{}, {C:blue,T:b_blue}Blue{}, {C:money,T:b_yellow}Yellow{}, {C:green,T:b_green}Green{}",
                    "and {T:b_black}Black Deck{}, {C:attention}-#1#{}",
                    "Booster pack each {C:attention}shop{}"
                }
            },
            b_phanta_bloodred = {
                name = 'Blood Red Deck',
                text = {
                    "{C:red}+#1#{} discards",
                    "when selecting",
                    "any {C:attention}Boss Blind{}"
                }
            },
            b_phanta_deepblue = {
                name = 'Deep Blue Deck',
                text = {
                    "{C:blue}+#1#{} hands",
                    "when selecting",
                    "any {C:attention}Boss Blind{}"
                }
            },
            b_phanta_canaryyellow = {
                name = 'Canary Yellow Deck',
                text = {
                    "Start run with",
                    "a copy of",
                    "{C:attention,T:j_mail}Mail-In Rebate{}"
                }
            },
            b_phanta_meangreen = {
                name = 'Mean Green Deck',
                text = {
                    "Earn {C:money}$#1#{} of interest for",
                    "every {C:money}$5{} you have at",
                    "end of round, earn {C:money}$#2#{}",
                    "per remaining {C:blue}Hand{}"
                }
            },
            b_phanta_pitchblack = {
                name = 'Pitch Black Deck',
                text = {
                    "Start run with the",
                    "{C:red,T:v_overstock_norm}#1#{} Voucher"
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
                name = "Waxed",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
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
            },
            m_phanta_marblecard = {
                name = 'Marble Card',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if played",
                    "and not scored"
                }
            }
        },
        Joker = {
            j_phanta_bootleg               = {
                name = 'Bootleg',
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "{C:mult}+#2#{} Mult"
                }
            },
            j_phanta_dropdownlist          = {
                name = 'Drop-down List',
                text = {
                    "Sell this card to create",
                    "a random {C:attention}Joker{} card",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_trainstation          = {
                name = 'Train Station',
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "played and scored {C:attention}#2#{}, rank",
                    "increases each round",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
                }
            },
            j_phanta_hintcoin              = {
                name = 'Hint Coin',
                text = {
                    "Earn {C:money}$#1#{} when",
                    "you play your",
                    "{C:attention}second{} hand"
                }
            },
            j_phanta_dollarsign            = {
                name = 'Dollar Sign',
                text = {
                    "When hand is played,",
                    "earn {C:money}$#1#{} if your total",
                    "{C:money}money{} contains a {C:attention}5{}",
                    "in any position"
                }
            },
            j_phanta_yellow                = {
                name = 'Yellow',
                text = {
                    "Earn {C:money}$#1#{} on",
                    "{C:attention}odd{} rounds,",
                    "earn {C:money}$#2#{} on",
                    "{C:attention}even{} rounds"
                }
            },
            j_phanta_purplegoldenjoker     = {
                name = 'Purple Golden Joker',
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "for each held {C:tarot}Tarot{} card",
                    "{C:inactive}(Will give {C:money}$#2#{C:inactive}){}"
                }
            },
            j_phanta_holeinthejoker        = {
                name = 'Hole in the Joker',
                text = {
                    "Earn {C:money}$#1#{} at end of",
                    "round for each",
                    "empty {C:attention}Joker{} slot",
                    "{s:0.8}Hole in the Joker included{}",
                    "{C:inactive}(Will give {C:money}$#2#{C:inactive}){}"
                }
            },
            j_phanta_shootingstar          = {
                name = 'Shooting Star',
                text = {
                    "Gives {C:money}$#1#{} when a card",
                    "with {C:diamonds}Diamonds{} suit is",
                    "{C:red}destroyed{}, and increases",
                    "reward by {C:money}$#2#{}"
                }
            },
            j_phanta_puzzle                = {
                name = 'Puzzle',
                text = {
                    "Each played {C:attention}?{} gives",
                    "{C:money}$#1#{} when scored, {C:attention}?{} is",
                    "a {C:attention}secret{} rank which",
                    "changes each round"
                }
            },
            j_phanta_binman                = {
                name = 'Binman',
                text = {
                    "Gives {C:money}$#1#{} for",
                    "each {C:red}discarded{} {C:attention}Junk{}"
                }
            },
            j_phanta_onemanstrash          = {
                name = "One Man's Trash",
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "card {C:attention}discarded{} this round",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_anothermanstreasure   = {
                name = "Another Man's Treasure",
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult for each",
                    "card {C:attention}discarded{} this round",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_oracle                = {
                name = 'Oracle',
                text = {
                    "{C:attention}+1{} consumable slot"
                }
            },
            j_phanta_thief                 = {
                name = 'Thief',
                text = {
                    "{C:blue}+1{} hand",
                    "each round"
                }
            },
            j_phanta_detective             = {
                name = 'Detective',
                text = {
                    "{C:attention}+1{} card slot",
                    "in the shop"
                }
            },
            j_phanta_timetable             = {
                name = 'Timetable',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "Small Blind: {C:red}+#1#{} discard",
                    "Big Blind: {C:blue}+#2#{} hand",
                    "Boss Blind: {C:attention}+#3#{} hand size"
                }
            },
            j_phanta_mazebean              = {
                name = 'Maze Bean',
                text = {
                    "Sell this card to",
                    "permanently gain {C:attention}+#1#{}",
                    "hand size, increases",
                    "by 1 every {C:attention}#2#{} {C:inactive}[#3#]{} Antes"
                }
            },
            j_phanta_new2dsxl              = {
                name = 'New 2DS XL',
                text = {
                    "{C:attention}-#2#{} hand size",
                    "When {C:attention}Blind{} is selected,",
                    "gain {C:white,X:blue}X#1#{} Hands"
                }
            },
            j_phanta_playerpin             = {
                name = 'Player Pin',
                text = {
                    "The next {C:attention}3{} cards",
                    "in the deck are:",
                    "{V:1}#1#{}#2#{V:2}#3#{}",
                    "{V:3}#4#{}#5#{V:4}#6#{}",
                    "{V:5}#7#{}#8#{V:6}#9#{}"
                }
            },
            j_phanta_junpei                = {
                name = 'Junpei',
                text = {
                    "Played {C:attention}5s{} give",
                    "{C:mult}+#1#{} Mult when scored"
                }
            },
            j_phanta_sigma                 = {
                name = 'Sigma',
                text = {
                    "Retriggers all played",
                    "and scored {C:attention}Bonus{} cards"
                }
            },
            j_phanta_carlos                = {
                name = 'Carlos',
                text = {
                    "Gain {C:blue}+#1#{} hand#2# when",
                    "next {C:attention}Blind{} is selected,",
                    "increases by {C:attention}#3#{} when",
                    "selling a {C:attention}consumable{}"
                }
            },
            j_phanta_q                     = {
                name = 'Q',
                text = {
                    "If played hand contains",
                    "at least {C:attention}2 Queens{},",
                    "the first 2 give {C:white,X:mult}X#1#{}",
                    "Mult when scored"
                }
            },
            j_phanta_diana                 = {
                name = 'Diana',
                text = {
                    "Gains {C:mult}+#1#{} Mult for",
                    "each played and scored",
                    "{C:attention}Bonus{} card",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_redkeycards           = {
                name = 'Red Key Cards',
                text = {
                    "Gain {C:red}+#1#{} discards",
                    "when playing an",
                    "unscoring {C:attention}Mult{} card",
                    "{C:inactive}(Once per round,{}",
                    "{C:inactive}currently #2#){}"
                }
            },
            j_phanta_bluekeycards          = {
                name = 'Blue Key Cards',
                text = {
                    "Gain {C:blue}+3{} hands",
                    "when playing an",
                    "unscoring {C:attention}Bonus{} card",
                    "{C:inactive}(Once per round,{}",
                    "{C:inactive}currently #2#){}"
                }
            },
            j_phanta_kylehyde              = {
                name = 'Kyle Hyde',
                text = {
                    "Played cards with {C:hearts}Hearts{}",
                    "or {C:diamonds}Diamonds{} suit have a",
                    "{C:green}#1# in #2#{} chance to become",
                    "{C:attention}Stone{} cards when scored"
                }
            },
            j_phanta_inception             = {
                name = 'Inception',
                text = {
                    "{C:mult}+#1#{} Mult per hand",
                    "played this {C:attention}round{}",
                    "{C:inactive}(Will give {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_a1z26                 = {
                name = "A1Z26",
                text = {
                    "Leftmost played",
                    "and scored card",
                    "gives {C:mult}+#1#{} Mult if",
                    "it is an {C:attention}Ace{}"
                }
            },
            j_phanta_nonuniformday         = {
                name = "Non-Uniform Day",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "played {C:attention}Wild{} card to create",
                    "a {C:tarot}Tarot{} card when scored",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_badhairday            = {
                name = "Bad Hair Day",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "{C:attention}Wild{} card held in hand",
                    "to be destroyed"
                }
            },
            j_phanta_animalinstinct        = {
                name = "Animal Instinct",
                text = {
                    "Gains {C:mult}+#1#{} Mult when a",
                    "playing card is {C:red}destroyed{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_target                = {
                name = "Target",
                text = {
                    "Gains {C:mult}+#1#{} Mult when",
                    "{C:attention}final hand{} of",
                    "round is played",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_teastainedjoker       = {
                name = "Tea-Stained Joker",
                text = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:mult}+#3#{} Mult for each {C:attention}Lucky{}",
                    "card held in hand",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult){}"
                }
            },
            j_phanta_teabag                = {
                name = "Teabag",
                text = {
                    "When you play",
                    "your {C:attention}second{} hand,",
                    "{C:attention}2{} cards held in",
                    "hand become {C:attention}Lucky{}"
                }
            },
            j_phanta_forsakenscroll        = {
                name = "Forsaken Scroll",
                text = {
                    "{C:green}#1# in #2#{} chance to give",
                    "{C:white,X:mult}X#3#{} Mult, each {C:attention}Lucky{} card",
                    "in your {C:attention}full deck{}",
                    "increases the odds"
                }
            },
            j_phanta_exitsign              = {
                name = 'Exit Sign',
                text = {
                    "Earn {C:money}$#1#{} when hand",
                    "is played if {C:blue}0{} hands",
                    "and {C:red}0{} discards remain"
                }
            },
            j_phanta_task                  = {
                name = 'Task',
                text = {
                    "This Joker gains {C:money}$#1#{} when",
                    "using a consumable, {C:attention}cashout{}",
                    "when any {C:attention}Blind{} is skipped",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive}){}"
                }
            },
            j_phanta_saltcircle            = {
                name = 'Salt Circle',
                text = {
                    "Sets Chips",
                    "to {C:chips}#1#{}"
                }
            },
            j_phanta_thenecronomicon       = {
                name = 'The Necronomicon',
                text = {
                    "Sets Chips to {C:chips}#1#{} if",
                    "there are no {C:attention}6s{}",
                    "in your full deck",
                    "{C:inactive}(Currently #2#){}"
                }
            },
            j_phanta_stitchintime          = {
                name = 'Stitch in Time',
                text = {
                    "Gains {C:chips}+#1#{} Chips for",
                    "each {C:attention}9{} held in hand",
                    "at end of round",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}"
                }
            },
            j_phanta_shackles              = {
                name = 'Shackles',
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "forces {C:attention}1{} card to",
                    "always be selected"
                }
            },
            j_phanta_ghost                 = {
                name = 'Ghost',
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult for",
                    "each {C:tarot}Tarot{} card in",
                    "your {C:attention}consumable{} area",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_html                  = {
                name = 'HTML',
                text = {
                    "Played and {C:attention}unscored{}",
                    "cards give {C:mult}+#1#{} Mult"
                }
            },
            j_phanta_knowledgeofthecollege = {
                name = 'Knowledge of the College',
                text = {
                    "Played and {C:attention}unscored{}",
                    "{C:attention}Aces{} give {C:white,X:mult}X#1#{} Mult"
                }
            },
            j_phanta_theapparition         = {
                name = 'The Apparition',
                text = {
                    "Retriggers all played",
                    "and {C:attention}unscored{} cards"
                }
            },
            j_phanta_willothewisp          = {
                name = 'Will-o\'-the-wisp',
                text = {
                    "{C:attention}Ghost{} cards also give",
                    "their {C:white,X:mult}XMult{} when played",
                    "and {C:attention}unscored{}"
                }
            },
            j_phanta_stickercollection     = {
                name = 'Sticker Collection',
                text = {
                    "Retriggers the {C:attention}lowest{} played",
                    "and scored card {C:attention}#1#{} times",
                    "if played hand is a {C:attention}Junk{}"
                }
            },
            j_phanta_photocopy             = {
                name = 'Photocopy',
                text = {
                    "Each played and",
                    "scored card has a",
                    "{C:green}#1# in #2#{} chance to",
                    "be {C:attention}retriggered{}"
                }
            },
            j_phanta_doubledice            = {
                name = 'Double Dice',
                text = {
                    "Played and scored {C:attention}7s{}",
                    "give {C:mult}+#1#{} Mult for",
                    "each owned {C:blue}Common{} Joker",
                    "{C:inactive}(Will give {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_prognosticator        = {
                name = 'Prognosticator',
                text = {
                    "{C:phanta_zodiac}Zodiac{} cards have",
                    "{C:attention}stronger{} abilities"
                }
            },
            j_phanta_calendar              = {
                name = 'Calendar',
                text = {
                    "All {C:phanta_zodiac}Zodiac{} cards",
                    "corresponding to",
                    "today's {C:attention}date{} have",
                    "{C:attention}much stronger{} abilities",
                    "{C:inactive}(#1#){}"
                }
            },
            j_phanta_grimreaper            = {
                name = 'The Grim Reaper',
                text = {
                    "If hand is played",
                    "while {C:attention}holding{} a copy",
                    "of {C:purple}Death{}, {C:red}destroys{}",
                    "all played cards"
                }
            },
            j_phanta_professorlayton       = {
                name = 'Professor Layton',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "give {C:mult}+#3#{} Mult,",
                    "held {C:tarot}Tarot{} cards",
                    "increase the odds",
                    "{C:inactive,s:0.65}(Guaranteed if with Luke Triton){}"
                }
            },
            j_phanta_luketriton            = {
                name = 'Luke Triton',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "give {X:mult,C:white}X#3#{} Mult,",
                    "held {C:planet}Planet{} cards",
                    "increase the odds",
                    "{C:inactive,s:0.65}(Guaranteed if with Professor Layton){}"
                }
            },
            j_phanta_jeandescole           = {
                name = 'Jean Descole',
                text = {
                    "Upon discarding a {C:attention}Stone{}",
                    "card, {C:red}destroys{} it and creates",
                    "a copy of {C:tarot}The Devil{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_engineer              = {
                name = 'Engineer',
                text = {
                    "If played hand is",
                    "a {C:attention}Junk{}, creates a",
                    "copy of {C:tarot}The Chariot{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_medic                 = {
                name = 'Medic',
                text = {
                    "Creates a copy of {C:tarot}Death{} if",
                    "{C:attention}first hand{} of round contains",
                    "{C:attention}5{} cards with {C:hearts}Hearts{} suit",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_psychelock            = {
                name = 'Psyche-Lock',
                text = {
                    "Gives {C:white,X:mult}X#1#{} Mult",
                    "for each {C:attention}9{}",
                    "in played hand"
                }
            },
            j_phanta_milesedgeworth        = {
                name = 'Miles Edgeworth',
                text = {
                    "Gives {C:white,X:mult}X#1#{} Mult for",
                    "each {C:attention}Steel King{}",
                    "in your full deck",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_apollosbracelet       = {
                name = 'Apollo\'s Bracelet',
                text = {
                    "Retriggers all played",
                    "and scored cards",
                    "with {C:attention}enhancements{}"
                }
            },
            j_phanta_diamondaxe            = {
                name = 'Diamond Axe',
                text = {
                    "{C:attention}Copper Grate{} cards do",
                    "not {C:attention}oxidise{}, and this",
                    "Joker {C:attention}deoxidises{} them when",
                    "they are played and scored",
                }
            },
            j_phanta_honeydew              = {
                name = 'Honeydew',
                text = {
                    "When {C:attention}round{} begins,",
                    "adds {C:dark_edition}Waxed{} to one",
                    "random {C:attention}base edition{}",
                    "card in your hand"
                }
            },
            j_phanta_candle                = {
                name = 'Candle',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{C:red}destroys{} 1 {C:tarot}Tarot{} card",
                    "Gains {C:white,X:mult}X#1#{} Mult",
                    "if successful",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_goo                   = {
                name = 'Goo',
                text = {
                    "On {C:attention}final hand{} of",
                    "round, adds a",
                    "{C:blue}Blue{} seal to the",
                    "{C:attention}first{} scored card"
                }
            },
            j_phanta_web                   = {
                name = 'Web',
                text = {
                    "{C:mult}+#1#{} Mult if {C:attention}#2#{}",
                    "or more cards",
                    "held in hand",
                    "have {C:spades}Spades{} suit"
                }
            },
            j_phanta_cutcorners            = {
                name = 'Cut Corners',
                text = {
                    "Gains {C:mult}+#1#{} Mult if",
                    "played hand contains",
                    "{C:attention}#2#{} or fewer cards",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
                }
            },
            j_phanta_blottedjoker          = {
                name = 'Blotted Joker',
                text = {
                    "Gains {C:chips}+#1#{} Chips for each",
                    "played and scored {C:attention}Bonus{}",
                    "card, {C:attention}unenhances{} them",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}"
                }
            },
            j_phanta_bloodpact             = {
                name = 'Blood Pact',
                text = {
                    "Gains {C:mult}+#1#{} Mult for each",
                    "played and scored {C:attention}Mult{}",
                    "card, {C:attention}unenhances{} them",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_tnetennba             = {
                name = 'TNETENNBA',
                text = {
                    "Gains {C:mult}+#1#{} Mult if hand is",
                    "played while the cards held",
                    "in hand contain a {C:attention}Straight{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
                    "{C:inactive,s:0.75}(Doesn't currently support{}",
                    "{C:inactive,s:0.75}Four Fingers or Shortcut){}"
                }
            },
            j_phanta_technicolourjoker     = {
                name = 'Technicolour Joker',
                text = {
                    "Played {C:attention}Wild{} cards",
                    "give {C:mult}+#1#{} Mult",
                    "when scored"
                }
            },
            j_phanta_identity              = {
                name = 'Identity',
                text = {
                    "Creates #1# {C:dark_edition}Negative{}",
                    "{C:spectral}Spectral{} cards at",
                    "the end of the {C:attention}shop",
                    "{C:red,E:2}self destructs{}"
                }
            },
            j_phanta_tricolour             = {
                name = 'Tricolour',
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "hand contains exactly",
                    "{C:attention}3{} unique scoring {C:attention}suits{}"
                }
            },
            j_phanta_beadnecklace          = {
                name = 'Bead Necklace',
                text = {
                    "If played hand contains",
                    "a {C:attention}Straight{}, gains {C:mult}+#1#{} Mult",
                    "for each unique scoring {C:attention}suit{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
                    "{C:inactive,s:0.75}(Doesn't currently support{}",
                    "{C:inactive,s:0.75}custom suits){}"
                }
            },
            j_phanta_p5joker               = {
                name = 'Looking Cool, Joker!',
                text = {
                    "Gains {C:mult}+#1#{} Mult per hand",
                    "played that is not your",
                    "most played {C:attention}poker hand{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_crescent              = {
                name = 'Crescent',
                text = {
                    "Creates a {C:tarot}Tarot{} card when",
                    "a {C:planet}Planet{} card is sold",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_shoppinglist          = {
                name = 'Shopping List',
                text = {
                    "Gains {C:mult}+#1#{} Mult every",
                    "{C:attention}#2#{} {C:inactive}[#3#]{} cards {C:attention}purchased{}",
                    "from the shop",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult){}"
                }
            },
            j_phanta_ransomnote            = {
                name = 'Ransom Note',
                text = {
                    "Gives {C:money}$#1#{} every",
                    "{C:attention}#2#{} {C:inactive}[#3#]{} Jokers {C:attention}sold{}"
                }
            },
            j_phanta_purplejoker           = {
                name = 'Purple Joker',
                text = {
                    "Gains {C:mult}+#1#{} Mult if hand",
                    "is played while",
                    "{C:attention}holding{} any {C:tarot}Tarot{} cards",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_monetjoker            = {
                name = 'Monet Joker',
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "if {C:attention}discard{} has",
                    "only {C:attention}1{} card",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_charcoaljoker         = {
                name = 'Charcoal Joker',
                text = {
                    "Gains {C:mult}+#1#{} Mult if",
                    "all {C:red}discarded{} cards",
                    "are {C:spades}Spades{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_goldenfiddle          = {
                name = 'Golden Fiddle',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Devil{} or {C:tarot}The Chariot{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_reverie               = {
                name = 'Reverie',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Tower{} or {C:tarot}Temperance{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_sees                  = {
                name = 'S.E.E.S.',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}The Moon{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_scissorsaresharp      = {
                name = 'Scissors are Sharp',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a copy of",
                    "{C:tarot}Judgement{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_caesarcipher          = {
                name = 'Caesar Cipher',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a {C:planet}Planet{} card or",
                    "a copy of {C:tarot}Strength{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_timepiece             = {
                name = 'Timepiece',
                text = {
                    "On {C:attention}final hand{} of",
                    "round, creates a",
                    "copy of {C:tarot}Death{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_introspection         = {
                name = 'Introspection',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates a {V:1}#1#{} card and",
                    "changes type to {V:2}#2#{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_blindjoker            = {
                name = 'Blind Joker',
                text = {
                    "Creates the {C:planet}Planet{} card",
                    "for hands that contain",
                    "exactly #1# {C:attention}Aces{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_spaceinvader          = {
                name = 'Space Invader',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "creates {C:attention}#1#{} {C:planet}Planet{} cards if",
                    "your consumable slots are {C:attention}empty{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_witchsmark            = {
                name = "Witch's Mark",
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "if all played cards",
                    "are {C:attention}face cards{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_modernart             = {
                name = 'Modern Art',
                text = {
                    "Gains {C:money}$#1#{} of",
                    "{C:attention}sell value{} per",
                    "{C:attention}High Card{} played"
                }
            },
            j_phanta_sketch                = {
                name = 'Sketch',
                text = {
                    "Gives {C:white,X:mult}X#1#{} Mult for",
                    "each played card",
                    "that {C:attention}doesn't score{}"
                }
            },
            j_phanta_conspiracist          = {
                name = 'Conspiracist',
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a copy of {C:blue}Earth{} if",
                    "played hand is a {C:attention}Full House{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_wavyjoker             = {
                name = 'Wavy Joker',
                text = {
                    "When skipping any",
                    "{C:attention}Blind{}, creates {C:attention}#1#{}",
                    "{C:tarot}Tarot{} cards",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_slidingpuzzle         = {
                name = 'Sliding Puzzle',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "adds a random {C:attention}playing{}",
                    "{C:attention}card{} to your hand"
                }
            },
            j_phanta_sudoku                = {
                name = 'Sudoku',
                text = {
                    "Once {C:attention}A-9{} {C:inactive}[#1#]{} have",
                    "each been played and scored,",
                    "upgrades {C:attention}Straight{} by {C:attention}#2#{} level"
                }
            },
            j_phanta_ceaseanddesist        = {
                name = 'Cease & Desist',
                text = {
                    "Upgrades {C:attention}Straight{} by",
                    "{C:attention}#1#{} level when any",
                    "{C:attention}Booster Pack{} is skipped"
                }
            },
            j_phanta_thepolicemun          = {
                name = 'The Policemun',
                text = {
                    "When any {C:attention}Blind{}",
                    "is skipped, upgrades",
                    "{C:attention}Straight{} by {C:attention}#1#{} levels"
                }
            },
            j_phanta_nojoke                = {
                name = 'No Joke',
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "level in {C:attention}Straight{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_lotteryticket         = {
                name = 'Lottery Ticket',
                text = {
                    "If {C:attention}first hand{} of",
                    "round is a {C:attention}Straight{},",
                    "upgrades {C:attention}Straight Flush{}",
                    "by {C:attention}#1#{} level#2#"
                }
            },
            j_phanta_dottodot              = {
                name = 'Dot to Dot',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if {C:attention}previously{}",
                    "played hand contained",
                    "a {C:attention}Straight{}",
                    "{C:inactive}(Previous hand: {C:attention}#2#{C:inactive}){}"
                }
            },
            j_phanta_diningtable           = {
                name = 'Dining Table',
                text = {
                    "If played hand",
                    "contains a {C:attention}Full House{},",
                    "the {C:attention}pair{} of cards",
                    "become {C:attention}Glass{}"
                }
            },
            j_phanta_eyeofprovidence       = {
                name = 'Eye of Providence',
                text = {
                    "Each played",
                    "{C:attention}Ace of Spades{} gives",
                    "{C:white,X:mult}X#1#{} Mult when scored"
                }
            },
            j_phanta_emotionaldamage       = {
                name = 'Emotional Damage',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult per",
                    "discarded {C:attention}Flush{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_thespear              = {
                name = 'The Spear',
                text = {
                    "If scored hand contains any",
                    "{C:spades}Spade{} cards, destroys one",
                    "and upgrade {C:attention}Straight{}"
                }
            },
            j_phanta_thefuse               = {
                name = 'The Fuse',
                text = {
                    "If scored hand contains any",
                    "{C:hearts}Heart{} cards, destroys one",
                    "and gains {C:white,X:mult}X#1#{} Mult",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_themace               = {
                name = 'The Mace',
                text = {
                    "If scored hand contains any",
                    "{C:clubs}Club{} cards, destroys one",
                    "and gives {C:money}$#1#{}"
                }
            },
            j_phanta_thedagger             = {
                name = 'The Dagger',
                text = {
                    "If scored hand contains any",
                    "{C:diamonds}Diamond{} cards, destroys one",
                    "and gains {C:mult}+#1#{} Mult",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_corkboard             = {
                name = 'Corkboard',
                text = {
                    "If played hand contains",
                    "a {C:attention}Straight{}, destroys {C:attention}1{}",
                    "random card held in hand"
                }
            },
            j_phanta_evidence              = {
                name = 'Evidence',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult when a",
                    "{C:attention}Stone{} card is {C:red}destroyed{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_lily                  = {
                name = 'Lily',
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains exactly {C:attention}1{}",
                    "card with {C:diamonds}Diamonds{} suit"
                }
            },
            j_phanta_selfportrait          = {
                name = 'Self-portrait',
                text = {
                    "After #2# rounds, {C:attention}duplicates{}",
                    "the next Joker you {C:attention}buy{}",
                    "{C:red,E:2}self destructs{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#){}",
                    "{C:inactive}(Removes {C:dark_edition}Negative{C:inactive} from copy){}"
                }
            },
            j_phanta_caniossoul            = {
                name = 'Canio\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses",
                    "{C:white,X:mult}X#1#{} Mult if played",
                    "hand contains any",
                    "{C:attention}face cards{}"
                }
            },
            j_phanta_tribouletssoul        = {
                name = 'Triboulet\'s Soul',
                text = {
                    "{C:white,X:mult}X#1#{} Mult for {C:attention}#2#{} hand#3#,",
                    "gains {C:attention}+#4#{} hands if played",
                    "hand contains a scoring",
                    "{C:attention}King{} and {C:attention}Queen{}"
                }
            },
            j_phanta_chicotssoul           = {
                name = 'Chicot\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{}",
                    "Mult when you play",
                    "your {C:attention}second{} hand"
                }
            },
            j_phanta_yorickssoul           = {
                name = 'Yorick\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{}",
                    "Mult at the end of",
                    "the round if any",
                    "{C:red}discards{} weren't used"
                }
            },
            j_phanta_perkeossoul           = {
                name = 'Perkeo\'s Soul',
                text = {
                    "{C:white,X:mult}X#2#{} Mult, loses {C:white,X:mult}X#1#{} Mult",
                    "at the end of the round",
                    "if any {C:attention}consumable{} slots",
                    "are {C:attention}empty{}"
                }
            },
            j_phanta_spectretile           = {
                name = 'Spectre Tile',
                text = {
                    "When a Joker is",
                    "{C:attention}purchased{}, {C:green}#1# in #2#{} chance",
                    "to create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_phanta_possession            = {
                name = 'Possession',
                text = {
                    "When a Joker is",
                    "{C:attention}purchased, {C:green}#1# in #2#{}",
                    "chance to make",
                    "it {C:dark_edition}Negative{}"
                }
            },
            j_phanta_normalface            = {
                name = 'Normal Face',
                text = {
                    "{C:mult}+#1#{} Mult,",
                    "highly annoying"
                }
            },
            j_phanta_absentjoker           = {
                name = 'Absent Joker',
                text = {
                    "{C:mult}+#1#{} Mult if",
                    "exactly {C:attention}1{} Joker",
                    "slot is {C:attention}empty{}"
                }
            },
            j_phanta_fanta                 = {
                name = 'Fanta',
                text = {
                    "Sell this Joker to",
                    "add a {C:attention}Gold Seal{}",
                    "to {C:attention}1{} random",
                    "card in your hand"
                }
            },
            j_phanta_heartbreak            = {
                name = 'Heartbreak',
                text = {
                    "Played cards with {C:hearts}Hearts{}",
                    "suit give {C:white,X:mult}X#1#{} Mult when",
                    "scored, each has a {C:green}#2# in #3#{}",
                    "chance to be {C:red}destroyed{}"
                }
            },
            j_phanta_distance              = {
                name = 'Distance',
                text = {
                    "{C:chips}+#1#{} Chips,",
                    "{C:attention}-1{} card slot",
                    "in the shop"
                }
            },
            j_phanta_donpaolo              = {
                name = 'Don Paolo',
                text = {
                    "If a {C:attention}single{} card",
                    "is selected, selling",
                    "a {C:tarot}Tarot{} card will",
                    "{C:red}destroy{} it"
                }
            },
            j_phanta_futureluke            = {
                name = 'Future Luke',
                text = {
                    "If a {C:attention}single{} card",
                    "is selected, selling",
                    "a {C:planet}Planet{} card will",
                    "{C:red}destroy{} it"
                }
            },
            j_phanta_barton                = {
                name = 'Barton',
                text = {
                    "{C:mult}+#1#{} Mult if at least",
                    "{C:attention}#2#{} unique {C:tarot}Tarot{} cards",
                    "have been used this run",
                    "{C:inactive}({C:attention}#3#/#2#{C:inactive}, #4#){}",
                    "{C:inactive,s:0.65}(Active if with Inspector Chelmey){}"
                }
            },
            j_phanta_inspectorchelmey      = {
                name = 'Inspector Chelmey',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if at least",
                    "{C:attention}#2#{} unique {C:planet}Planet{} cards",
                    "have been used this run",
                    "{C:inactive}({C:attention}#3#/#2#{C:inactive}, #4#){}",
                    "{C:inactive,s:0.65}(Active if with Barton){}"
                }
            },
            j_phanta_zeroii                = {
                name = 'Zero II',
                text = {
                    "On first {C:red}discard{} of",
                    "round, each discarded",
                    "card has a {C:green}#1# in #2#{}",
                    "chance to be {C:red}destroyed{}"
                }
            },
            j_phanta_valantgramarye        = {
                name = "Valant Gramarye",
                text = {
                    "{C:attention}Straights{} count as",
                    "{C:attention}Straight Flushes{}",
                    "and vice versa"
                }
            },
            j_phanta_snoinches             = {
                name = "Snoinches",
                text = {
                    "After hand is",
                    "played, {C:attention}draw{} the",
                    "{C:attention}leftmost{} played card",
                    "back to your {C:attention}hand{}"
                }
            },
            j_phanta_bloodyace             = {
                name = "Bloody Ace",
                text = {
                    "Hands containing",
                    "{C:attention}2 Aces{} count as",
                    "{C:attention}Full Houses{}"
                }
            },
            j_phanta_clapperboard          = {
                name = "Clapperboard",
                text = {
                    "Reroll Boss Blind",
                    "{C:attention}unlimited{} times,",
                    "{C:money}$10{} per roll",
                }
            },
            j_phanta_birthdaycard          = {
                name = 'Birthday Card',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult when",
                    "a card with {C:dark_edition}Waxed{}",
                    "edition is {C:red}destroyed{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_plugsocket            = {
                name = 'Plug Socket',
                text = {
                    "{C:white,X:mult}X#1#{} Mult for each {C:dark_edition}base{}",
                    "edition {C:attention}Copper Grate{} card",
                    "in your {C:attention}full deck{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_neonjoker             = {
                name = 'Neon Joker',
                text = {
                    "{C:white,X:mult}X#1#{} Mult if hand",
                    "is played with at",
                    "least {C:attention}4 distinct{}",
                    "{C:attention}suits{} held in hand"
                }
            },
            j_phanta_technojoker           = {
                name = 'Techno Joker',
                text = {
                    "{C:white,X:mult}X#1#{} Mult for each",
                    "rank {C:red}absent{} from",
                    "your {C:attention}full deck{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_ignaize               = {
                name = 'Ignaize',
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when a",
                    "{C:attention}consumable{} card is {C:attention}sold{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_dimere                = {
                name = 'Dimere',
                text = {
                    "When {C:attention}Boss Blind{} is defeated,",
                    "1 random {C:attention}Joker{} becomes",
                    "{C:negative}Negative{} {C:inactive}(except Dimeres{}",
                    "{C:inactive}or Jokers with editions){}"
                }
            },
            j_phanta_goldor                = {
                name = 'Goldor',
                text = {
                    "Played {C:attention}Gold{} cards",
                    "each give {C:money}$#2#{} and",
                    "{C:white,X:mult}X#1#{} Mult when scored"
                }
            },
            j_phanta_famalia               = {
                name = 'Famalia',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "adds a {C:attention}King{} with a",
                    "{C:purple}Purple{} seal and {C:dark_edition}edition",
                    "to your hand"
                }
            },
            j_phanta_godoor                = {
                name = 'Godoor',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult at the",
                    "end of the {C:attention}shop{} if you",
                    "used exactly {C:attention}1{} {C:green}Reroll{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive} Mult){}"
                }
            },
            j_phanta_fainfol               = {
                name = 'Fainfol',
                text = {
                    "Each {V:1}#1#{} card held",
                    "in hand gives {C:white,X:mult}X#2#{} Mult,",
                    "suit changes every round"
                }
            },
            j_phanta_granwyrm              = {
                name = 'Granwyrm',
                text = {
                    "Gains {C:white,X:mult}X#1#{} Mult every",
                    "{C:attention}#2#{} {C:inactive}[#3#]{} cards played",
                    "and {C:attention}unscored{}",
                    "{C:inactive}(Currently {C:white,X:mult}X#4#{C:inactive} Mult){}"
                }
            },
            j_phanta_                      = {

            },







            -- Original ability text implied that unscored 2-5s were retriggered.
            j_hack = {
                name = 'Hack',
                text = {
                    "Retrigger",
                    "each played",
                    "and scored",
                    "{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{}"
                },
            },

            -- Original ability text implied that unscored face cards were retriggered.
            j_sock_and_buskin = {
                name = 'Sock and Buskin',
                text = {
                    "Retrigger all",
                    "played and scored",
                    "{C:attention}face{} cards"
                },
            }
        },
        Other = {
            p_phanta_zodiac_normal1 = {
                name = "Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_normal2 = {
                name = "Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_normal3 = {
                name = "Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_normal4 = {
                name = "Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_jumbo1 = {
                name = "Jumbo Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_jumbo2 = {
                name = "Jumbo Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_mega1 = {
                name = "Mega Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            p_phanta_zodiac_mega2 = {
                name = "Mega Zodiac Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:phanta_zodiac} Zodiac{} cards",
                    "to take",
                },
            },
            undiscovered_phanta_zodiac = {
                name = "Not Discovered",
                text = {
                    "Obtain this card in",
                    "an unseeded run to",
                    "learn what it does",
                },
            },
            undiscovered_phanta_starterpack = {
                name = "Not Discovered",
                text = {
                    "Open this pack",
                    "in an unseeded run",
                    "to learn what it does"
                },
            },
        },
        Partner = {
            pnr_phanta_ghost = {
                name = "Spooky",
                text = {
                    "{C:tarot}Tarot{} cards",
                    "in your consumable",
                    "area give {C:white,X:mult}X#1#{} Mult"
                },
                unlock = {
                    "Used {C:attention}Ghost{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_cutcorners = {
                name = "Rushed",
                text = {
                    "Vanilla hands with",
                    "{C:attention}4{} or fewer {C:attention}scoring{}",
                    "{C:attention}cards{} start at {C:attention}level #1#{}"
                },
                unlock = {
                    "Used {C:attention}Cut Corners{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_cutcorners_1 = {
                name = "Rushed",
                text = {
                    "{C:white,X:mult}X#2#{} Mult if hand is",
                    "played with at most",
                    "{C:blue}#3#{} hands remaining"
                },
                unlock = {
                    "Used {C:attention}Cut Corners{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_conspiracist = {
                name = "Theorist",
                text = {
                    "Start with {C:attention}#1#{}",
                    "{C:dark_edition}Negative{} copies",
                    "of {C:planet}Earth{}"
                },
                unlock = {
                    "Used {C:attention}Conspiracist{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_conspiracist_1 = {
                name = "Theorist",
                text = {
                    "All {C:attention}Two Pairs{}",
                    "count as {C:attention}Full Houses{}"
                },
                unlock = {
                    "Used {C:attention}Conspiracist{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_nojoke = {
                name = "Serious",
                text = {
                    "Straight starts",
                    "at {C:attention}level #1#{}"
                },
                unlock = {
                    "Used {C:attention}No Joke{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            },
            pnr_phanta_nojoke_1 = {
                name = "Serious",
                text = {
                    "When {C:attention}Boss Blind{} is",
                    "selected, upgrades {C:attention}Straight{}",
                    "by {C:attention}#2#{} level"
                },
                unlock = {
                    "Used {C:attention}No Joke{}",
                    "to win on {C:attention}Gold{}",
                    "{C:attention}Stake{} difficulty",
                }
            }
        },
        Sleeve = {
            sleeve_phanta_stormcaught = {
                name = "Stormcaught Sleeve",
                text = {
                    "Gain an {C:attention,T:tag_uncommon}Uncommon Tag{} at the start of the",
                    "{C:attention}run{}, and after defeating each {C:attention}Boss Blind{}"
                }
            },
            sleeve_phanta_stormcaught_alt = {
                name = "Stormcaught Sleeve",
                text = {
                    "Gain an {C:attention,T:tag_uncommon}Uncommon Tag{} after",
                    "defeating each {C:attention}Small or Big Blind{}"
                }
            },
            sleeve_phanta_blurple = {
                name = "Blurple Sleeve",
                text = {
                    "When {C:attention}Blind{} is selected, gain a",
                    "random {C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "{C:inactive}(Must have room){}"
                }
            },
            sleeve_phanta_azran = {
                name = "Azran Sleeve",
                text = {
                    "Very powerful {C:spectral}Spectral{}",
                    "cards may appear"
                }
            },
            sleeve_phanta_azran_alt = {
                name = "Azran Sleeve",
                text = {
                    "{C:spectral}Spectral{} cards may",
                    "appear in the {C:attention}shop{},",
                    "start with a {C:spectral,T:c_phanta_shard}Shard{} card"
                }
            },
            sleeve_phanta_badd = {
                name = "Badd Sleeve",
                text = {
                    "{C:red}Destroys{} all played cards on",
                    "{C:attention}final hand{} of round"
                }
            },
            sleeve_phanta_badd_alt = {
                name = "Badd Sleeve",
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}1{} card, {C:red}destroys{} it"
                }
            },
            sleeve_phanta_silver = {
                name = "Silver Sleeve",
                text = {
                    "Played and {C:attention}unscored{}",
                    "cards give {C:money}$#1#{}",
                    "{C:red}-#2#{} hand size"
                }
            },
            sleeve_phanta_silver_alt = {
                name = "Silver Sleeve",
                text = {
                    "{C:attention}+#1#{} hand size"
                }
            },
            sleeve_phanta_tally = {
                name = "Tally Sleeve",
                text = {
                    "The first time you select the",
                    "{C:attention}Small Blind{} of {C:attention}Ante 5{},",
                    "destroys {C:red}1{} Joker and gain {C:attention}+#1#{} Joker slot"
                }
            },
            sleeve_phanta_tally_alt = {
                name = "Tally Sleeve",
                text = {
                    "The deck no longer",
                    "{C:red}destroys{} any Jokers"
                }
            },
            sleeve_phanta_trickster = {
                name = "Trickster Sleeve",
                text = {
                    "Creates a copy of {C:tarot,T:c_hanged_man}The Hanged Man{} when a",
                    "{C:attention}playing card{} is added to your deck",
                    "{C:inactive}(Must have room){}"
                }
            },
            sleeve_phanta_barrier = {
                name = "Barrier Sleeve",
                text = {
                    "When skipping a {C:attention}Booster Pack{}, gain",
                    "{C:attention}+1{} hand size next round"
                }
            },
            sleeve_phanta_poltergeist = {
                name = 'Poltergeist Sleeve',
                text = {
                    "{C:attention}+#1#{} hand size",
                    "Cards are drawn {C:attention}face down{} if the number",
                    "of face down cards is less than {C:attention}#1#{}"
                }
            },
            sleeve_phanta_poltergeist_alt = {
                name = 'Poltergeist Sleeve',
                text = {
                    "{C:attention}+#1#{} hand size",
                    "{C:attention}+#1#{} face-down cards"
                }
            },
            sleeve_phanta_invisible = {
                name = 'Invisible Sleeve',
                text = {
                    "The {C:attention}Ace{} of {C:spades}Spades{}",
                    "starts with a {C:attention,T:phanta_ghostseal_seal}Ghost Seal{}"
                }
            },
            sleeve_phanta_invisible_alt = {
                name = 'Invisible Sleeve',
                text = {
                    "The {C:attention}Ace{} of {C:spades}Spades{}",
                    "starts as a {C:attention,T:m_phanta_ghostcard}Ghost Card{}"
                }
            },
            sleeve_phanta_hivis = {
                name = 'Hi-Vis Sleeve',
                text = {
                    "Start run with the",
                    "{C:red,T:v_directors_cut}#1#{} Voucher"
                }
            },
            sleeve_phanta_hivis_alt = {
                name = 'Hi-Vis Sleeve',
                text = {
                    "Start run with the",
                    "{C:red,T:v_retcon}#1#{} Voucher"
                }
            },
            sleeve_phanta_crate = {
                name = 'Crate Sleeve',
                text = {
                    "{C:attention}+#1#{} consumable slots"
                }
            },
            sleeve_phanta_todayandtomorrow = {
                name = 'Today & Tomorrow Sleeve',
                text = {
                    "{C:phanta_zodiac}Zodiac{} cards have",
                    "{C:attention}stronger{} abilities"
                }
            },
            sleeve_phanta_hazel = {
                name = 'Hazel Sleeve',
                text = {
                    "All {C:attention}Boss Blinds{} are",
                    "the {C:attention,T:bl_final_acorn}Amber Acorn{}"
                }
            },
            sleeve_phanta_hazel_alt = {
                name = 'Hazel Sleeve',
                text = {
                    "All {C:attention}Blinds{} are",
                    "the {C:attention,T:bl_final_acorn}Amber Acorn{}"
                }
            },
            sleeve_phanta_spectrum = {
                name = 'Spectrum Sleeve',
                text = {
                    "Applies the effects of",
                    "{C:red,T:b_red}Red{}, {C:blue,T:b_blue}Blue{}, {C:money,T:b_yellow}Yellow{}, {C:green,T:b_green}Green{}",
                    "and {T:b_black}Black Deck{}, {C:attention}-#1#{}",
                    "Booster Pack each {C:attention}shop{}"
                }
            },
            sleeve_phanta_spectrum_alt = {
                name = 'Spectrum Sleeve',
                text = {
                    "The deck no longer has",
                    "its {C:attention}Booster Pack{} downside"
                }
            },
            sleeve_phanta_bloodred = {
                name = 'Blood Red Sleeve',
                text = {
                    "{C:red}+#1#{} discards when selecting",
                    "any {C:attention}Boss Blind{}"
                }
            },
            sleeve_phanta_deepblue = {
                name = 'Deep Blue Sleeve',
                text = {
                    "{C:blue}+#1#{} hands when selecting",
                    "any {C:attention}Boss Blind{}"
                }
            },
            sleeve_phanta_canaryyellow = {
                name = 'Canary Yellow Sleeve',
                text = {
                    "Start run with a copy",
                    "of {C:attention,T:j_mail}Mail-In Rebate{}"
                }
            },
            sleeve_phanta_canaryyellow_alt = {
                name = 'Canary Yellow Sleeve',
                text = {
                    "{C:attention,T:j_mail}Mail-In Rebate{} is",
                    "{C:dark_edition}Negative{} and {C:eternal}Eternal{}"
                }
            },
            sleeve_phanta_meangreen = {
                name = 'Mean Green Sleeve',
                text = {
                    "Earn {C:money}$#1#{} of interest for",
                    "every {C:money}$5{} you have at",
                    "end of round, earn {C:money}$#2#{}",
                    "per remaining {C:blue}Hand{}"
                }
            },
            sleeve_phanta_meangreen_alt = {
                name = 'Mean Green Sleeve',
                text = {
                    "Earn {C:money}$#3#{} more interest"
                }
            },
            sleeve_phanta_pitchblack = {
                name = 'Pitch Black Sleeve',
                text = {
                    "Start run with the",
                    "{C:red,T:v_overstock_norm}#1#{} Voucher"
                }
            },
            sleeve_phanta_pitchblack_alt = {
                name = 'Pitch Black Sleeve',
                text = {
                    "Start run with the",
                    "{C:red,T:v_overstock_plus}#1#{} Voucher"
                }
            }
        },
        BakeryCharm = {
            BakeryCharm_phanta_timingiseverything = {
                name = 'Timing is Everything',
                text = {
                    "Has the ability of",
                    "the {C:phanta_zodiac}Zodiac{} card",
                    "corresponding to today's",
                    "date, but much stronger"
                }
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
                    "Add {C:dark_edition}Waxed{} to {C:attention}#1#{}",
                    "selected cards in hand",
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
        },
        Tag = {
            tag_phanta_sol = {
                name = "Sol Tag",
                text = {
                    "Gives a free",
                    "{C:phanta_zodiac}Jumbo Zodiac Pack{}"
                },
            }
        },
        phanta_Zodiac = {
            c_phanta_aries = {
                name = "Aries",
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "when {C:attention}#1#{}hand is played",
                    "{C:inactive}(Must have room){}"
                },
            },
            c_phanta_taurus = {
                name = "Taurus",
                text = {
                    "Retriggers the {C:attention}first{}",
                    "played card used",
                    "in scoring {C:attention}#1#{} time#2#"
                },
            },
            c_phanta_gemini = {
                name = "Gemini",
                text = {
                    "Earn {C:money}$#1#{} if played",
                    "hand contains a",
                    "{C:attention}Two Pair{}"
                },
            },
            c_phanta_cancer = {
                name = "Cancer",
                text = {
                    "Played cards with",
                    "{C:clubs}Clubs{} suit give",
                    "{C:chips}+#1#{} Chips when scored"
                },
            },
            c_phanta_leo = {
                name = "Leo",
                text = {
                    "Played cards with",
                    "{C:hearts}Hearts{} suit give",
                    "{C:mult}+#1#{} Mult when scored"
                },
            },
            c_phanta_virgo = {
                name = "Virgo",
                text = {
                    "If {C:attention}Blind{} is defeated",
                    "in #1#{C:blue}#2#{} hand#3#,#4#",
                    "#5#a {C:attention}Standard{} Tag"
                },
            },
            c_phanta_libra = {
                name = "Libra",
                text = {
                    "Played cards with",
                    "{C:spades}Spades{} suit give",
                    "{C:white,X:mult}X#1#{} Mult when scored"
                },
            },
            c_phanta_scorpio = {
                name = "Scorpio",
                text = {
                    "Played cards with",
                    "{C:diamonds}Diamonds{} suit",
                    "create {C:planet}Planet{} cards#1#",
                    "#2#when scored",
                    "{C:inactive}(Must have room){}"
                },
            },
            c_phanta_sagittarius = {
                name = "Sagittarius",
                text = {
                    "{C:red}+#1#{} discard#2#",
                    "each round"
                },
            },
            c_phanta_capricorn = {
                name = "Capricorn",
                text = {
                    "Earn {C:money}$#1#{} for each",
                    "{C:attention}reroll{} in the shop"
                },
            },
            c_phanta_aquarius = {
                name = "Aquarius",
                text = {
                    "{C:blue}+#1#{} hand#2#",
                    "each round"
                }
            },
            c_phanta_pisces = {
                name = "Pisces",
                text = {
                    "Gains {C:money}$#1#{} of {C:attention}sell{}",
                    "{C:attention}value{} for each",
                    "skipped {C:attention}Booster Pack{}"
                },
            },
            c_phanta_darkhour = {
                name = "Dark Hour",
                text = {
                    "Played cards with",
                    "{C:clubs}Clubs{} suit give",
                    "{C:white,X:mult}X#1#{} Mult if unscored"
                },
            }
        },
        phanta_StarterPack = {
            c_phanta_performerpack = {
                name = "Performer Pack",
                text = {
                    "Contains:",
                    "1 {C:attention}Mult{} Jack of Hearts",
                    "{C:attention}Random{} 2, 3, 4, 5 of Hearts"
                }
            },
            c_phanta_polyculepack = {
                name = "Polycule Pack",
                text = {
                    "Contains:",
                    "1 {C:attention}random{} Queen of Hearts",
                    "3 {C:attention}random{} Queens",
                    "1 {C:attention}random{} Ace of Hearts",
                }
            },
            c_phanta_powerhousepack = {
                name = "Powerhouse Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Red Seal Steel{}",
                    "King of Hearts",
                    "2 {C:attention}random{} cards"
                }
            },
            c_phanta_passionatepack = {
                name = "Passionate Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}random{} Hearts",
                    "1 {C:dark_edition}Polychrome{} Heart",
                    "2 {C:attention}Stone{} cards"
                }
            },
            c_phanta_plazapack = {
                name = "Plaza Pack",
                text = {
                    "Contains:",
                    "1 {C:attention}Bonus{} Queen of Clubs",
                    "3 {C:attention}random face{} cards",
                }
            },
            c_phanta_palacepack = {
                name = "Palace Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Glass{} King of Clubs",
                    "3 {C:attention}Stone{} cards",
                }
            },
            c_phanta_plentifulpack = {
                name = "Plentiful Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}random{} Jack of Clubs",
                    "1 {C:attention}Steel{} card",
                    "1 {C:attention}Gold{} card",
                    "1 {C:attention}Glass{} card",
                }
            },
            c_phanta_partypack = {
                name = "Party Pack",
                text = {
                    "Contains:",
                    "4 {C:attention}random{} Clubs",
                    "1 {C:dark_edition}Holographic{} Club"
                }
            },
            c_phanta_pilfererpack = {
                name = "Pilferer Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Mult{} Jack of Diamonds",
                    "1 {C:purple}Purple{} seal Jack",
                    "1 {C:attention}random{} Queen",
                }
            },
            c_phanta_prettypack = {
                name = "Pretty Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Bonus{} Queen of Diamonds",
                    "1 {C:blue}Blue{} seal Queen",
                    "1 {C:attention}random{} Jack",
                }
            },
            c_phanta_privilegedpack = {
                name = "Privileged Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Gold{} King of Diamonds",
                    "3 {C:attention}random Glass{} cards",
                }
            },
            c_phanta_pompouspack = {
                name = "Pompous Pack",
                text = {
                    "Contains:",
                    "3 {C:attention}random{} Diamonds",
                    "2 {C:attention}Gold Seal{} Diamonds"
                }
            },
            c_phanta_piratepack = {
                name = "Pirate Pack",
                text = {
                    "Contains:",
                    "3 {C:attention}Lucky{} Jack of Spades",
                    "1 {C:attention}Gold{} Ace of Diamonds",
                    "1 {C:attention}Steel{} King of Spades"
                }
            },
            c_phanta_punitivepack = {
                name = "Punitive Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}Foil{} Queen of Spades",
                    "3 {C:attention}random{} cards"
                }
            },
            c_phanta_presidentpack = {
                name = "President Pack",
                text = {
                    "Contains:",
                    "2 {C:attention}random{} King of Spades",
                    "2 {C:attention}random{} Kings"
                }
            },
            c_phanta_pointypack = {
                name = "Pointy Pack",
                text = {
                    "Contains:",
                    "4 {C:attention}random{} Spades",
                    "1 {C:dark_edition}Foil{} Spade"
                }
            },
            c_phanta_paranormalpack = {
                name = "Paranormal Pack",
                text = {
                    "Contains:",
                    "3 {C:attention}Ghost{} cards",
                    "1 {C:attention}Ghost{} seal card"
                }
            },
            c_phanta_potmakerpack = {
                name = "Potmaker Pack",
                text = {
                    "Contains:",
                    "1 {C:dark_edition}Waxed{} {C:attention}Copper Grate{} card",
                    "3 {C:attention}Copper Grate{} cards"
                }
            },
            c_phanta_plinthmakerpack = {
                name = "Plinthmaker Pack",
                text = {
                    "Contains:",
                    "4 {C:attention}Marble{} cards"
                }
            }
        }
    },
    misc = {
        dictionary = {
            phanta_chips_equals = "Chips=",
            phanta_mult_equals = "Mult=",
            phanta_swapped = "Swapped",
            phanta_become_glass = "Glass",
            phanta_copper_grate_fresh = "Fresh",
            phanta_copper_grate_exposed = "Exposed",
            phanta_copper_grate_weathered = "Weathered",
            phanta_copper_grate_oxidised = "Oxidised",
            phanta_active = "active",
            phanta_inactive = "inactive",
            phanta_unknown = "Unknown",
            phanta_increased = "Increased",
            phanta_azran_exclusive = "Azran Deck",
            b_phanta_zodiac_cards = "Zodiac Cards",
            k_phanta_zodiac = "Zodiac",
            k_phanta_zodiac_pack = "Zodiac Pack",
            b_phanta_starterpack_cards = "Starter Packs",
            k_phanta_starterpack = "Starter Pack",
            plus_standard_tag = '+Standard Tag',
            phanta_aries_second = "second ",
            phanta_plural = "s",
            phanta_virgo_at_most = "at most ",
            phanta_virgo_creates_a = " creates",
            phanta_virgo_creates_b = "creates ",
            phanta_scorpio_extra_a = " for",
            phanta_scorpio_extra_b = "played hand ",
            phanta_lucky = "Lucky",
            a_hand = "+1 Hand",
            phanta_created_blue_seal = "+Blue Seal",
            phanta_created_gold_seal = "+Gold Seal",

            credit_goat3730 = "OC by goat3730",
            credit_bobisnotaperson = "bobisnotaperson's Truesona",

            phanta_junk_enabled = "Enable Junk (Poker Hand)",
            phanta_zodiac_enabled = "Zodiac Cards",
            phanta_starter_pack_enabled = "Starter Packs",
            phanta_disable_animations = "Disable Animations",

            phanta_credit_1 = "Mod by GhostSalt",
            phanta_credit_2 = "Ability brainstorming: BakersDozenBagels",
            phanta_credit_3 = "and help from the Balatro Discord server"
        },
        labels = {
            phanta_ghostcard = "Ghost Card",
            phanta_ghostseal_seal = "Ghost Seal",
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
        quips = {
            pnr_phanta_ghost_1 = {
                "oooOOOooo"
            },
            pnr_phanta_ghost_2 = {
                "Boo!"
            },
            pnr_phanta_ghost_3 = {
                "I hope I'm not",
                "too scary!"
            },
            pnr_phanta_ghost_4 = {
                "Try not to",
                "get spooked!"
            },
            pnr_phanta_ghost_5 = {
                "Awawa!"
            },
            pnr_phanta_ghost_6 = {
                "I know you possess",
                "the skills to win!"
            },
            pnr_phanta_ghost_7 = {
                "Don't worry, I",
                "won't ghost you!"
            },
            pnr_phanta_ghost_8 = {
                "This run isn't",
                "gonna die!"
            }
        },
        v_dictionary = {
            a_discards = '+#1# Discards',
            s_discards = '-#1# Discards',
            a_discard = '+#1# Discard',
            s_discard = '-#1# Discard',
            a_hand = "+#1# Hand",
            s_hand = "-#1# Hand",
            s_hands = "-#1# Hands",
            a_tarots = "+#1# Tarots",
        }
    }
}
