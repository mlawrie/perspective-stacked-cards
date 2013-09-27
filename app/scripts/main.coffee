html ="<div class=\"card\"><h3>Test Card</h3><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>"
cards = []

class Card
  constructor: (id)->
    cards.push this
    @id = id
    @el = $(html).appendTo '#container'

  isHoveredByEvent: (event) ->
    mousePosition = webkitConvertPointFromPageToNode @el.get(0), new WebKitPoint(event.clientX, event.clientY)
    return if mousePosition.x < 0 || mousePosition.x > @el.width()
    return if mousePosition.y < 0 || mousePosition.y > @el.height()
    true

  setIsTopmostHovered: (topmostHoveredCardId) ->
    lastTopmostHovered = @isTopmostHovered
    @isTopmostHovered = topmostHoveredCardId == @id

    if lastTopmostHovered != @isTopmostHovered
      @el.addClass 'hovered' if @isTopmostHovered
      @el.removeClass 'hovered' unless @isTopmostHovered

$ ->
  innerCursor = $ '#inner-cursor'
  container= $ '#container'
  new Card(i) for i in [0...8]

  window.onmousemove = (event)->
    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.clientX, event.clientY)
    innerCursor.css 'left', mousePosition.x
    innerCursor.css 'top', mousePosition.y


    topmostHoveredCardId = Math.max (card.id for card in cards when card.isHoveredByEvent event )...
    card.setIsTopmostHovered(topmostHoveredCardId) for card in cards





