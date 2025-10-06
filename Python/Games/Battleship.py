import random as r

# Define board size and boards
rows, cols = 10, 10

playerBoard = [['.' for _ in range(cols)] for _ in range(rows)]
enemyBoard = [['.' for _ in range(cols)] for _ in range(rows)]
discoveredEnemyBoard = [['.' for _ in range(cols)] for _ in range(rows)]

# Dictionary of ships and their lengths
ships = {
    'Carrier': 5,
    'Battleship': 4,
    'Destroyer': 3,
    'Submarine': 3,
    'Patrol Boat': 2
}

def can_place(board, i, j, size, direction):
    di, dj = direction
    cells = []
    for k in range(size):
        ni, nj = i + di*k, j + dj*k # step through each segment of the ship

        # Check if within board boundaries
        if not (0 <= ni < len(board) and 0 <= nj < len(board[0])):
            return None

        # Check if cell is empty
        if board[ni][nj] != '.':
            return None

        cells.append((ni, nj))
    return cells

def setupShips(board):
    for ship, size in ships.items():
        initial = ship[0].upper()
        placed = False

        # Repeat until the current ship is successfully placed
        while not placed:
            # Choose a random starting cell
            i = r.randrange(len(board))
            j = r.randrange(len(board[0]))

            # Possible directions: right, down, left, up
            directions = [(0,1), (1,0), (0,-1), (-1,0)]
            r.shuffle(directions)

            # Try each direction until one works
            for d in directions:
                cells = can_place(board, i, j, size, d)
                if cells:
                    # valid placement found
                    for (ni, nj) in cells:
                        board[ni][nj] = initial
                    placed = True
                    break

def printSeparator(board):
    return "=" * (len(board[0]) * 4 + 10)

def printBoards():
    cols = len(playerBoard[0])
    rows = len(playerBoard)

    # Titles
    print(f"{'Player Board':<{cols*2+8}}{'Discovered Enemy Board':<{cols*2+4}}")

    # Header with column numbers
    header = "   " + " ".join(str(i) for i in range(cols))
    print(header + "      " + header)

    # Separator line
    print(printSeparator(playerBoard))

    # Rows with both boards
    for i in range(rows):
        left = f"{i:<2} {' '.join(playerBoard[i])}"
        right = f"{i:<2} {' '.join(discoveredEnemyBoard[i])}"
        print(f"{left:<{cols*2+8}}{right}")

    # Final separator
    print(printSeparator(playerBoard))

def countRemainingShips(board):
    shipSum = 0
    for row in board:
        for col in row:
            if col != '.' and col != 'X':
                shipSum += 1
    return shipSum

def playerTurn():
    print("Your turn...")
    validMove = False
    while not validMove:
        try:
            coordinates = list(map(int, input("Which cell do you want to hit? Input it as X,Y (Ex: 2,3 or 7,0): ").replace(' ','').split(',')))
            if not coordinates[0] in range(rows) or not coordinates[1] in range(cols):
                raise ValueError
            validMove = True
        except:
            print("Invalid move!")
    print()

    if enemyBoard[coordinates[1]][coordinates[0]] == '.':
        print("Miss!")
        discoveredEnemyBoard[coordinates[1]][coordinates[0]] = 'o'
    else:
        hitShip = enemyBoard[coordinates[1]][coordinates[0]]
        enemyBoard[coordinates[1]][coordinates[0]] = 'X'
        discoveredEnemyBoard[coordinates[1]][coordinates[0]] = 'X'

        remainingShips = sum(s.count(hitShip) for s in enemyBoard)

        if remainingShips > 0:
            print("Hit!")
        else:
            ship = [ship for ship in ships.keys() if ship[0] == hitShip][0]
            print(f"Hit and sunk! You sunk the opponent's {ship}!")

def enemyTurn():
    print("Enemy's turn...")
    i = r.randrange(len(playerBoard))
    j = r.randrange(len(playerBoard[0]))

    if playerBoard[i][j] == '.':
        print(f"Opponent attacks ({j},{i})! Miss!")
    else:
        hitShip = playerBoard[i][j]
        playerBoard[i][j] = 'X'

        remainingShips = sum(s.count(hitShip) for s in playerBoard)

        if remainingShips > 0:
            print(f"Opponent attacks ({j},{i})! Hit!")
        else:
            ship = [ship for ship in ships.keys() if ship[0] == hitShip][0]
            print(f"Opponent attacks ({j},{i})! Hit and sunk! They sunk your {ship}!")

    printBoards()

def checkEnd():
    return countRemainingShips(enemyBoard) == 0 or countRemainingShips(playerBoard) == 0

def main():
    setupShips(enemyBoard)
    setupShips(playerBoard)
    printBoards()

    while True:
        playerTurn()
        enemyTurn()
        if checkEnd():
            break

    if countRemainingShips(enemyBoard) == 0:
        print("You won!")
    else:
        print("You lost...")

if __name__ == '__main__': 
    main()