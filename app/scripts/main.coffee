html ="<div class=\"card\"><h3>Test Card</h3><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>"

cards = []

class Card
  constructor: ()->
    cards.push this
    @el = $(html).appendTo '#container'
$(->

  new Card for i in [0...8]

  card.transform() for card in cards
)



