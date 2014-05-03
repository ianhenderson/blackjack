#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    self = @
    @get('playerHand').on 'bust stand', =>
      # self;
      # debugger;
      dealerHit = () ->
          setTimeout ( ->
            if self.get('dealerHand').scores()[0] < 17
              self.get('dealerHand').hit()
              do dealerHit) , 1000


      setTimeout (->
        self.get('dealerHand').models[0].flip()
        do dealerHit) , 1000

    # this.get('playerHand').on('hit', function(){
    #   var scores = this.get('playerHand').get('scores');
    #   if ( scores > 21 ) {
    #     endGame(); // show all cards, calculate scores
    #   }
    # });
