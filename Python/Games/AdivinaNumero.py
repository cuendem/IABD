import sys
import random as r

def main():
    n = r.randint(1, 10)
    print("Endevina el número!")
    tries = 3
    while tries > 0:
        try:
            guess = int(input("Quin vols endevinar? "))
        except:
            print("Número invàlid!")
            continue

        if guess == n:
            print(f"Felicitats! Era el {n}!")
            sys.exit()
        elif guess < n:
            print(f"No! El número és més gran que {guess}!")
        else:
            print(f"No! El número és més petit que {guess}!")
        tries -= 1
        print(f"Et qued{'a' if tries == 1 else 'en'} {tries} intent{'' if tries == 1 else 's'}!")
    print("T'has quedat sense intents!")

if __name__ == '__main__': 
    main()