import random as r

board = [[' ' for _ in range(3)] for _ in range(3)]
playerIcon = ' '
enemyIcon = ' '

def printBoard():
    print(f"  {' '.join(str(i) for i in range(3))}")
    for i, row in enumerate(board):
        print(f"{i} {' '.join(row)}")

def playerPlay():
    print("It's your turn!")

    validPlay = False
    while not validPlay:
        try:
            coordinates = list(map(int, input("Which cell do you want to mark? Input it as X,Y (Ex: 0,1 or 2,0): ").replace(' ','').split(',')))
            if board[coordinates[1]][coordinates[0]] != " ":
                raise ValueError
            validPlay = True
        except:
            print("That play is invalid!")

    board[coordinates[1]][coordinates[0]] = playerIcon
    printBoard()

def enemyPlay():
    print("It's the enemy's turn!")
    played = False
    while not played:
        x = r.randrange(3)
        y = r.randrange(3)

        if board[y][x] == " ":
            board[y][x] = enemyIcon
            played = True
    printBoard()

def checkWinningPositions(icon):
    # Rows
    for row in board:
        if all(cell == icon for cell in row):
            return True
    # Columns
    for c in range(3):
        if all(board[r][c] == icon for r in range(3)):
            return True
    # Diagonals
    if all(board[d][d] == icon for d in range(3)):
        return True
    if all(board[d][2 - d] == icon for d in range(3)):
        return True
    return False

def checkDraw():
    for r in board:
        for c in r:
            if c == " ":
                return False
    return True

def checkWinner():
    if checkWinningPositions(playerIcon):
        return "You"
    elif checkWinningPositions(enemyIcon):
        return "The opponent"
    elif checkDraw():
        return "Tie! No one"
    else:
        return False

def main():
    global playerIcon, enemyIcon

    playerIcon = r.choice(['X', 'O'])
    enemyIcon = 'O' if playerIcon == 'X' else 'X'

    print(f"You are {playerIcon}! The opponent is {enemyIcon}!")
    printBoard()
    if enemyIcon == 'X':
        enemyPlay()

    over = False
    while not over:
        playerPlay()
        if not checkWinner():
            enemyPlay()
        over = checkWinner()

    print(f"{over} won!")

if __name__ == '__main__': 
    main()