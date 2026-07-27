################################################################################
## gui.rpy — The Aetheric Engine visual theme
## Victorian-gothic dark. Aged gold on near-black.
################################################################################

init -2 python:
    gui.init(1280, 720)

## Core palette
define gui.accent_color = "#c8a96e"           # aged gold
define gui.idle_color = "#8a7f72"             # muted warm grey
define gui.idle_small_color = "#6e6459"       # darker muted
define gui.hover_color = "#e8c87a"            # brighter gold on hover
define gui.selected_color = "#c8a96e"         # gold when selected
define gui.insensitive_color = "#3a3530"      # nearly invisible when disabled
define gui.muted_color = "#3d3428"            # very muted gold
define gui.hover_muted_color = "#4a4030"      # slightly more visible

## Text colors
define gui.text_color = "#ddd8cc"             # warm ivory — dialogue text
define gui.interface_text_color = "#c8a96e"   # gold — UI labels
define gui.interface_accent_color = "#c8a96e"

## Backgrounds
define gui.main_menu_background = "images/bg_title.png"
define gui.game_menu_background = "images/bg_title.png"

## Fonts
## These use Ren'Py's built-in DejaVu — swap for custom fonts later
define gui.default_font = "DejaVuSans.ttf"
define gui.interface_font = "DejaVuSans.ttf"
define gui.glyph_font = "DejaVuSans.ttf"
define gui.name_text_font = "DejaVuSans.ttf"

## Font sizes
define gui.text_size = 24
define gui.name_text_size = 30
define gui.interface_text_size = 24
define gui.label_text_size = 28
define gui.notify_text_size = 20
define gui.title_text_size = 64

## Dialogue box
define gui.textbox_height = 195
define gui.textbox_yalign = 1.0

## Name label
define gui.name_xpos = 295
define gui.name_ypos = 0
define gui.name_xalign = 0.0
define gui.namebox_width = None
define gui.namebox_height = None
define gui.namebox_borders = Borders(5, 5, 5, 5)
define gui.namebox_tile = False

## Dialogue text position
define gui.dialogue_xpos = 268
define gui.dialogue_ypos = 50
define gui.dialogue_width = 744
define gui.dialogue_text_xalign = 0.0

## Buttons
define gui.button_width = None
define gui.button_height = None
define gui.button_tile = False
define gui.button_text_font = gui.interface_font
define gui.button_text_size = gui.interface_text_size
define gui.button_text_idle_color = gui.idle_color
define gui.button_text_hover_color = gui.hover_color
define gui.button_text_selected_color = gui.accent_color
define gui.button_text_insensitive_color = gui.insensitive_color

define gui.button_text_xalign = 0.5

## Choice menus — the philosophical choice buttons
define gui.choice_button_width = 820
define gui.choice_button_height = None
define gui.choice_button_tile = False
define gui.choice_button_borders = Borders(150, 8, 150, 8)
define gui.choice_button_text_font = gui.default_font
define gui.choice_button_text_size = gui.text_size
define gui.choice_button_text_xalign = 0.5
define gui.choice_button_text_idle_color = "#b8a882"
define gui.choice_button_text_hover_color = "#e8c87a"

## Bars
define gui.bar_size = 36
define gui.scrollbar_size = 12
define gui.slider_size = 36
define gui.bar_tile = False
define gui.scrollbar_tile = False
define gui.slider_tile = False

## Spacing
define gui.pref_spacing = 15
define gui.pref_button_spacing = 0
define gui.page_spacing = 0
define gui.slot_spacing = 15
define gui.main_menu_spacing = 20

## Panels
define gui.game_menu_ypos = 144
define gui.confirm_frame_borders = Borders(60, 60, 60, 60)
define gui.confirm_insensitive_color = "#6e6459"

## Notify (small popup messages)
define gui.notify_xpos = 68
define gui.notify_ypos = 68
define gui.choice_spacing = 33

define gui.navigation_spacing = 6
define gui.pref_spacing = 15
define gui.pref_button_spacing = 0
