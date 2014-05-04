class window.AppView extends Backbone.View

  template: _.template '
    <div class="endgame-container"> <% if(this.model.endgame === "youlose"){
      %><img src="img/chun_li_cry.gif"></img><%
      } else if (this.model.endgame === "youwin"){
        %>YOU WIN!!!<%
      } else if (this.model.endgame === "youtied"){
        %>You tied...<%
      }
     %> </div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <% if (this.model.endgame){ %> <button class="newgame-button">New game</button> <button class="keeplosing-button">Keep losing?</button> <% } %>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHands')[0].hit()
    "click .stand-button": -> @model.get('playerHands')[0].stand()
    "click .keeplosing-button": -> debugger; @model.initialize(@model.get('deck'))
    "click .newgame-button": -> @model.initialize()

  initialize: ->
    @render()
    @model.on 'all', =>
      @render()



  render: ->
    @$el.children().detach()
    @$el.html @template()
    console.log(@model.get('playerHands')[0])
    @$('.player-hand-container').html new HandView(collection: @model.get('playerHands')[0]).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('dealerHands')[0]).el
