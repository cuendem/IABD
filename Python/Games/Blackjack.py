import random

deck = []
dealer = []
player = []
dealerScore = 0
playerScore = 0
money = 0
bet = 0

playerStood = False
playerBusted = False
playerBlackjack = False
dealerStood = False
dealerBusted = False
dealerBlackjack = False
playerSurrendered = False

def addRank(deck, rank):
    rankLetter = rank
    if rank == 11:
        rankLetter = 'J'
    elif rank == 12:
        rankLetter = 'Q'
    elif rank == 13:
        rankLetter = 'K'
    elif rank == 14:
        rankLetter = 'A'
    for suit in ('♠️', '♥️', '♣️', '♦️'):
        deck.append(f"{rankLetter}{suit}")

def shuffleDeck(deck):
    for rank in range(2, 15):
        addRank(deck, rank)
    random.shuffle(deck)

def dealCard(hand, score):
    newCard = deck.pop()
    hand.append(newCard)

    rank = newCard[:-2]
    if rank == 'A':
        score += 11 if score + 11 <= 21 else 1
    elif rank in ('J', 'Q', 'K'):
        score += 10
    else:
        score += int(rank)
    return newCard, score

def initialMoney():
    global money

    while True:
        startingMoney = input("How much money do you want to start with? (Default: 20€) ")
        if startingMoney == "":
            startingMoney = 20
        else:
            try:
                startingMoney = int(startingMoney)
            except ValueError:
                print("Invalid selection, not an int")
                continue
        break

    money = startingMoney

def initialBet():
    global money, bet

    while True:
        newBet = input("How much do you want to bet? (Default: 5€) ")
        if newBet == "":
            newBet = 5
        else:
            try:
                newBet = float(newBet)
            except ValueError:
                print("Invalid selection, not a number")
                continue

        if newBet > money or newBet == 0:
            print("You can't bet that!")
            continue

        break

    bet = newBet
    money -= bet
    print(f"You have bet {bet}€! (you have {money}€ left)")

def initialDeal():
    global dealer, player, dealerScore, playerScore
    global playerStood, playerBusted, playerBlackjack
    global dealerStood, dealerBusted, dealerBlackjack
    global playerSurrendered

    dealer = []
    player = []
    dealerScore = 0
    playerScore = 0

    playerStood = False
    playerBusted = False
    playerBlackjack = False
    dealerStood = False
    dealerBusted = False
    dealerBlackjack = False
    playerSurrendered = False

    shuffleDeck(deck)
    initialBet()

    d1, dealerScore = dealCard(dealer, dealerScore)

    p1, playerScore = dealCard(player, playerScore)
    p2, playerScore = dealCard(player, playerScore)

    print(f"The dealer has {d1}  ({dealerScore} points)")
    print(f"You have {p1}  and {p2}  ({playerScore} points)")

def detectSplit(hand):
    if len(hand) != 2:
        return False
    return hand[0][:-2] == hand[1][:-2]

def playerTurn():
    global playerScore, playerBusted, playerStood, playerBlackjack, money, bet, playerSurrendered
    print("It's your turn...")

    possibleChoices = {1: "Hit", 2: "Stand"}
    if len(player) <= 2:
        possibleChoices.update({3: "Double down", 4: "Split", 5: "Surrender"})

    print("What do you want to do?")
    for k, v in possibleChoices.items():
        print(f"{k} - {v}")

    try:
        choice = int(input())

        if choice not in possibleChoices.keys():
            print("Invalid selection, not a possible choice")
            return

    except ValueError:
        print("Invalid selection, not an int")
        return

    if choice == 1:
        # Hit
        card, playerScore = dealCard(player, playerScore)
        print(f"You are dealt: {card}  ({playerScore} points)")
        if playerScore > 21:
            print("You busted!")
            playerBusted = True
        elif playerScore == 21:
            print("Wow! You got a Blackjack!")
            playerBlackjack = True

    elif choice == 2:
        # Stand
        if playerScore == 21:
            print("Incredible! You started with a Blackjack!")
            playerBlackjack = True
        else:
            print(f"You stand with {playerScore} points.")
            playerStood = True

    elif choice == 3:
        # Double down
        if money < bet:
            print("You can't afford to double down!")
        else:
            money -= bet
            bet *= 2

            print(f"You double down! Your bet is now {bet}€!")

            card, playerScore = dealCard(player, playerScore)
            print(f"You are dealt: {card}  ({playerScore} points)")
            if playerScore > 21:
                print("You busted!")
                playerBusted = True
            elif playerScore == 21:
                print("Wow! You got a Blackjack!")
                playerBlackjack = True
            else:
                print(f"You stand with {playerScore} points.")
                playerStood = True

    elif choice == 4:
        # Split
        if not detectSplit(player):
            print("You can't split with that hand!")
            return
        else:
            print("You split!")
            print("!! WIP YOU CANNOT SPLIT YET !!")
            return

    elif choice == 5:
        # Surrender
        money += bet / 2
        print(f"You surrender. You now have {money}€ (lost {bet/2}€)")
        playerSurrendered = True

    print("Your turn is over!")
    return True

def dealerTurn():
    global dealerScore, dealerBusted, dealerStood, dealerBlackjack
    print("It's the dealer's turn...")

    if dealerScore == 21:
        print("Incredible! The dealer started with a Blackjack!")
        dealerBlackjack = True
    elif dealerScore < 17:
        card, dealerScore = dealCard(dealer, dealerScore)
        print(f"The dealer draws: {card}  ({dealerScore} points)")
        if dealerScore > 21:
            print("The dealer busted!")
            dealerBusted = True
        elif dealerScore == 21:
            print("Wow! The dealer got a Blackjack!")
            dealerBlackjack = True
        elif dealerScore >= 17:
            print(f"The dealer stands with {dealerScore} points.")
            dealerStood = True
    else:
        print(f"The dealer stands with {dealerScore} points.")
        dealerStood = True

def checkTable():
    if dealerBlackjack:
        if playerBlackjack:
            print(f"You both got a Blackjack! It's a tie! You win back {bet}€.")
            return True, bet
        else:
            print("The dealer wins with a Blackjack!")
            return True, 0

    if playerBlackjack:
        print(f"You got a Blackjack! You win {bet*3}€!")
        return True, bet*3

    if playerBusted:
        print("You lose!")
        return True, 0

    if dealerBusted:
        print(f"You win {bet*2}€!")
        return True, bet*2

    if playerStood and dealerStood:
        if playerScore > dealerScore:
            print(f"Your {playerScore} points win against the dealer's {dealerScore}! You win {bet*2}€!")
            return True, bet*2
        elif playerScore < dealerScore:
            print(f"The dealer's {dealerScore} points beat your {playerScore}! You lose!")
            return True, 0
        else:
            print(f"It's a tie! You win back {bet}€.")
            return True, bet

    if playerSurrendered:
        return True, 0

    return False, 0

def main():
    global money, bet

    initialMoney()
    initialDeal()

    while True:
        while not playerBusted and not playerStood and not playerBlackjack and not playerSurrendered:
            playerTurn()
        if not playerSurrendered and not playerBusted:
            while not dealerBlackjack and not dealerBusted and not dealerStood:
                dealerTurn()
        over, payout = checkTable()
        money += payout
        choice = input(f"Want to play again? You have {money}€ (Y/N) ")
        if choice.lower() == "y":
            initialDeal()
        else:
            print("See you soon!")
            break

if __name__ == '__main__': 
    main()