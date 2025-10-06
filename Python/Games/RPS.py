import random as r

playerWins = 0
enemyWins = 0
ties = 0

plays = ['Pedra', 'Paper', 'Tissores', 'Llangardaix', 'Spock']

def enemyChoice():
    chosenPlay = r.choice(plays)
    print(f"L'oponent ha jugat {chosenPlay}!")
    return chosenPlay

def playerChoice():
    valid = False
    while not valid:
        print("Què vols jugar?")
        for i, value in enumerate(plays):
            print(f"{i+1} - {value}")
        try:
            chosenPlay = int(input())
            if chosenPlay > len(plays):
                raise ValueError
            valid = True
        except:
            print("Selecció invàlida!")
    return plays[chosenPlay-1]

def result(p, e):
    global playerWins, enemyWins, ties
    if p == e:
        ties += 1
        print("Empat!")
    else:
        if p == "Pedra":
            if e in ["Tissores", "Llangardaix"]:
                playerWins += 1
                print("Tu guanyes!")
            else:
                enemyWins += 1
                print("L'oponent guanya!")
        elif p == "Paper":
            if e in ["Pedra", "Spock"]:
                playerWins += 1
                print("Tu guanyes!")
            else:
                enemyWins += 1
                print("L'oponent guanya!")
        elif p == "Tissores":
            if e in ["Paper", "Llangardaix"]:
                playerWins += 1
                print("Tu guanyes!")
            else:
                enemyWins += 1
                print("L'oponent guanya!")
        elif p == "Llangardaix":
            if e in ["Spock", "Paper"]:
                playerWins += 1
                print("Tu guanyes!")
            else:
                enemyWins += 1
                print("L'oponent guanya!")
        elif p == "Spock":
            if e in ["Tissores", "Pedra"]:
                playerWins += 1
                print("Tu guanyes!")
            else:
                enemyWins += 1
                print("L'oponent guanya!")
    
    print(f"Tu: {playerWins}\nOponent: {enemyWins}")

def main():
    global playerWins, enemyWins, ties
    while playerWins < 3 and enemyWins < 3:
        player = playerChoice()
        enemy = enemyChoice()
        result(player, enemy)

if __name__ == '__main__': 
    main()