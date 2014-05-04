#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize:(deck) ->
    debugger;
    @endgame = false
    deck = deck || new Deck()
    @set 'deck', deck
    @set 'playerHands', [deck.dealPlayer()]
    @set 'dealerHands', [deck.dealDealer()]

    @get('playerHands')[0].on 'splittable', =>
      trigger('splittable', @)

    self = @
    @get('playerHands')[0].on 'bust stand', =>
      self.dealersTurn()

  dealersTurn: ->
    self = @
    dealerHit = () ->
        setTimeout ( ->
          if self.get('dealerHands')[0].scores()[0] < 17
            self.get('dealerHands')[0].hit()
            do dealerHit
          else
            self.endGame()
          ) , 1000

    setTimeout (->
      self.get('dealerHands')[0].models[0].flip()
      do dealerHit) , 1000

  endGame:  ->
    # get playerHands scores and compare to dealerHands scores
    playerScores = @get('playerHands')[0].scores()
    dealerScores = @get('dealerHands')[0].scores()

    pScore = if playerScores[1] is undefined or playerScores[1] > 21  then playerScores[0] else playerScores[1]
    dScore = if dealerScores[1] is undefined or dealerScores[1] > 21  then dealerScores[0] else playerScores[1]
    if pScore == 21 or (pScore < 22 && dScore > 21) or(pScore > dScore and pScore < 22 )
      @endgame = 'youwin'
    else if pScore == dScore
      @endgame = 'youtied'
    else @endgame = 'youlose'
    console.log(@endgame)
    @trigger 'endgame', this
