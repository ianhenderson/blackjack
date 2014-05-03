#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    self = @
    @get('playerHand').on 'bust stand', =>
      self.dealersTurn()

  dealersTurn: ->
    self = @
    dealerHit = () ->
        setTimeout ( ->
          if self.get('dealerHand').scores()[0] < 17
            self.get('dealerHand').hit()
            do dealerHit
          else
            self.endGame()
          ) , 1000

    setTimeout (->
      self.get('dealerHand').models[0].flip()
      do dealerHit) , 1000

  endGame:  ->
    # get playerHand scores and compare to dealerHand scores
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').scores()

    pScore = if playerScores[1] is undefined or playerScores[1] > 21  then playerScores[0] else playerScores[1]
    dScore = if dealerScores[1] is undefined or dealerScores[1] > 21  then dealerScores[0] else playerScores[1]
    if pScore == 21 or (pScore < 22 && dScore > 21) or(pScore > dScore and pScore < 22 ) then @trigger('youwin') else @trigger('youlose')
