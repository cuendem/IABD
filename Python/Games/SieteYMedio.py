import random

deck = []
player = []
dealer = []

def addRank(deck, rank):
    # Add 4 copies of a rank to the deck
    rankLetter = rank
    if rank == 8:
        rankLetter = 'J'
    elif rank == 9:
        rankLetter = 'Q'
    elif rank == 10:
        rankLetter = 'K'

    for suit in ('Ors', 'Copes', 'Espases', 'Bastos'):
        deck.append(f"{rankLetter} de {suit}")

def shuffleDeck(deck):
    # Shuffle the deck at the start of the game
    for rank in range(1, 11):
        addRank(deck, rank)

def drawCard(hand):
    # Draw a card from the deck to the hand
    newCard = random.choice(deck)
    hand.append(newCard)
    deck.remove(newCard)
    
    return newCard

def calculateScore(hand):
    # Calculate score from hand
    score = 0

    for card in hand:
        rank = card[0]

        if rank == 'J' or rank == 'Q' or rank == 'K':
            score += 0.5
        else:
            score += int(rank)

    return score

def showHand(hand):
    print("Mà:")
    for card in hand:
        print(card)
    print(f"Puntuació: {calculateScore(hand)}")

def playerTurn():
    stood, busted = False, False

    while True:
        choice = int(input("\nQuè vols fer?\n1 - Robar\n2 - Plantar-te\n\n"))
        if choice in [1, 2]:
            break
        print("Selecció invàlida.")

    if choice == 1:
        # Draw
        newCard = drawCard(player)
        print(f"Has robat el {newCard}!")
        showHand(player)
        if calculateScore(player) > 7.5:
            print("Has perdut!")
            busted = True

    elif choice == 2:
        # Stay
        print(f"T'has plantat amb {calculateScore(player)} punts!")
        stood = True

    else:
        print("Selecció desconeguda.")

    return stood, busted

def dealerTurn():
    stood, busted = False, False
    print("\nÉs el torn de la banca...")

    newCard = drawCard(dealer)
    print(f"La banca ha robat el {newCard}!")
    
    showHand(dealer)

    if calculateScore(dealer) >= 7.5:
        print("La banca ha perdut!")
        busted = True
    elif calculateScore(dealer) >= 5.5:
        print("La banca es planta!")
        stood = True
        
    return stood, busted

def game():
    newCard = drawCard(player)
    print(f"T'han repartit el {newCard}!")
    newCard = drawCard(dealer)
    print(f"La banca té el {newCard}!")
    
    playerStood = False
    dealerStood = False
    playerBusted = False
    dealerBusted = False

    while not (playerStood and dealerStood):
        if not playerStood:
            playerStood, playerBusted = playerTurn()
        if playerBusted:
            break
        if not dealerStood:
            dealerStood, dealerBusted = dealerTurn()
        if dealerBusted:
            break
    
    if playerStood and dealerStood:
        if calculateScore(player) > calculateScore(dealer):
            print("Has guanyat!")
        elif calculateScore(player) < calculateScore(dealer):
            print("Has perdut...")
        else:
            print("Empat!")

shuffleDeck(deck)
print(deck)
game()