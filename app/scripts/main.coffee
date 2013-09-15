html ="<div class=\"card\"><h3>Test Card</h3><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>"

cards = []

mouseX = 0;
mouseY = 0;

window.onmousemove = (event)->
  mouseX = event.clientX
  mouseY = event.clientY

class Card
  constructor: ()->
    cards.push this
    @el = $(html).appendTo '#container'

    t = this
    @el.mouseover (e)->
      t.hovered = true
      t.transform()
    @el.mouseout (e)->
      t.hovered = false
      t.transform()

  index: ()->
    cards.indexOf(this)
  transform: ()->
    @el.addClass 'hovered' if @hovered
    @el.removeClass 'hovered' unless @hovered

$(->

  new Card for i in [0...8]

  card.transform() for card in cards
)



