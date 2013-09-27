html ="<div class=\"card\"><h3>Test Card {id}</h3><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>"
cards = []

draggedCard = undefined

class Card
  constructor: (id)->
    cards.push this
    @id = id
    @index = @id
    @el = $(html.replace('{id}', id)).appendTo '#container'

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
    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.clientX, event.clientY)
    @originalMouseX = mousePosition.x
    @originalMouseY = mousePosition.y

  onMouseUp: () ->
    return unless draggedCard && draggedCard.id == @id
    @css3FadeIn()
    draggedCard = undefined
    @el.removeClass 'dragged'
    @el.css 'top', 'auto'
    @el.css 'left', 'auto'
    $('body').removeClass 'dragOn'

  onMouseMove: (event) ->
    return unless draggedCard && draggedCard.id == @id

    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.pageX, event.pageY)
    originalTopPosition = @el.position().top
    if @reorderIfNeeded()
      console.log ('reordering');
      card.getIndexFromDom() for card in cards
      delta = @el.position().top - originalTopPosition
      @originalMouseY = mousePosition.y

    @el.css 'top', mousePosition.y - @originalMouseY
    @el.css 'left', mousePosition.x - @originalMouseX


  setIsTopmostHovered: (topmostHoveredCardIndex) ->
    lastTopmostHovered = @isTopmostHovered
    @isTopmostHovered = topmostHoveredCardIndex is @index

    return unless lastTopmostHovered isnt @isTopmostHovered
    @el.addClass 'hovered' if @isTopmostHovered
    @el.removeClass 'hovered' unless @isTopmostHovered

  reorderIfNeeded: (mousePosition) ->
    topPositions = []
    myTopPosition = @el.position().top
    for card in cards
      topPositions[card.index] = card.el.position().top

    if topPositions[@index - 1] > myTopPosition
      @el.insertBefore @el.prev()
      return true

    if topPositions[@index + 1] < myTopPosition && topPositions[@index + 1]
      @el.insertAfter @el.next()
      return true
    return false

  getIndexFromDom: () ->
    @index = index for element, index in $('#container .card') when element is @el.get(0)

  css3FadeIn: () ->
    @el.addClass('faderBaseClass')
    delay 0, () =>
      @el.addClass 'faderShowClass'
    delay 200, () =>
      @el.removeClass 'faderShowClass'
      @el.removeClass 'faderBaseClass'

delay = (ms, func) -> setTimeout func, ms
$ ->
  innerCursor = $ '#inner-cursor'
  window.container= $ '#container'
  new Card(i) for i in [0...8]

  window.onmousedown = (event) ->
    card.onMouseDown(event) for card in cards

  window.onmouseup = (event) ->
    card.onMouseUp(event) for card in cards

  window.onmousemove = (event) ->
    mousePosition = webkitConvertPointFromPageToNode container.get(0), new WebKitPoint(event.pageX, event.pageY)
    innerCursor.css 'left', mousePosition.x
    innerCursor.css 'top', mousePosition.y

    topmostHoveredCardIndex = Math.max (card.index for card in cards when card.isHoveredByEvent event )...
    card.setIsTopmostHovered(topmostHoveredCardIndex) for card in cards

    card.onMouseMove(event) for card in cards




