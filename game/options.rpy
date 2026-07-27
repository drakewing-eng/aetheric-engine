## options.rpy — The Aetheric Engine
## Project configuration

define config.name = "The Aetheric Engine"
define config.version = "0.1-trial"

## The window icon
# define config.window_icon = "images/icon.png"

## Resolution — widescreen, cinematic
define config.screen_width = 1280
define config.screen_height = 720

## Framerate
define config.framerate = 60

## Saves
define config.save_directory = "aetheric-engine-saves"

## Skip settings
define config.has_autosave = True
define config.autosave_on_quit = True

## Transitions
define config.enter_transition = dissolve
define config.exit_transition = dissolve
define config.after_load_transition = None
define config.end_game_transition = None

## The default language
define config.language = None
