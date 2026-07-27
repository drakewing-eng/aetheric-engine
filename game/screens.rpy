## screens.rpy — The Aetheric Engine
## Custom screen overrides — textbox, menus, UI

##############################################################################
## Say screen — dialogue display
## Overrides the default floating text to give it a solid dark backdrop
##############################################################################

screen say(who, what):
    style_prefix "say"

    window:
        id "window"

        if who is not None:
            window:
                id "namebox"
                style "namebox"
                text who id "who"

        text what id "what"


style window is default:
    xalign 0.5
    xfill True
    yalign 1.0
    ysize 220
    background Frame(Solid("#0e0c09ee"), 0, 0, 0, 0)
    top_padding 12
    bottom_padding 20
    left_padding 60
    right_padding 60

style say_dialogue is default:
    xpos 0
    xsize None
    ypos 0
    text_align 0.0
    layout "subtitle"

style namebox is default:
    xpos gui.name_xpos
    xanchor 0.0
    xsize gui.namebox_width
    ypos gui.name_ypos
    ysize gui.namebox_height
    background Frame(Solid("#1a160fee"), 8, 4, 8, 4)
    top_padding 4
    bottom_padding 4
    left_padding 16
    right_padding 16

style say_label is default:
    color gui.accent_color
    size gui.name_text_size

##############################################################################
## Choice menu — philosophical choice buttons
##############################################################################

screen choice(items):
    style_prefix "choice"

    vbox:
        for i in items:
            textbutton i.caption action i.action

style choice_vbox is vbox:
    xalign 0.5
    ypos 405
    yanchor 0.5
    spacing gui.choice_spacing

style choice_button is button:
    xsize 900
    background Frame(Solid("#1a160fd0"), 20, 12)
    hover_background Frame(Solid("#2e2514dd"), 20, 12)
    padding (30, 16, 30, 16)

style choice_button_text is button_text:
    color "#b8a882"
    hover_color "#e8c87a"
    selected_color gui.accent_color
    size gui.text_size
    xalign 0.5
    text_align 0.5
    layout "subtitle"

##############################################################################
## Main menu
##############################################################################

screen main_menu():
    tag menu

    add "images/bg_apartment.png":
        fit "cover"
        xalign 0.5
        yalign 0.5

    ## Dark overlay
    add Solid("#0d0b08b0")

    vbox:
        xalign 0.5
        yalign 0.45
        spacing 30

        text "The Aetheric Engine":
            xalign 0.5
            color "#c8a96e"
            size 72
            font "DejaVuSans.ttf"

        text "":
            size 12

        text "A Deveraux Archive Investigation":
            xalign 0.5
            color "#8a7f72"
            size 26
            italic True

    vbox:
        xalign 0.5
        yalign 0.75
        spacing 20

        textbutton "Begin":
            xalign 0.5
            xsize 300
            background Frame(Solid("#1a160fd0"), 20, 12)
            hover_background Frame(Solid("#2e2514dd"), 20, 12)
            padding (30, 14)
            text_color "#c8a96e"
            text_hover_color "#e8c87a"
            text_size 28
            text_xalign 0.5
            action Start()

        textbutton "Quit":
            xalign 0.5
            xsize 300
            background Frame(Solid("#0e0c09cc"), 20, 12)
            hover_background Frame(Solid("#1a160fdd"), 20, 12)
            padding (30, 14)
            text_color "#6e6459"
            text_hover_color "#8a7f72"
            text_size 24
            text_xalign 0.5
            action Quit()
