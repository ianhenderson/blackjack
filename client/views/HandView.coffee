class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)<% if(standing){ %> <b>Stand</b><% } if(isBust){ %> <b>BUSTED</b><% } %></h2> '

  initialize: ->
    @collection.on 'add remove change bust stand', => @render()
    @render()

  render: ->
    # debugger;
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

