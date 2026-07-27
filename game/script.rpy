## script.rpy — The Aetheric Engine
## Phase 2: Structural Port

## ─────────────────────────────────────────────
## Variable Initialization
## ─────────────────────────────────────────────
default grace_points = 0
default materialism_points = 0
default uriel_conductance = 0

## Diagnostic Kit Variables
default has_harrow_kit = False
default active_tool = "None" # Can be "SQUID", "THERMAL", or "MIC"

## ─────────────────────────────────────────────
## Audio Channels & Assets
## ─────────────────────────────────────────────
# We will define custom channels for the dual-frequency horror.
init python:
    renpy.music.register_channel("treble", mixer="sfx", loop=True)
    renpy.music.register_channel("infrasonic", mixer="sfx", loop=True)

## Placeholder audio definitions
define audio.treble_1985 = "audio/treble_1985.ogg"
define audio.infrasonic_throb = "audio/infrasonic_throb.ogg"
define audio.city_traffic = "audio/city_traffic.ogg"
define audio.valve_hiss = "audio/valve_hiss.ogg"

## ─────────────────────────────────────────────
## Character definitions
## ─────────────────────────────────────────────
define rowan = Character("Rowan", color="#c8a96e", what_italic=True)
define terminal = Character("TERMINAL", color="#33ff33", what_font="gui/fonts/Courier.ttf")

## ─────────────────────────────────────────────
## The story begins
## ─────────────────────────────────────────────

label start:
    ## ── BEAT 1: THE PROLOGUE (Narration) ──
    scene black with fade
    
    rowan "Most archives begin quietly. A box of letters. A ledger misfiled in a university basement."
    rowan "The Richmond House archive was no different. It arrived on Dr. Harrow's desk in a standard banker's box."
    rowan "It was the physical decay of the documents that refused to stay quiet."
    
    # Placeholder for Victorian workroom visualization
    rowan "In 1856, a small group gathered at Richmond House to conduct an experiment. Their goal was not mysticism or Spiritualist table-turning."
    rowan "They were attempting to physically manipulate Michael Faraday's Lines of Force—the invisible topological geometry they believed structured light, breath, and electrical charge alike."
    rowan "They believed that if they could agitate the luminiferous Aether at the precise resonant frequency, they could render the universe as a conductive, informational medium. A field with memory."
    rowan "The candle flames in the room trembled. The glass sang at a frequency no one had named."
    rowan "Their records suggest the experiment succeeded. Not in the way they expected."
    
    # Cut to Harrow's desk
    rowan "After the final experiment, Richmond House was sealed. The occupants vanished. The archive survived as fragments—untouched for more than a century."
    rowan "Dr. Charles Harrow spent the last two years assembling those fragments. His footnotes tracked a specific variable across all their diaries: a sustained frequency of 1985 Hertz."
    rowan "He realized they hadn't just theorized about Faraday's field. They had built a functioning Aetheric Engine."
    rowan "And he believed he could turn it back on."
    
    rowan "His footnotes stopped citing historical context. Instead, they became lists of material stress-tests. The tensile strength of modern copper wire. The acoustic properties of gutta-percha."
    rowan "He wasn't annotating the engine anymore. He was pricing out the parts."
    rowan "I was brought in to prepare Harrow's edition for publication. Clean up the manuscript. Make sure the citations existed. One of them didn't."
    rowan "Harrow repeatedly references a memorandum written by Professor Bell. Dozens of times. He calls it the Thirty-Third Secret. But it isn't in the files. My supervisor told me to mark it as missing and move on."
    rowan "But I know what unshielded high-voltage discharge and acute ozone toxicity can do to a human nervous system. Harrow didn't just lose a document."
    rowan "I booked a train. I told my supervisor I was chasing a misplaced citation."

    jump beat_2_arrival

label beat_2_arrival:
    ## ── BEAT 2: THE ARRIVAL ──
    scene bg_hallway with dissolve # Placeholder for 5th floor brutalist apartment
    
    play music city_traffic fadein 2.0
    
    "The fifth-floor hallway of a brutalist city apartment block. Harsh fluorescent light."
    
    "Rowan pulls on the front door handle. The handle clunks, but the door does not budge. The wood actually bows inward slightly."
    
    rowan "It's not locked. It feels like pulling against a vacuum. The pressure inside must be massive."
    
    "Heavy, industrial rubber gaskets have been retrofitted along the seams, like a laboratory clean-room."
    
    rowan "He retrofitted the doorframe. It's completely airtight."
    
    "A heavy, brass and gutta-percha delivery hatch is built into the bottom of the door. Above it is a note taped directly over the vacuum seal. The handwriting is jagged."
    
    "DOCUMENT: 'Deliveries: TURN BRASS VALVES UNTIL THEY SCREAM. DO NOT TOUCH THE WOOD.'"
    
    rowan "Valves? Why does a mail slot have pressure valves?"
    
    "Rowan turns the brass valves."
    
    stop music
    play treble treble_1985
    play infrasonic infrasonic_throb
    
    "The ambient hallway noise cuts out instantly. The air forces its way through the valve, shrieking at a piercing treble—exactly 1985 Hz. Beneath it, completely decoupled from the high pitch, is a sickening infrasonic throb vibrating from inside the apartment, creating physical pressure in the chest."
    
    rowan "My ears popped. The sound isn't coming from outside. It's coming from the brass."
    
    "She clicks the main door again. It swings open effortlessly. Rowan steps into the sparse apartment. Behind her, the heavy front door SLAMS shut. The deadbolt doesn't click; instead, the door seals with a sickening, airtight suction."
    
    rowan "The deadbolt didn't engage. The door just sealed itself."
    rowan "No broken air conditioner draws a vacuum strong enough to warp a doorframe. He hooked Bell's acoustic engine directly into the apartment's architecture. That is not a preservation choice. That is panic."

    # End of immediate port for execution loop.
    return
