html ="<div class=\"card\"><h3>Test Card</h3><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>"
cards = []

draggedCard = undefined

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

  onMouseDown: (event) ->
    return unless @isTopmostHovered
    @css3FadeIn()
    draggedCard = @
    @el.addClass 'dragged'
    $('body').addClass 'dragOn'
    @lastMousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.clientX, event.clientY)

  onMouseUp: () ->
    return unless draggedCard && draggedCard.id == @id
    @css3FadeIn()
    draggedCard = undefined
    @el.removeClass 'dragged'
    @el.addClass('hidden').removeClass('hidden')
    @el.css 'top', 'auto'
    $('body').removeClass 'dragOn'

  onMouseMove: (event) ->
    return unless draggedCard && draggedCard.id == @id

    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.clientX, event.clientY)
    deltaX = mousePosition.x - @lastMousePosition.x
    deltaY = mousePosition.y - @lastMousePosition.y

    @el.css 'top', deltaY

  setIsTopmostHovered: (topmostHoveredCardId) ->
    lastTopmostHovered = @isTopmostHovered
    @isTopmostHovered = topmostHoveredCardId == @id

    return unless lastTopmostHovered != @isTopmostHovered
    @el.addClass 'hovered' if @isTopmostHovered
    @el.removeClass 'hovered' unless @isTopmostHovered

  css3FadeIn: () ->
    @el.addClass('faderBaseClass')
    setTimeout () =>
      @el.addClass 'faderShowClass'
      , 0
    setTimeout () =>
      @el.removeClass 'faderShowClass'
      @el.removeClass 'faderBaseClass'
      , 200

$ ->
  innerCursor = $ '#inner-cursor'
  window.container= $ '#container'
  new Card(i) for i in [0...8]

  window.onmousedown = (event) ->
    card.onMouseDown(event) for card in cards

  window.onmouseup = (event) ->
    card.onMouseUp(event) for card in cards

  window.onmousemove = (event) ->
    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.clientX, event.clientY)
    innerCursor.css 'left', mousePosition.x
    innerCursor.css 'top', mousePosition.y

    topmostHoveredCardId = Math.max (card.id for card in cards when card.isHoveredByEvent event )...
    card.setIsTopmostHovered(topmostHoveredCardId) for card in cards

    card.onMouseMove(event) for card in cards




